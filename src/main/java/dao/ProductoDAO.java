package dao;

import conexion.ConexionBD;
import modelo.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // Listar productos
    public List<Producto> listarProductos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE activo = 1";

        try (Connection con = ConexionBD.conectar();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setUnidad_medida(rs.getString("unidad_medida"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock")); // <- agrega esto
                lista.add(p);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al listar productos: " + e.getMessage());
        }

        return lista;
    }

    // Insertar producto
    public void agregarProducto(Producto p) {
        String sql = "INSERT INTO producto (nombre, descripcion, unidad_medida, categoria, precio, id_proveedor, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";

try (Connection con = ConexionBD.conectar();
     PreparedStatement ps = con.prepareStatement(sql)) {

    ps.setString(1, p.getNombre());
    ps.setString(2, p.getDescripcion());
    ps.setString(3, p.getUnidad_medida());
    ps.setString(4, p.getCategoria());
    ps.setDouble(5, p.getPrecio());
    if (p.getId_proveedor() > 0) ps.setInt(6, p.getId_proveedor());
    else ps.setNull(6, Types.INTEGER);
    ps.setInt(7, p.getStock()); // <- nuevo
    ps.executeUpdate();
    System.out.println("✅ Producto insertado correctamente en la BD.");
} catch (SQLException e) {
    System.out.println("❌ Error al insertar producto: " + e.getMessage());
}
    }
}