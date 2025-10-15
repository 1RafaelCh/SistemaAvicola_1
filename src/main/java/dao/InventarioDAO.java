package dao;

import conexion.ConexionBD;
import modelo.Inventario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventarioDAO {
    public List<Inventario> listarInventario() {
        List<Inventario> lista = new ArrayList<>();

        String sql =
            "SELECT p.id_producto, p.nombre, p.unidad_medida, p.categoria, " +
            "       p.stock AS stock_actual, i.stock_minimo, i.stock_maximo " +
            "FROM producto p " +
            "LEFT JOIN inventario i ON i.id_producto = p.id_producto " +
            "WHERE p.activo = 1 " +
            "ORDER BY p.id_producto DESC";

        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Inventario inv = new Inventario();
                inv.setId_producto(rs.getInt("id_producto"));
                inv.setNombreProducto(rs.getString("nombre"));
                inv.setUnidad_medida(rs.getString("unidad_medida"));
                inv.setCategoria(rs.getString("categoria"));
                inv.setStockActual(rs.getDouble("stock_actual"));

                Object smin = rs.getObject("stock_minimo");
                inv.setStockMinimo(smin == null ? null : ((Number) smin).intValue());

                Object smax = rs.getObject("stock_maximo");
                inv.setStockMaximo(smax == null ? null : ((Number) smax).intValue());

                lista.add(inv);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al listar inventario: " + e.getMessage());
        }
        return lista;
    }

    // (Opcional) guardar límites
    public boolean guardarLimites(int idProducto, Integer min, Integer max) {
        String upsert =
            "INSERT INTO inventario (id_producto, stock_minimo, stock_maximo) " +
            "VALUES (?,?,?) " +
            "ON DUPLICATE KEY UPDATE stock_minimo=VALUES(stock_minimo), stock_maximo=VALUES(stock_maximo)";
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(upsert)) {
            ps.setInt(1, idProducto);
            if (min == null) ps.setNull(2, Types.INTEGER); else ps.setInt(2, min);
            if (max == null) ps.setNull(3, Types.INTEGER); else ps.setInt(3, max);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("❌ Error guardando límites: " + e.getMessage());
            return false;
        }
    }
}
