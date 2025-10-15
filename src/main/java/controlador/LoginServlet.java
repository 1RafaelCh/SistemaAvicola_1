package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarLogin(email, password);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            switch (usuario.getNombreRol()) {
                case "ADMIN":
                    response.sendRedirect("vistas/panel_admin.jsp");
                    break;
                case "VENDEDOR":
                    response.sendRedirect("vistas/panel_vendedor.jsp");
                    break;
                case "CLIENTE":
                    response.sendRedirect("vistas/panel_cliente.jsp");
                    break;
                default:
                    response.sendRedirect("vistas/login.jsp?error=rol");
                    break;
            }
        } else {
            response.sendRedirect("vistas/login.jsp?error=1");
        }
    }
}
