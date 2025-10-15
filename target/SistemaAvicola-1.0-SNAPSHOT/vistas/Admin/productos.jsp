<%@page import="modelo.Producto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  if (request.getAttribute("listaProductos") == null) {
    response.sendRedirect(ctx + "/ProductoServlet?accion=listar");
    return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Productos - Avícola D&D</title>
  <link rel="stylesheet" href="<%=ctx%>/recursos/css/sidebar.css">
  <style>
    .main-content { padding: 24px; }
    .page-title { margin: 0 0 6px; }
    .page-sub { margin: 0 0 16px; color:#555; }
    .card { background:#fff; padding:16px; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,.06); }
    .grid { display:grid; grid-template-columns: repeat(12, 1fr); gap:12px; }
    .form-card { background:#fff3e0; }
    .form-field { grid-column: span 6; display:flex; flex-direction:column; }
    .form-field label { font-weight:600; margin-bottom:4px; }
    .form-actions { grid-column: span 12; display:flex; gap:10px; align-items:center; }
    input[type="text"], input[type="number"], select {
      width:100%; padding:10px 12px; border:1px solid #e0e0e0; border-radius:8px; background:#fff;
    }
    .btn { border:none; border-radius:8px; padding:10px 14px; cursor:pointer; }
    .btn-primary { background:#c62828; color:#fff; }
    .btn-secondary { background:#eeeeee; }
    .btn-link { background:none; border:none; color:#b71c1c; cursor:pointer; text-decoration:underline; padding:0; }
    table { width:100%; border-collapse:collapse; margin-top:14px; background:#fff; }
    th, td { padding:10px 12px; border:1px solid #eee; text-align:left; }
    th { background:#c62828; color:#fff; }
    tr:nth-child(even){ background:#fafafa; }
    .mono { font-variant-numeric: tabular-nums; }
    .badge-low { display:inline-block; padding:2px 8px; border-radius:999px; background:#ffebee; color:#c62828; font-size:12px; font-weight:700; }
    .acciones { display:flex; gap:12px; align-items:center; }
    .mensaje { font-weight:600; margin:8px 0 0; }
    .ok { color:#2e7d32; } .error { color:#c62828; }
  </style>
</head>
<body>
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <a href="<%=ctx%>/vistas/admin/dashboard.jsp">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar">👤 Usuarios</a>
    <a href="<%=ctx%>/ProductoServlet?accion=listar" class="active">📦 Productos</a>
    <a href="<%=ctx%>/vistas/admin/inventario.jsp">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/Logout">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1 class="page-title">Gestión de Productos</h1>
    <p class="page-sub">Registra y administra tus productos.</p>

    <!-- FORMULARIO: agregar / actualizar -->
    <div class="card form-card">
      <form action="<%=ctx%>/ProductoServlet" method="post" id="formProducto">
        <input type="hidden" name="accion" id="accion" value="agregar">
        <input type="hidden" name="id_producto" id="id_producto">

        <div class="grid">
          <div class="form-field" style="grid-column: span 4">
            <label>Nombre *</label>
            <input type="text" name="nombre" id="nombre" required>
          </div>

          <div class="form-field" style="grid-column: span 4">
            <label>Categoría *</label>
            <select name="categoria" id="categoria" required>
              <option value="" disabled selected>— Selecciona —</option>
              <option>pollo</option>
              <option>pavo</option>
              <option>gallina</option>
              <option>pato</option>
              <option>codorniz</option>
              <option>huevo</option>
            </select>
          </div>

          <div class="form-field" style="grid-column: span 4">
            <label>Unidad de medida</label>
            <input type="text" name="unidad_medida" id="unidad_medida" placeholder="kg, unidad, litro...">
          </div>

          <div class="form-field" style="grid-column: span 8">
            <label>Descripción</label>
            <input type="text" name="descripcion" id="descripcion" placeholder="Detalle del producto">
          </div>

          <div class="form-field" style="grid-column: span 2">
            <label>Precio (S/.) *</label>
            <input type="number" step="0.01" min="0" name="precio" id="precio" required>
          </div>

          <div class="form-field" style="grid-column: span 2">
            <label>Stock *</label>
            <input type="number" min="0" name="stock" id="stock" required>
          </div>

          <div class="form-field" style="grid-column: span 3">
            <label>ID Proveedor (opcional)</label>
            <input type="number" min="0" name="id_proveedor" id="id_proveedor">
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-primary" id="btnGuardar">Agregar producto</button>
            <button type="button" class="btn btn-secondary" id="btnCancelar" style="display:none;">Cancelar</button>
            <span id="mensaje" class="mensaje"></span>
          </div>
        </div>
      </form>
    </div>

    <!-- LISTADO -->
    <div class="card" style="margin-top:16px;">
      <h3 style="margin:0 0 10px;">Listado de productos</h3>
      <table>
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Descripción</th>
          <th>Unidad</th>
          <th>Categoría</th>
          <th>Precio</th>
          <th>Stock</th>
          <th>Acciones</th>
        </tr>
        <%
          List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
          if (lista != null && !lista.isEmpty()) {
            for (Producto p : lista) {
              boolean alerta = (p.getStockMinimo()!=null && p.getStock() <= p.getStockMinimo());
        %>
        <tr>
          <td class="mono"><%= p.getId_producto() %></td>
          <td><%= p.getNombre() %></td>
          <td><%= p.getDescripcion()==null?"":p.getDescripcion() %></td>
          <td><%= p.getUnidad_medida()==null?"":p.getUnidad_medida() %></td>
          <td><%= p.getCategoria()==null?"":p.getCategoria() %></td>
          <td class="mono">S/ <%= String.format(java.util.Locale.US,"%.2f", p.getPrecio()) %></td>
          <td class="mono">
            <%= p.getStock() %>
            <% if (alerta) { %>
              <span class="badge-low">¡Bajo!</span>
            <% } %>
          </td>
          <td class="acciones">
            <button class="btn-link"
              data-id="<%=p.getId_producto()%>"
              data-nombre='<%= p.getNombre()==null?"":p.getNombre() %>'
              data-categoria='<%= p.getCategoria()==null?"":p.getCategoria() %>'
              data-unidad='<%= p.getUnidad_medida()==null?"":p.getUnidad_medida() %>'
              data-descripcion='<%= p.getDescripcion()==null?"":p.getDescripcion() %>'
              data-precio="<%= p.getPrecio() %>"
              data-stock="<%= p.getStock() %>"
              data-proveedor="<%= p.getId_proveedor() %>"
              onclick="cargarEdicion(this)">✏ Editar</button>

            <a class="btn-link"
               href="<%=ctx%>/ProductoServlet?accion=eliminar&id=<%=p.getId_producto()%>"
               onclick="return confirm('¿Eliminar este producto?')">🗑 Eliminar</a>
          </td>
        </tr>
        <%  }
          } else { %>
        <tr><td colspan="8" style="text-align:center;">No hay productos registrados</td></tr>
        <% } %>
      </table>
    </div>
  </div>

<script>
const form = document.getElementById("formProducto");
const accion = document.getElementById("accion");
const idProd = document.getElementById("id_producto");
const nombre = document.getElementById("nombre");
const categoria = document.getElementById("categoria");
const unidad = document.getElementById("unidad_medida");
const descripcion = document.getElementById("descripcion");
const precio = document.getElementById("precio");
const stock = document.getElementById("stock");
const prov = document.getElementById("id_proveedor");
const btnGuardar = document.getElementById("btnGuardar");
const btnCancelar = document.getElementById("btnCancelar");
const msg = document.getElementById("mensaje");

form.addEventListener("submit", function(){
  // nada especial: el servlet usa accion agregar/actualizar
});

function cargarEdicion(btn){
  accion.value = "actualizar";
  idProd.value = btn.dataset.id;
  nombre.value = btn.dataset.nombre || "";
  categoria.value = btn.dataset.categoria || "";
  unidad.value = btn.dataset.unidad || "";
  descripcion.value = btn.dataset.descripcion || "";
  precio.value = btn.dataset.precio || "";
  stock.value = btn.dataset.stock || "";
  prov.value = btn.dataset.proveedor || "";

  btnGuardar.textContent = "Guardar cambios";
  btnCancelar.style.display = "inline-block";
  msg.textContent = "Editando ID " + idProd.value;
  msg.className = "mensaje";
}

btnCancelar.addEventListener("click", ()=>{
  accion.value = "agregar";
  idProd.value = "";
  form.reset();
  btnGuardar.textContent = "Agregar producto";
  btnCancelar.style.display = "none";
  msg.textContent = "";
  msg.className = "mensaje";
});
</script>
</body>
</html>

