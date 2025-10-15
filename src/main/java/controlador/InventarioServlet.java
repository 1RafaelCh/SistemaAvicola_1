package controlador;

import dao.InventarioDAO;
import modelo.Inventario;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/InventarioServlet")
public class InventarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) accion = "listar";

        InventarioDAO dao = new InventarioDAO();

        switch (accion) {
            case "listar":
                List<Inventario> lista = dao.listarInventario();
                req.setAttribute("listaInventario", lista);
                req.getRequestDispatcher("/vistas/admin/inventario.jsp").forward(req, resp);
                break;

            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no soportada");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if ("guardar-limites".equals(accion)) {
            try {
                int id = Integer.parseInt(req.getParameter("id_producto"));
                String smin = req.getParameter("stock_minimo");
                String smax = req.getParameter("stock_maximo");
                Integer min = (smin == null || smin.isBlank()) ? null : Integer.valueOf(smin);
                Integer max = (smax == null || smax.isBlank()) ? null : Integer.valueOf(smax);
                new InventarioDAO().guardarLimites(id, min, max);
            } catch (Exception ignored) { }
            resp.sendRedirect("InventarioServlet?accion=listar");
            return;
        }
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no soportada");
    }
}

