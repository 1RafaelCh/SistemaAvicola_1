<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración - Avícola D&D</title>
    <link rel="stylesheet" href="../../recursos/css/sidebar.css">
</head>
<body>
    <div class="sidebar">
        <h3>🐔 Avícola D&D</h3>
        <a href="dashboard.jsp">🏠 Inicio</a>
        <a href="usuarios.jsp">👤 Usuarios</a>
        <a href="productos.jsp">📦 Productos</a>
        <a href="inventario.jsp">📊 Inventario</a>
        <a href="reportes.jsp">📈 Reportes</a>
        <a href="proveedores.jsp">🚚 Proveedores</a>
        <a href="../login.jsp">🚪 Cerrar sesión</a>
    </div>

    <div class="main-content">
        <h1>Bienvenido, Administrador</h1>
        <p>Desde este panel puedes gestionar usuarios, productos, inventario, reportes y proveedores.</p>

        <div class="card">
            <h2>Resumen general</h2>
            <ul>
                <li>Total de usuarios: 5</li>
                <li>Productos activos: 12</li>
                <li>Stock total: 250 unidades</li>
                <li>Ventas del día: S/ 350.00</li>
            </ul>
        </div>
    </div>
</body>
</html>
