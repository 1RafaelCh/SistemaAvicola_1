<%@ page session="true" %>
<%
    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
    if (usuario == null || !"ADMIN".equals(usuario.getNombreRol())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Panel Administrador</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../recursos/css/sidebar.css">
</head>
<body>
<div class="sidebar">
    <h3>? Admin</h3>
    <a href="panel_admin.jsp">? Inicio</a>
    <a href="productos.jsp">? Productos</a>
    <a href="#">? Usuarios</a>
    <a href="#">? Reportes</a>
    <a href="../LogoutServlet">? Cerrar sesión</a>
</div>

<div class="main-content">
    <h2>Bienvenido, <%= usuario.getNombre() %> ?</h2>
    <p class="text-muted">Rol: <strong><%= usuario.getNombreRol() %></strong></p>

    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Gestión de Productos</h5>
                    <p class="card-text">Agrega, edita y elimina productos.</p>
                    <a href="productos.jsp" class="btn btn-danger">Ir</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Gestión de Usuarios</h5>
                    <p class="card-text">Administra vendedores y clientes.</p>
                    <a href="#" class="btn btn-danger">Ir</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

