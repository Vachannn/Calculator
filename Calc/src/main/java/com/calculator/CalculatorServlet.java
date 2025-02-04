package com.calculator;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle calculator operations.
 */
@WebServlet("/CalculatorServlet")
public class CalculatorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to the index.jsp page when accessed via GET
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String expression = request.getParameter("expression");
        double result = 0.0;
        String errorMessage = null;

        try {
            // Check if the expression is valid and non-empty
            if (expression == null || expression.trim().isEmpty()) {
                throw new IllegalArgumentException("Expression cannot be empty.");
            }

            result = evaluateExpression(expression); // Call evaluateExpression method to calculate result
        } catch (IllegalArgumentException | ArithmeticException e) {
            errorMessage = "Error: " + e.getMessage();
        } catch (Exception e) {
            errorMessage = "Invalid Expression!";
        }

        // Store history in session
        HttpSession session = request.getSession();
        ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");

        // Initialize history if it's null
        if (history == null) {
            history = new ArrayList<>();
        }

        // Add the new calculation to history
        if (errorMessage == null) {
            history.add(expression + " = " + result);
        } else {
            history.add(expression + " = " + errorMessage);
        }

        // Save the updated history back to the session
        session.setAttribute("history", history);

        // Forward result to index.jsp
        request.setAttribute("result", errorMessage == null ? result : errorMessage);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    /**
     * Evaluates a simple mathematical expression.
     */
    private double evaluateExpression(String expression) throws Exception {
        expression = expression.replaceAll("\\s+", ""); // Remove spaces

        // Handle division by zero
        if (expression.contains("/0")) {
            throw new ArithmeticException("Division by zero is not allowed.");
        }

        return evaluateBasicMath(expression);
    }

    /**
     * Evaluates a simple mathematical expression using manual parsing.
     */
    private double evaluateBasicMath(String expression) throws Exception {
        char operator = ' ';
        double num1 = 0, num2 = 0;
        boolean operatorFound = false;

        // Parse the expression and identify numbers and operators
        for (char ch : expression.toCharArray()) {
            if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
                operator = ch;
                operatorFound = true;
            } else if (!operatorFound) {
                num1 = num1 * 10 + (ch - '0');
            } else {
                num2 = num2 * 10 + (ch - '0');
            }
        }

        if (operator == ' ') {
            throw new Exception("Invalid Operator.");
        }

        // Perform the operation
        switch (operator) {
            case '+': return num1 + num2;
            case '-': return num1 - num2;   
            case '*': return num1 * num2;
            case '/': 
                if (num2 == 0) {
                    throw new ArithmeticException("Division by zero is not allowed.");
                }
                return num1 / num2;
            default: throw new Exception("Invalid Operator");
        }
    }
}
