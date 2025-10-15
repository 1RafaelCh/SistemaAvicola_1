<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Avícola David & Daniel</title>
    <link rel="stylesheet" href="../recursos/css/estilos.css">
    <style>
        body {
            background: #fff8e1;
            font-family: Arial, sans-serif;
        }
        .login-container {
            width: 320px;
            margin: 100px auto;
            padding: 25px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: #fff;
            text-align: center;
        }
        input {
            width: 90%;
            margin: 8px 0;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>? Iniciar Sesión</h2>
        <form action="../LoginServlet" method="post">
            <input type="email" name="email" placeholder="Correo electrónico" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
        </form>
        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">? Usuario o contraseña incorrectos.</p>
        <% } %>
    </div>
</body>
</html>
