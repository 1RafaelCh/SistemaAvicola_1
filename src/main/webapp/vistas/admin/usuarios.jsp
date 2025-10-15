<%@ page import="modelo.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    // si alguien entra directo, fuerza a pasar por el servlet que carga la lista
    if (request.getAttribute("usuarios") == null) {
        response.sendRedirect(ctx + "/UsuarioServlet?accion=listar");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Usuarios - Avícola D&D</title>
  <!-- usa el mismo css que el dashboard, con contextPath -->
  <link rel="stylesheet" href="<%=ctx%>/recursos/css/sidebar.css">
  <style>
    /* Ajustes para que luzca igual al dashboard */
    .main-content { padding: 24px; }
    h1, h2, h3 { margin: 0 0 12px; }
    .card { background:#fff3e0; padding:12px; border-radius:10px; box-shadow:0 2px 5px rgba(0,0,0,.08); }

    form { display:flex; flex-wrap:wrap; gap:10px; align-items:center;
           background:#fff3e0; padding:12px; border-radius:8px; margin:14px 0 18px; }
    input, button { padding:8px 10px; }
    .btn { border:none; border-radius:6px; cursor:pointer; }
    .btn-primary{ background:#c62828; color:#fff; }
    .btn-secondary{ background:#eeeeee; }
    .btn-link { background:none; border:none; color:#b71c1c; cursor:pointer; text-decoration:underline; padding:0; }

    table { border-collapse: collapse; width: 100%; background: #fff; }
    th, td { border: 1px solid #e5e5e5; padding: 10px; text-align: left; }
    th { background:#c62828; color:#fff; }
    tr:nth-child(even){ background:#fafafa; }

    .acciones { display:flex; gap:10px; align-items:center; }
    .mensaje { font-weight:600; margin-top:8px; }
    .ok { color:#2e7d32; } .error { color:#c62828; }
  </style>
</head>
<body>
  <!-- MISMA SIDEBAR DEL DASHBOARD -->
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <a href="<%=ctx%>/vistas/admin/dashboard.jsp">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar" class="active">👤 Usuarios</a>
    <a href="<%=ctx%>/vistas/admin/productos.jsp">📦 Productos</a>
    <a href="<%=ctx%>/vistas/admin/inventario.jsp">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/Logout">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1>Gestión de Usuarios</h1>
    <p>Administra los usuarios del sistema: crea, edita y elimina.</p>

    <!-- Mensaje por query param opcional -->
    <%
      String qmsg = request.getParameter("msg");
      if ("ok".equals(qmsg)) { %>
        <p class="mensaje ok">✅ Operación realizada correctamente.</p>
    <%} else if ("error".equals(qmsg)) { %>
        <p class="mensaje error">❌ Ocurrió un error en la operación.</p>
    <% } %>

    <!-- Formulario crear/editar -->
    <form id="formUsuario">
      <input type="hidden" name="id_usuario" id="id_usuario">

      <input type="number" name="id_rol" id="id_rol" placeholder="Rol (1=Admin, 2=Vendedor, 3=Cliente)" required>
      <input type="text"   name="nombre" id="nombre" placeholder="Nombre" required>
      <input type="email"  name="email" id="email" placeholder="Correo" required>
      <input type="password" name="password_hash" id="password_hash" placeholder="Contraseña" required>
      <input type="text"   name="telefono" id="telefono" placeholder="Teléfono">

      <button type="submit" class="btn btn-primary" id="btnGuardar">Agregar</button>
      <button type="button" class="btn btn-secondary" id="btnCancelar" style="display:none;">Cancelar</button>
    </form>

    <!-- Tabla -->
    <div class="card">
      <h3>Usuarios registrados</h3>
      <table>
        <tr>
          <th>ID</th><th>Nombre</th><th>Email</th><th>Rol</th><th>Teléfono</th><th>Activo</th><th>Acciones</th>
        </tr>
        <%
          List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
          if (lista != null && !lista.isEmpty()) {
            for (Usuario u : lista) {
        %>
        <tr>
          <td><%= u.getId_usuario() %></td>
          <td><%= u.getNombre() %></td>
          <td><%= u.getEmail() %></td>
          <td><%= u.getNombreRol() %></td>
          <td><%= u.getTelefono() %></td>
          <td><%= u.isActivo() ? "Sí" : "No" %></td>
          <td class="acciones">
            <button class="btn-link"
              data-id="<%=u.getId_usuario()%>"
              data-rol="<%=u.getId_rol()%>"
              data-nombre='<%= u.getNombre()==null?"":u.getNombre() %>'
              data-email='<%= u.getEmail()==null?"":u.getEmail() %>'
              data-telefono='<%= u.getTelefono()==null?"":u.getTelefono() %>'
              onclick="cargarEdicion(this)">✏ Editar</button>

            <a class="btn-link"
               href="<%=ctx%>/UsuarioServlet?accion=eliminar&id=<%=u.getId_usuario()%>"
               onclick="return confirm('¿Eliminar este usuario?')">🗑 Eliminar</a>
          </td>
        </tr>
        <%  }
          } else { %>
        <tr><td colspan="7">No hay usuarios registrados.</td></tr>
        <% } %>
      </table>
    </div>
  </div>

<script>
const form = document.getElementById("formUsuario");
const idUsuario = document.getElementById("id_usuario");
const idRol = document.getElementById("id_rol");
const nombre = document.getElementById("nombre");
const email = document.getElementById("email");
const pass = document.getElementById("password_hash");
const telefono = document.getElementById("telefono");
const btnGuardar = document.getElementById("btnGuardar");
const btnCancelar = document.getElementById("btnCancelar");

// Crear / Actualizar
form.addEventListener("submit", function(e){
  e.preventDefault();
  if (!form.reportValidity()) return;

  if (idUsuario.value) pass.removeAttribute("required"); else pass.setAttribute("required","required");

  const data = new URLSearchParams(new FormData(form));
  fetch("<%=ctx%>/UsuarioServlet", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
    body: data
  })
  .then(r => r.json())
  .then(data => {
    if (data.status === "ok") {
      setTimeout(()=>{ window.location.href = "<%=ctx%>/UsuarioServlet?accion=listar"; }, 400);
    } else {
      alert("❌ " + data.msg);
    }
  })
  .catch(err => console.error("Error en la solicitud:", err));
});

// Cargar datos al formulario para editar
function cargarEdicion(btn){
  idUsuario.value = btn.dataset.id;
  idRol.value     = btn.dataset.rol;
  nombre.value    = btn.dataset.nombre || "";
  email.value     = btn.dataset.email || "";
  telefono.value  = btn.dataset.telefono || "";
  pass.value = "";
  pass.removeAttribute("required");
  btnGuardar.textContent = "Guardar";
  btnCancelar.style.display = "inline-block";
}

// Cancelar edición
btnCancelar.addEventListener("click", ()=>{
  idUsuario.value = "";
  form.reset();
  pass.setAttribute("required","required");
  btnGuardar.textContent = "Agregar";
  btnCancelar.style.display = "none";
});
</script>
</body>
</html>

