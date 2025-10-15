package dao;

import modelo.Usuario;
import conexion.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.*, r.nombre AS rol_nombre FROM usuario u INNER JOIN rol r ON u.id_rol = r.id_rol";

        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setId_rol(rs.getInt("id_rol"));
                u.setNombre(rs.getString("nombre"));
                u.setEmail(rs.getString("email"));
                u.setPassword_hash(rs.getString("password_hash"));
                u.setTelefono(rs.getString("telefono"));
                u.setActivo(rs.getBoolean("activo"));
                u.setNombreRol(rs.getString("rol_nombre"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean agregarUsuario(Usuario u) {
        String sql = "INSERT INTO usuario (id_rol, nombre, email, password_hash, telefono, activo) VALUES (?, ?, ?, ?, ?, 1)";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, u.getId_rol());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword_hash());
            ps.setString(5, u.getTelefono());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuario WHERE id_usuario=?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public Usuario validarLogin(String email, String password) {
    Usuario usuario = null;
    String sql = "SELECT u.*, r.nombre AS rol_nombre " +
                 "FROM usuario u " +
                 "INNER JOIN rol r ON u.id_rol = r.id_rol " +
                 "WHERE u.email = ? AND u.password_hash = ? AND u.activo = 1";

    try (Connection con = ConexionBD.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, email);
        ps.setString(2, password);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setId_rol(rs.getInt("id_rol"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuario.setNombreRol(rs.getString("rol_nombre"));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return usuario;
}
}

