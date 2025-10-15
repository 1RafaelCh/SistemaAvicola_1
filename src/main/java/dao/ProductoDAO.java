package dao;

import conexion.ConexionBD;
import modelo.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

 public List<Producto> listarProductos() {
    List<Producto> lista = new ArrayList<>();
    String sql =
        "SELECT p.id_producto, p.nombre, p.descripcion, p.unidad_medida, " +
        "       p.categoria, p.precio, p.id_proveedor, p.stock, i.stock_minimo " +
        "FROM producto p " +
        "LEFT JOIN inventario i ON i.id_producto = p.id_producto " +
        "WHERE p.activo = 1 " +
        "ORDER BY p.id_producto DESC";

    try (Connection con = ConexionBD.conectar();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Producto p = new Producto();
            p.setId_producto(rs.getInt("id_producto"));
            p.setNombre(rs.getString("nombre"));
            p.setDescripcion(rs.getString("descripcion"));
            p.setUnidad_medida(rs.getString("unidad_medida"));
            p.setCategoria(rs.getString("categoria"));
            p.setPrecio(rs.getDouble("precio"));
            p.setId_proveedor(rs.getObject("id_proveedor") == null ? 0 : rs.getInt("id_proveedor"));
            p.setStock(rs.getInt("stock"));
            // Stock minimo puede venir NULL (LEFT JOIN)
            Object sm = rs.getObject("stock_minimo");
            p.setStockMinimo(sm == null ? null : ((Number) sm).intValue());

            lista.add(p);
        }

    } catch (SQLException e) {
        System.out.println("❌ Error al listar productos: " + e.getMessage());
    }
    return lista;
}
public void agregarProducto(Producto p) {
    String sql =
        "INSERT INTO producto (nombre, descripcion, unidad_medida, categoria, precio, id_proveedor, stock, activo) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, 1) " +
        "ON DUPLICATE KEY UPDATE " +
        "  descripcion = VALUES(descripcion), " +
        "  precio      = VALUES(precio), " +          
        "  id_proveedor= VALUES(id_proveedor), " +
        "  stock      = producto.stock + VALUES(stock), " + 
        "  activo     = 1";

    try (Connection con = ConexionBD.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, p.getNombre());
        ps.setString(2, p.getDescripcion());
        ps.setString(3, p.getUnidad_medida());
        ps.setString(4, p.getCategoria());
        ps.setDouble(5, p.getPrecio());
        if (p.getId_proveedor() > 0) ps.setInt(6, p.getId_proveedor());
        else ps.setNull(6, java.sql.Types.INTEGER);
        ps.setInt(7, p.getStock());

        ps.executeUpdate();
    } catch (SQLException e) {
        System.out.println("❌ Error al upsert producto: " + e.getMessage());
    }
}

    public boolean actualizarProducto(Producto p) {
        String sql = "UPDATE producto SET nombre=?, descripcion=?, unidad_medida=?, categoria=?, precio=?, id_proveedor=?, stock=? " +
                     "WHERE id_producto=?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getUnidad_medida());
            ps.setString(4, p.getCategoria());
            ps.setDouble(5, p.getPrecio());
            if (p.getId_proveedor() > 0) ps.setInt(6, p.getId_proveedor()); else ps.setNull(6, Types.INTEGER);
            ps.setInt(7, p.getStock());
            ps.setInt(8, p.getId_producto());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al actualizar producto: " + e.getMessage());
        }
        return false;
    }

    public boolean eliminarProducto(int id) {
        String sql = "UPDATE producto SET activo=0 WHERE id_producto=?";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error al eliminar (soft) producto: " + e.getMessage());
        }
        return false;
    }
public int contarProductosActivos() {
    String sql = "SELECT COUNT(*) FROM producto WHERE activo = 1";
    try (Connection con = ConexionBD.conectar();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) { e.printStackTrace(); }
    return 0;
}

public long sumarStockTotal() {
    String sql = "SELECT COALESCE(SUM(COALESCE(stock,0)),0) FROM producto WHERE activo = 1";
    try (Connection con = ConexionBD.conectar();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getLong(1);
    } catch (SQLException e) { e.printStackTrace(); }
    return 0L;
}

}
