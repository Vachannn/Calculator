<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculator</title>
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
        input {
            width: 100%;
            height: 50px;
            font-size: 24px;
            text-align: right;
            margin-bottom: 10px;
            color:red;
        }
        .buttons {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }
        button {
            height: 50px;
            font-size: 20px;
            background: #61dafb;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background: #21a1f1;
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
    <script>
        function appendValue(value) {
            document.getElementById("expression").value += value;
        }
        function clearDisplay() {
            document.getElementById("expression").value = "";
        }
        function calculate() {
            document.getElementById("calcForm").submit();
        }
    </script>
</head>
<body>
    <div class="calculator">
        <form id="calcForm" action="CalculatorServlet" method="post">
            <input type="text" id="expression" name="expression" value="<%= request.getAttribute("result") != null ? request.getAttribute("result") : "" %>" readonly>
            <div class="buttons">
                <button type="button" onclick="clearDisplay()">C</button>
                <button type="button" onclick="appendValue('7')">7</button>
                <button type="button" onclick="appendValue('8')">8</button>
                <button type="button" onclick="appendValue('9')">9</button>
                <button type="button" onclick="appendValue('+')">+</button>
                
                <button type="button" onclick="appendValue('4')">4</button>
                <button type="button" onclick="appendValue('5')">5</button>
                <button type="button" onclick="appendValue('6')">6</button>
                <button type="button" onclick="appendValue('-')">-</button>
                
                <button type="button" onclick="appendValue('1')">1</button>
                <button type="button" onclick="appendValue('2')">2</button>
                <button type="button" onclick="appendValue('3')">3</button>
                <button type="button" onclick="appendValue('*')">*</button>
                
                <button type="button" onclick="appendValue('0')">0</button>
                <button type="button" onclick="appendValue('.')">.</button>
                <button type="button" onclick="calculate()">=</button>
                <button type="button" onclick="appendValue('/')">/</button>
            </div>
        </form>
        <a href="history.jsp">View History</a>
    </div>
</body>
</html>
