<%@ page import="modelo.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="../../recursos/css/sidebar.css">
</head>
<body>
    <div class="sidebar">
        <h3>🐔 Admin</h3>
        <a href="dashboard.jsp">Inicio</a>
        <a href="usuarios.jsp" class="active">Usuarios</a>
        <a href="../productos.jsp">Productos</a>
        <a href="../inventario.jsp">Inventario</a>
        <a href="../reportes.jsp">Reportes</a>
    </div>

    <div class="main-content">
        <h2>Gestión de Usuarios</h2>

        <form action="../../UsuarioServlet" method="post">
            <input type="number" name="id_rol" placeholder="Rol (1=Admin, 2=Vendedor, 3=Cliente)" required>
            <input type="text" name="nombre" placeholder="Nombre" required>
            <input type="email" name="email" placeholder="Correo" required>
            <input type="password" name="password_hash" placeholder="Contraseña" required>
            <input type="text" name="telefono" placeholder="Teléfono">
            <button type="submit">Agregar</button>
        </form>

        <hr>

        <h3>Usuarios registrados</h3>
        <table border="1" cellpadding="8">
            <tr style="background:#c62828;color:white;">
                <th>ID</th>
                <th>Nombre</th>
                <th>Email</th>
                <th>Rol</th>
                <th>Teléfono</th>
                <th>Activo</th>
                <th>Acciones</th>
            </tr>
            <%
                List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
                if (lista != null) {
                    for (Usuario u : lista) {
            %>
            <tr>
                <td><%= u.getId_usuario() %></td>
                <td><%= u.getNombre() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getNombreRol() %></td>
                <td><%= u.getTelefono() %></td>
                <td><%= u.isActivo() ? "Sí" : "No" %></td>
                <td>
                    <a href="../../UsuarioServlet?accion=eliminar&id=<%=u.getId_usuario()%>" onclick="return confirm('¿Eliminar este usuario?')">Eliminar</a>
                </td>
            </tr>
            <% } } %>
        </table>
    </div>
</body>
</html>
