package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();

        if ("listar".equals(accion)) {
            List<Usuario> lista = dao.listarUsuarios();
            request.setAttribute("usuarios", lista);
            RequestDispatcher rd = request.getRequestDispatcher("vistas/admin/usuarios.jsp");
            rd.forward(request, response);

        } else if ("eliminar".equals(accion)) {
            boolean ok = false;
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                ok = dao.eliminarUsuario(id);
            } catch (Exception ignored) {}
            response.sendRedirect("vistas/admin/usuarios.jsp?msg=" + (ok ? "ok" : "error"));

        } else {
            // Por defecto, listar
            List<Usuario> lista = dao.listarUsuarios();
            request.setAttribute("usuarios", lista);
            RequestDispatcher rd = request.getRequestDispatcher("vistas/admin/usuarios.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // Parámetros
            String idUsuarioStr = request.getParameter("id_usuario");
            String idRolStr     = request.getParameter("id_rol");
            String nombre       = request.getParameter("nombre");
            String email        = request.getParameter("email");
            String password     = request.getParameter("password_hash");
            String telefono     = request.getParameter("telefono");

            // Validaciones mínimas
            if (idRolStr == null || idRolStr.isBlank()
             || nombre == null || nombre.isBlank()
             || email == null  || email.isBlank()
             || ((idUsuarioStr == null || idUsuarioStr.isBlank()) // es creación
                    && (password == null || password.isBlank()))) {
                out.print(json("error",
                        "Faltan datos obligatorios (id_rol, nombre, email y contraseña para crear)."));
                out.flush();
                return;
            }

            int idRol = Integer.parseInt(idRolStr);

            Usuario u = new Usuario();
            u.setId_rol(idRol);
            u.setNombre(nombre);
            u.setEmail(email);
            u.setTelefono(telefono);
            u.setPassword_hash(password); // en actualizar puede venir vacío (tu DAO lo maneja)

            UsuarioDAO dao = new UsuarioDAO();
            boolean exito;
            String msg;

            if (idUsuarioStr != null && !idUsuarioStr.isBlank()) {
                // actualizar
                u.setId_usuario(Integer.parseInt(idUsuarioStr));
                exito = dao.actualizarUsuario(u);
                msg = exito ? "Usuario actualizado correctamente." : "Error al actualizar usuario.";
            } else {
                // crear
                exito = dao.agregarUsuario(u);
                msg = exito ? "Usuario agregado correctamente." : "Error al agregar usuario.";
            }

            out.print(json(exito ? "ok" : "error", msg));

        } catch (Exception e) {
            String m = (e.getMessage() == null) ? "Excepción" : e.getMessage().replace("\"","\\\"");
            out.print(json("error", "Excepción: " + m));
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }

    // Utilidad simple para responder JSON sin librerías
    private String json(String status, String msg) {
        if (status == null) status = "";
        if (msg == null) msg = "";
        msg = msg.replace("\\","\\\\").replace("\"","\\\"");
        return "{\"status\":\"" + status + "\",\"msg\":\"" + msg + "\"}";
    }
}



