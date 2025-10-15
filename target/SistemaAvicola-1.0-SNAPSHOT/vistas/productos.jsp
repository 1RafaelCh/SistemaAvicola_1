<%@page import="modelo.Producto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos - Avícola David & Daniel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/recursos/css/estilos.css">
</head>
<body>
    <header>
        <h1>🐔 Gestión de Productos</h1>
        <nav>
            <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
            <a href="${pageContext.request.contextPath}/vistas/clientes.jsp">Clientes</a>
            <a href="${pageContext.request.contextPath}/vistas/ventas.jsp">Ventas</a>
        </nav>
    </header>

    <main>
        <section>
            <h2>Registrar nuevo producto</h2>
            <form action="${pageContext.request.contextPath}/ProductoServlet" method="post">
                <input type="hidden" name="accion" value="agregar">

                <label>Nombre:</label>
                <input type="text" name="nombre" required><br>

                <label>Descripción:</label>
                <input type="text" name="descripcion"><br>

                <label>Unidad de medida:</label>
                <input type="text" name="unidad_medida" placeholder="Ej: kg, unidad"><br>

                <label>Categoría:</label>
                <input type="text" name="categoria"><br>

                <label>Precio (S/):</label>
                <input type="number" step="0.01" name="precio" required><br>

                <label>ID Proveedor (opcional):</label>
                <input type="number" name="id_proveedor"><br>
                
                <label>Stock:</label>
                <input type="number" name="stock" placeholder="Stock" required><br>


                <button type="submit">Agregar</button>
            </form>
        </section>

        <section>
            <h2>Listado de productos</h2>
            <table border="1" align="center" cellpadding="10">
                <tr style="background:#c62828;color:white;">
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Unidad</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                </tr>
                <%
                    List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
                    if (lista != null && !lista.isEmpty()) {
                        for (Producto p : lista) {
                %>
                <tr>
                    <td><%= p.getId_producto() %></td>
                    <td><%= p.getNombre() %></td>
                    <td><%= p.getDescripcion() %></td>
                    <td><%= p.getUnidad_medida() %></td>
                    <td><%= p.getCategoria() %></td>
                    <td>S/ <%= p.getPrecio() %></td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="6" style="text-align:center;">No hay productos registrados</td>
                </tr>
                <% } %>
            </table>
        </section>
    </main>

    <footer>
        <p>© 2025 Avícola David & Daniel - Todos los derechos reservados.</p>
    </footer>
</body>
</html>
