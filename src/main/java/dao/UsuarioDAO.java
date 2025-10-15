package dao;

import modelo.Usuario;
import conexion.ConexionBD; // usa tu clase exacta
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // === Configuración: cambia a true si quieres borrado lógico ===
    private static final boolean SOFT_DELETE = false; // false = DELETE físico

    // =====================
    // LISTAR
    // =====================
    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String base = "SELECT u.id_usuario, u.id_rol, u.nombre, u.email, u.password_hash, u.telefono, u.activo, r.nombre AS rol_nombre " +
                      "FROM usuario u INNER JOIN rol r ON u.id_rol = r.id_rol";
        String sql = SOFT_DELETE ? base + " WHERE u.activo = 1 ORDER BY u.id_usuario DESC"
                                 : base + " ORDER BY u.id_usuario DESC";
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

    // =====================
    // INSERTAR
    // =====================
    public boolean agregarUsuario(Usuario u) {
        String sql = "INSERT INTO usuario (id_rol, nombre, email, password_hash, telefono, activo) VALUES (?, ?, ?, ?, ?, 1)";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, u.getId_rol());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword_hash());
            ps.setString(5, u.getTelefono());
            return ps.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException dup) {
            // email duplicado u otra restricción
            System.err.println("Violación de restricción (posible email duplicado): " + dup.getMessage());
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // =====================
    // ACTUALIZAR (password opcional)
    // =====================
    public boolean actualizarUsuario(Usuario u) {
        boolean cambiarPass = u.getPassword_hash() != null && !u.getPassword_hash().isEmpty();
        String sql = "UPDATE usuario SET id_rol=?, nombre=?, email=?, telefono=?" + (cambiarPass ? ", password_hash=?" : "") + " WHERE id_usuario=?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            ps.setInt(i++, u.getId_rol());
            ps.setString(i++, u.getNombre());
            ps.setString(i++, u.getEmail());
            ps.setString(i++, u.getTelefono());
            if (cambiarPass) ps.setString(i++, u.getPassword_hash());
            ps.setInt(i, u.getId_usuario());
            return ps.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException dup) {
            System.err.println("Violación de restricción al actualizar: " + dup.getMessage());
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // =====================
    // ELIMINAR (físico o lógico)
    // =====================
    public boolean eliminarUsuario(int id) {
        String sql = SOFT_DELETE ? "UPDATE usuario SET activo = 0 WHERE id_usuario = ?"
                                 : "DELETE FROM usuario WHERE id_usuario = ?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // =====================
    // (Opcional) LOGIN Y OBTENER POR ID — si ya los tienes puedes mantenerlos
    // =====================
    public Usuario validarLogin(String email, String password) {
        String sql = "SELECT u.id_usuario, u.id_rol, u.nombre, u.email, u.telefono, u.activo, r.nombre AS rol_nombre " +
                     "FROM usuario u INNER JOIN rol r ON u.id_rol = r.id_rol " +
                     (SOFT_DELETE ? "WHERE u.email = ? AND u.password_hash = ? AND u.activo = 1"
                                  : "WHERE u.email = ? AND u.password_hash = ?");
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId_usuario(rs.getInt("id_usuario"));
                    u.setId_rol(rs.getInt("id_rol"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setTelefono(rs.getString("telefono"));
                    u.setActivo(rs.getBoolean("activo"));
                    u.setNombreRol(rs.getString("rol_nombre"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        String sql = "SELECT u.id_usuario, u.id_rol, u.nombre, u.email, u.telefono, u.password_hash, u.activo, r.nombre AS rol_nombre " +
                     "FROM usuario u INNER JOIN rol r ON u.id_rol = r.id_rol WHERE u.id_usuario = ?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId_usuario(rs.getInt("id_usuario"));
                    u.setId_rol(rs.getInt("id_rol"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setTelefono(rs.getString("telefono"));
                    u.setPassword_hash(rs.getString("password_hash"));
                    u.setActivo(rs.getBoolean("activo"));
                    u.setNombreRol(rs.getString("rol_nombre"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}


