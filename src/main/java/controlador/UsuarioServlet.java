package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.equals("listar")) {
            List<Usuario> lista = dao.listarUsuarios();
            request.setAttribute("usuarios", lista);
            RequestDispatcher rd = request.getRequestDispatcher("vistas/admin/usuarios.jsp");
            rd.forward(request, response);
        } else if (accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminarUsuario(id);
            response.sendRedirect("UsuarioServlet?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setId_rol(Integer.parseInt(request.getParameter("id_rol")));
        u.setNombre(request.getParameter("nombre"));
        u.setEmail(request.getParameter("email"));
        u.setPassword_hash(request.getParameter("password_hash"));
        u.setTelefono(request.getParameter("telefono"));

        dao.agregarUsuario(u);
        response.sendRedirect("UsuarioServlet?accion=listar");
    }
}
