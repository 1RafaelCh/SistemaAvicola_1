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
<link rel="stylesheet" href="../recursos/css/estilos.css">
</head>
<body>
<div class="wrapper">
    <div class="sidebar">
        <div>
            <h4>? Cliente</h4>
            <a href="panel_cliente.jsp">? Inicio</a>
            <a href="#">? Mis Compras</a>
            <a href="productos.jsp">? Productos</a>
            <a href="#">? Promociones</a>
        </div>
        <div>
            <hr style="border-color:white;">
            <p class="text-center">? <%= usuario.getNombre() %></p>
            <a href="../LogoutServlet">? Cerrar sesión</a>
        </div>
    </div>

    <div class="content">
        <h2>Bienvenido <%= usuario.getNombre() %> ?</h2>
        <p>Aquí podrás revisar tus compras y productos disponibles.</p>
    </div>
</div>
</body>
</html>

