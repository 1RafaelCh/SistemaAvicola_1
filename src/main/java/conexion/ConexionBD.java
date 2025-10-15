package conexion;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/bd_avicola";
    private static final String USER = "root";
    private static final String PASS = ""; // si tienes contraseña, escríbela aquí


    public static Connection conectar() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("ConexiOn exitosa a MySQL");
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontrO el driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error de conexiOn: " + e.getMessage());
        }
        return conn;
    }

    public static void main(String[] args) {
        conectar();
    }
}
