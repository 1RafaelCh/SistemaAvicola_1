<%@ page import="modelo.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
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

  <!-- Fuente moderna + Bootstrap -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root {
      --brand: #d32f2f;
      --brand-dark: #b71c1c;
      --accent: #f9a825;
      --bg-light: #fff8f8;
      --success: #2e7d32;
      --danger: #c62828;
    }

    * { font-family: 'Poppins', sans-serif; box-sizing: border-box; }

    body {
      margin: 0;
      display: flex;
      background: var(--bg-light);
      color: #333;
      min-height: 100vh;
    }

    .sidebar {
      width: 230px;
      background: linear-gradient(180deg, var(--brand), var(--brand-dark));
      color: #fff;
      display: flex;
      flex-direction: column;
      padding: 22px 15px;
      position: fixed;
      height: 100vh;
      box-shadow: 4px 0 12px rgba(0,0,0,.2);
    }

    .sidebar h3 {
      text-align: center;
      font-weight: 700;
      margin-bottom: 28px;
    }

    .sidebar a {
      color: #fff;
      text-decoration: none;
      padding: 10px 14px;
      border-radius: 10px;
      margin-bottom: 8px;
      display: block;
      font-weight: 500;
      transition: 0.25s;
    }

    .sidebar a:hover {
      background: rgba(255,255,255,0.15);
      transform: translateX(4px);
    }

    .sidebar a.active {
      background: var(--accent);
      color: #222;
      font-weight: 600;
    }
    .main-content {
      margin-left: 230px;
      padding: 40px;
      flex: 1;
      animation: fadeIn 0.6s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    h1 {
      font-weight: 700;
      color: var(--brand);
      margin-bottom: 10px;
    }

    p { color: #555; margin-bottom: 20px; }

    /* === MENSAJES === */
    .mensaje {
      font-weight: 600;
      padding: 10px 14px;
      border-radius: 8px;
      width: fit-content;
    }
    .ok { color: #1b5e20; background: #e8f5e9; }
    .error { color: #c62828; background: #ffebee; }

    /* === FORMULARIO === */
    form {
      background: #fff;
      padding: 20px;
      border-radius: 14px;
      box-shadow: 0 3px 12px rgba(0,0,0,0.08);
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      align-items: flex-end;
      margin-bottom: 25px;
    }

    form input {
      flex: 1 1 200px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      transition: border 0.2s;
    }

    form input:focus {
      border-color: var(--brand);
      outline: none;
    }

    .btn {
      border: none;
      border-radius: 8px;
      padding: 10px 16px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.2s;
    }

    .btn-primary {
      background: var(--brand);
      color: #fff;
    }

    .btn-primary:hover {
      background: var(--brand-dark);
    }

    .btn-secondary {
      background: #f5f5f5;
      color: #333;
    }

    .btn-secondary:hover {
      background: #e0e0e0;
    }

    /* === BOTONES DE ACCIÓN === */
    .btn-link {
      background: none;
      border: none;
      cursor: pointer;
      text-decoration: underline;
      font-size: 0.95rem;
      transition: 0.2s;
    }

    .btn-edit {
      color: var(--success);
      font-weight: 600;
    }
    .btn-edit:hover {
      color: #1b5e20;
      text-decoration: none;
    }

    .btn-delete {
      color: var(--danger);
      font-weight: 600;
    }
    .btn-delete:hover {
      color: #8e0000;
      text-decoration: none;
    }
    /* === TABLA === */
    .card {
      background: #fff;
      border-radius: 14px;
      padding: 22px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.1);
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      padding: 12px 10px;
      border-bottom: 1px solid #eee;
      text-align: left;
      font-size: 0.95rem;
    }

    th {
      background: var(--brand);
      color: #fff;
      font-weight: 600;
    }

    tr:nth-child(even) { background: #fafafa; }

    .acciones {
      display: flex;
      gap: 10px;
    }
    @media (max-width: 768px) {
      .sidebar {
        width: 100%;
        height: auto;
        flex-direction: row;
        justify-content: space-around;
        position: relative;
      }
      .main-content { margin-left: 0; padding: 20px; }
      .sidebar h3 { display: none; }
    }
  </style>
</head>

<body>
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <a href="<%=ctx%>/Dashboard" class="active">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar" class="active">👤 Usuarios</a>
    <a href="<%=ctx%>/vistas/admin/productos.jsp">📦 Productos</a>
    <a href="<%=ctx%>/vistas/admin/inventario.jsp">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/vistas/login.jsp">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1>Gestión de Usuarios</h1>
    <p>Administra los usuarios del sistema: crea, edita y elimina.</p>

    <%
      String qmsg = request.getParameter("msg");
      if ("ok".equals(qmsg)) { %>
        <p class="mensaje ok">✅ Operación realizada correctamente.</p>
    <%} else if ("error".equals(qmsg)) { %>
        <p class="mensaje error">❌ Ocurrió un error en la operación.</p>
    <% } %>

    <form id="formUsuario">
      <input type="hidden" name="id_usuario" id="id_usuario">

      <input type="number" name="id_rol" id="id_rol" placeholder="Rol (1=Admin, 2=Vendedor, 3=Cliente)" required>
      <input type="text" name="nombre" id="nombre" placeholder="Nombre" required>
      <input type="email" name="email" id="email" placeholder="Correo" required>
      <input type="password" name="password_hash" id="password_hash" placeholder="Contraseña" required>
      <input type="text" name="telefono" id="telefono" placeholder="Teléfono">

      <button type="submit" class="btn btn-primary" id="btnGuardar">Agregar</button>
      <button type="button" class="btn btn-secondary" id="btnCancelar" style="display:none;">Cancelar</button>
    </form>

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
            <button class="btn-link btn-edit"
              data-id="<%=u.getId_usuario()%>"
              data-rol="<%=u.getId_rol()%>"
              data-nombre='<%= u.getNombre()==null?"":u.getNombre() %>'
              data-email='<%= u.getEmail()==null?"":u.getEmail() %>'
              data-telefono='<%= u.getTelefono()==null?"":u.getTelefono() %>'
              onclick="cargarEdicion(this)">✏ Editar</button>

            <a class="btn-link btn-delete"
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

    function cargarEdicion(btn){
      idUsuario.value = btn.dataset.id;
      idRol.value = btn.dataset.rol;
      nombre.value = btn.dataset.nombre || "";
      email.value = btn.dataset.email || "";
      telefono.value = btn.dataset.telefono || "";
      pass.value = "";
      pass.removeAttribute("required");
      btnGuardar.textContent = "Guardar";
      btnCancelar.style.display = "inline-block";
    }

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

