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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        ProductoDAO dao = new ProductoDAO();

            switch (accion) {
              case "listar":
                List<Producto> lista = dao.listarProductos();
                request.setAttribute("listaProductos", lista);
                request.getRequestDispatcher("/vistas/admin/productos.jsp")
                       .forward(request, response);
                break;

              case "eliminar":
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = dao.eliminarProducto(id);
                response.sendRedirect(request.getContextPath()
                    + "/ProductoServlet?accion=listar&msg=" + (ok ? "ok" : "error"));
                break;

              default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no soportada");
            }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        ProductoDAO dao = new ProductoDAO();

        if ("agregar".equals(accion) || "actualizar".equals(accion)) {
            Producto p = new Producto();

            // si viene id → es actualización
            String idStr = request.getParameter("id_producto");
            if (idStr != null && !idStr.isBlank()) {
                p.setId_producto(Integer.parseInt(idStr));
            }

            p.setNombre(request.getParameter("nombre"));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setUnidad_medida(request.getParameter("unidad_medida"));
            p.setCategoria(request.getParameter("categoria"));

            try { p.setPrecio(Double.parseDouble(request.getParameter("precio"))); }
            catch (Exception e) { p.setPrecio(0.0); }

            try {
                String prov = request.getParameter("id_proveedor");
                p.setId_proveedor((prov != null && !prov.isBlank()) ? Integer.parseInt(prov) : 0);
            } catch (Exception e) { p.setId_proveedor(0); }

            try {
                String s = request.getParameter("stock");
                p.setStock((s != null && !s.isBlank()) ? Integer.parseInt(s) : 0);
            } catch (Exception e) { p.setStock(0); }

            if (p.getId_producto() > 0) {
                dao.actualizarProducto(p);
            } else {
                dao.agregarProducto(p);
            }
            response.sendRedirect(request.getContextPath() + "/ProductoServlet?accion=listar");
            return;
        }

        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no soportada");
    }
}

