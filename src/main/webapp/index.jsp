<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Avícola David & Daniel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="recursos/css/estilos.css">
    <style>
        body {
            background: linear-gradient(135deg, #ffe082, #fff8e1);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .inicio-container {
            text-align: center;
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.15);
            max-width: 500px;
        }
        .inicio-container img {
            width: 120px;
            margin-bottom: 20px;
        }
        .btn-danger {
            background-color: #c62828 !important;
            border: none;
        }
    </style>
</head>
<footer class="text-center mt-5 text-muted">
    <p>© 2025 Avícola David & Daniel — Todos los derechos reservados 🐥</p>
</footer>

<body>
    <div class="inicio-container">
        <!-- Logo (puedes poner tu imagen aquí) -->
        <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Logo Avícola">

        <h1 class="text-danger fw-bold">Avícola David & Daniel</h1>
        <p class="text-muted">Sistema Web de Gestión de Ventas y Control de Productos</p>

        <hr>

        <p>Bienvenido al sistema administrativo de nuestra avícola.  
        Aquí podrás gestionar productos, ventas y clientes según tu perfil de acceso.</p>

        <a href="vistas/login.jsp" class="btn btn-danger btn-lg mt-3">🔐 Iniciar Sesión</a>
    </div>
</body>
</html>
