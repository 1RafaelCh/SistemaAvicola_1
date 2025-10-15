<%@ page session="true" %>
<%
    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
    if (usuario == null || !"CLIENTE".equals(usuario.getNombreRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Panel Cliente</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../recursos/css/sidebar.css">
</head>
<body>
<div class="sidebar">
    <h3>? Cliente</h3>
    <a href="panel_cliente.jsp">? Inicio</a>
    <a href="productos.jsp">? Ver Productos</a>
    <a href="#">? Mis Compras</a>
    <a href="../LogoutServlet">? Cerrar sesión</a>
</div>

<div class="main-content">
    <h2>Hola, <%= usuario.getNombre() %> ?</h2>
    <p class="text-muted">Rol: <strong><%= usuario.getNombreRol() %></strong></p>

    <div class="card p-4">
        <h5>Bienvenido a la Avícola</h5>
        <p>Consulta tus pedidos y compra productos frescos al instante.</p>
    </div>
</div>
</body>
</html>

