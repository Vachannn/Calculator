<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Calculation History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #282c34;
        }
        .calculator {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            text-align: center;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background: #f8f9fa;
            margin: 5px 0;
            padding: 10px;
            border-radius: 5px;
        }
        a {
            display: block;
            margin-top: 10px;
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <h2>Calculation History</h2>
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
        <a href="index.jsp">Back to Calculator</a>
    </div>
</body>
</html>
