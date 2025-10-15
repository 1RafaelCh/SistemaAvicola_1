package controlador;

import dao.ProductoDAO;
import modelo.Producto;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    // Método GET → mostrar productos
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        ProductoDAO dao = new ProductoDAO();

        if (accion == null || accion.equals("listar")) {
            // Obtenemos los productos desde la BD
            List<Producto> lista = dao.listarProductos();

            // Enviamos la lista a la vista JSP
            request.setAttribute("listaProductos", lista);

            // Redirigimos hacia productos.jsp
            RequestDispatcher rd = request.getRequestDispatcher("vistas/productos.jsp");
            rd.forward(request, response);
        }
    }

    // Método POST → agregar producto desde el formulario
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        ProductoDAO dao = new ProductoDAO();

if ("agregar".equals(accion)) {
    Producto p = new Producto();
    p.setNombre(request.getParameter("nombre"));
    p.setDescripcion(request.getParameter("descripcion"));
    p.setUnidad_medida(request.getParameter("unidad_medida"));
    p.setCategoria(request.getParameter("categoria"));
    // precio (manejar excepción)
    try {
        p.setPrecio(Double.parseDouble(request.getParameter("precio")));
    } catch (NumberFormatException e) {
        p.setPrecio(0.0);
    }
    // id_proveedor (opcional)
    try {
        String prov = request.getParameter("id_proveedor");
        p.setId_proveedor((prov != null && !prov.isEmpty()) ? Integer.parseInt(prov) : 0);
    } catch (NumberFormatException e) {
        p.setId_proveedor(0);
    }
    // stock (opcional)
    try {
        String s = request.getParameter("stock");
        p.setStock((s != null && !s.isEmpty()) ? Integer.parseInt(s) : 0);
    } catch (NumberFormatException e) {
        p.setStock(0);
    }

    dao.agregarProducto(p);
    response.sendRedirect("ProductoServlet?accion=listar");
}
    }
}
