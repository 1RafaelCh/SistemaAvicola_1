package dao;

import conexion.ConexionBD;
import modelo.Usuario;
import java.sql.*;

public class UsuarioDAO {

    public Usuario validarLogin(String email, String password) {
        Usuario u = null;
        String sql = "SELECT u.*, r.nombre AS nombreRol FROM usuario u "
                   + "JOIN rol r ON u.id_rol = r.id_rol "
                   + "WHERE u.email = ? AND u.password_hash = ? AND u.activo = 1";

        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setId_rol(rs.getInt("id_rol"));
                u.setNombre(rs.getString("nombre"));
                u.setEmail(rs.getString("email"));
                u.setNombreRol(rs.getString("nombreRol"));
            }

        } catch (SQLException e) {
            System.out.println("Error en validarLogin(): " + e.getMessage());
        }

        return u;
    }
}
