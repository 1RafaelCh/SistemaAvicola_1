package modelo;

public class Usuario {
    private int id_usuario;
    private int id_rol;
    private String nombre;
    private String email;
    private String password_hash;
    private String telefono;
    private String nombreRol;
    private boolean activo;

    public Usuario() {}

    public Usuario(int id_usuario, int id_rol, String nombre, String email, String password_hash, String telefono, boolean activo, String nombreRol) {
        this.id_usuario = id_usuario;
        this.id_rol = id_rol;
        this.nombre = nombre;
        this.email = email;
        this.password_hash = password_hash;
        this.telefono = telefono;
        this.activo = activo;
        this.nombreRol = nombreRol;
    }
    public int getId_usuario() { return id_usuario; }
    public void setId_usuario(int id_usuario) { this.id_usuario = id_usuario; }

    public int getId_rol() { return id_rol; }
    public void setId_rol(int id_rol) { this.id_rol = id_rol; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword_hash() { return password_hash; }
    public void setPassword_hash(String password_hash) { this.password_hash = password_hash; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    public String getNombreRol() { return nombreRol; }
    public void setNombreRol(String nombreRol) { this.nombreRol = nombreRol; }
}

