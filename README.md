# Calculator

📌 Exception Handling in the Calculator
The calculator includes robust exception handling to prevent errors and ensure a smooth user experience.

🛑 Division by Zero Protection

If a user attempts to divide by zero (e.g., 5/0), the system throws an ArithmeticException.
Instead of crashing, the calculator displays "Error: Division by zero is not allowed." in the result field.
This check is implemented inside the evaluateExpression() method:
java
Copy
Edit
if (expression.contains("/0")) {
    throw new ArithmeticException("Division by zero is not allowed.");
}
🛑 Handling Invalid Inputs

If the user enters an invalid mathematical expression (e.g., 5++3 or abc+5), the calculator detects it and throws an Exception.
The user sees "Invalid Expression!" instead of an incorrect result.
🛑 Empty Input Validation

If the user submits an empty input, an IllegalArgumentException is thrown:
java
Copy
Edit
if (expression == null || expression.trim().isEmpty()) {
    throw new IllegalArgumentException("Expression cannot be empty.");
}
The user is informed with the error message "Error: Expression cannot be empty."
🛑 Safe Result Display

All errors are caught and stored in the result variable, ensuring that no unhandled exceptions crash the application.
The error messages are displayed directly in the calculator screen.




📌 Calculation History Feature

The calculator maintains a history of previous calculations using HTTP Sessions.

📝 How It Works

Every time a user performs a calculation, the result (or error message) is stored in a session attribute (history).
The history is saved across multiple calculations in the same session.
📥 Storing History

When a new calculation is performed, the servlet retrieves the history list from the session.
If the list is null (first-time use), it initializes a new ArrayList<String>.
The new result is added, and the session is updated:
java
Copy
Edit
HttpSession session = request.getSession();
ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");
if (history == null) {
    history = new ArrayList<>();
}
history.add(expression + " = " + (errorMessage == null ? result : errorMessage));
session.setAttribute("history", history);
📤 Displaying History

The history is displayed on a separate history.jsp page.
When the user clicks "View History", they see all past calculations.
The history is retrieved from the session and displayed as a list:
jsp
Copy
Edit
<ul>
    <%
        ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");
        if (history != null) {
            for (String record : history) {
                out.println("<li>" + record + "</li>");
            }
        }
    %>
</ul>
🔄 Session-Based Storage

The history persists as long as the session is active.
If the session ends (browser closed, user logs out), the history is cleared.
