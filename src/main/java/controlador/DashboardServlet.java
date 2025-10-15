package controlador;

import dao.UsuarioDAO;
import dao.ProductoDAO;
// import dao.VentaDAO; // si ya tienes ventas
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UsuarioDAO udao = new UsuarioDAO();
        ProductoDAO pdao = new ProductoDAO();
        // VentaDAO vdao = new VentaDAO();

        int totalUsuarios = udao.contarUsuariosActivos();         // activos=1
        int productosActivos = pdao.contarProductosActivos();     // activo=1
        long stockTotal = pdao.sumarStockTotal();                 // SUM(stock)
        double ventasHoy = 0.0;                                   // default
        // ventasHoy = vdao.totalVentasDeHoy();                   // si tienes la tabla ventas

        req.setAttribute("totalUsuarios", totalUsuarios);
        req.setAttribute("productosActivos", productosActivos);
        req.setAttribute("stockTotal", stockTotal);
        req.setAttribute("ventasHoy", ventasHoy);

        req.getRequestDispatcher("/vistas/admin/dashboard.jsp").forward(req, resp);
    }
}
