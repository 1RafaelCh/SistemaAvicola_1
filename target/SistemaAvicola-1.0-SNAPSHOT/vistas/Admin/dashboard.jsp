<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath(); // ej: /SistemaAvicola_1
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración - Avícola D&D</title>
    <!-- siempre con contextPath para que el CSS cargue -->
    <link rel="stylesheet" href="<%=ctx%>/recursos/css/sidebar.css">
</head>
<body>
    <div class="sidebar">
        <h3>🐔 Avícola D&D</h3>
        <a href="<%=ctx%>/vistas/admin/dashboard.jsp">🏠 Inicio</a>
        <!-- Usuarios: ir por el servlet para listar con datos -->
        <a href="<%=ctx%>/UsuarioServlet?accion=listar">👤 Usuarios</a>
        <a href="<%=ctx%>/ProductoServlet?accion=listar">📦 Productos</a>
        <a href="<%=ctx%>/vistas/admin/inventario.jsp">📊 Inventario</a>
        <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
        <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
        <!-- Cerrar sesión: apunta al LogoutServlet -->
        <a href="<%=ctx%>/vistas/login.jsp">🚪 Cerrar sesión</a>
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


