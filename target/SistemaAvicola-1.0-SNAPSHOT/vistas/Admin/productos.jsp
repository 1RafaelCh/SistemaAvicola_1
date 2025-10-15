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
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
      display: flex;
      margin: 0;
      background: var(--bg-light);
      min-height: 100vh;
    }

    /* ==== SIDEBAR ==== */
    .sidebar {
      width: 230px;
      background: linear-gradient(180deg, var(--brand), var(--brand-dark));
      color: #fff;
      display: flex;
      flex-direction: column;
      padding: 22px 15px;
      box-shadow: 4px 0 12px rgba(0,0,0,.2);
      position: fixed;
      height: 100vh;
    }

    .sidebar h3 {
      text-align: center;
      font-weight: 700;
      margin-bottom: 28px;
      letter-spacing: .5px;
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

    /* ==== MAIN CONTENT ==== */
    .main-content {
      margin-left: 230px;
      padding: 30px 40px;
      flex: 1;
      animation: fadeIn 0.6s ease;
    }

    .main-content h1 {
      color: var(--brand);
      font-weight: 700;
      margin-bottom: 6px;
    }

    .main-content p {
      color: #555;
      font-size: 1rem;
      margin-bottom: 20px;
    }

    /* ==== CARD ==== */
    .card {
      background: #fff;
      border: none;
      border-radius: 14px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.08);
      padding: 20px 24px;
      margin-bottom: 24px;
    }

    /* ==== FORMULARIO ==== */
    .grid {
      display: grid;
      grid-template-columns: repeat(12, 1fr);
      gap: 14px;
    }

    .form-field { display:flex; flex-direction:column; grid-column: span 6; }
    .form-field label { font-weight:600; margin-bottom:4px; }

    input[type="text"], input[type="number"], select {
      width:100%; padding:10px 12px; border:1px solid #e0e0e0;
      border-radius:8px; background:#fff;
    }

    .form-actions {
      grid-column: span 12;
      display: flex;
      gap: 10px;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      border: none;
      border-radius: 8px;
      padding: 10px 16px;
      cursor: pointer;
      transition: all .25s ease;
    }

    .btn-primary { background: var(--brand); color: #fff; }
    .btn-primary:hover { background: var(--brand-dark); }

    .btn-secondary { background: #f1f1f1; color: #333; }
    .btn-secondary:hover { background: #e0e0e0; }

    .btn-link {
      background: none; border: none;
      color: var(--brand-dark);
      cursor: pointer;
      text-decoration: underline;
      padding: 0;
      font-weight: 600;
    }

    /* ==== TABLA ==== */
    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      padding: 10px 12px;
      border: 1px solid #eee;
      text-align: left;
    }

    th {
      background: var(--brand);
      color: #fff;
      font-weight: 600;
    }

    tr:nth-child(even) { background: #fafafa; }

    .mono { font-variant-numeric: tabular-nums; }
    .badge-low {
      display: inline-block;
      padding: 3px 8px;
      border-radius: 999px;
      background: #ffebee;
      color: var(--danger);
      font-size: 12px;
      font-weight: 700;
    }

    .acciones {
      display: flex;
      gap: 10px;
      align-items: center;
      flex-wrap: wrap;
    }

    .mensaje { font-weight:600; margin:8px 0 0; }
    .ok { color: var(--success); }
    .error { color: var(--danger); }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* ==== RESPONSIVE ==== */
    @media (max-width: 768px) {
      .sidebar {
        width: 100%;
        height: auto;
        flex-direction: row;
        justify-content: space-around;
        position: relative;
        box-shadow: none;
      }

      .main-content {
        margin-left: 0;
        padding: 20px;
      }

      .grid { grid-template-columns: 1fr 1fr; }
      .form-field { grid-column: span 2; }
      .form-actions { flex-direction: column; align-items: stretch; }
    }

    @media (max-width: 480px) {
      .grid { grid-template-columns: 1fr; }
      .form-field { grid-column: span 1; }
    }
  </style>
</head>

<body>
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <a href="<%=ctx%>/Dashboard" class="active">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar">👤 Usuarios</a>
    <a href="<%=ctx%>/ProductoServlet?accion=listar" class="active">📦 Productos</a>
    <a href="<%=ctx%>/InventarioServlet?accion=listar">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/Logout">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1>Gestión de Productos</h1>
    <p>Registra y administra los productos del sistema.</p>

    <!-- FORMULARIO -->
    <div class="card">
      <form action="<%=ctx%>/ProductoServlet" method="post" id="formProducto">
        <input type="hidden" name="accion" id="accion" value="agregar">
        <input type="hidden" name="id_producto" id="id_producto">

        <div class="grid">
          <div class="form-field" style="grid-column: span 4;">
            <label>Categoría</label>
            <select name="categoria" id="categoria" required>
              <option value="" disabled selected>— Selecciona —</option>
              <option value="pollo">Pollo</option>
              <option value="pavo">Pavo</option>
              <option value="gallina">Gallina</option>
              <option value="pato">Pato</option>
              <option value="codorniz">Codorniz</option>
              <option value="huevo">Huevo</option>
            </select>
          </div>

          <div class="form-field" style="grid-column: span 4;">
            <label>Nombre</label>
            <select name="nombre" id="nombre" required>
              <option value="" disabled selected>— Selecciona la categoría primero —</option>
            </select>
          </div>

          <div class="form-field" style="grid-column: span 4;">
            <label>Unidad de medida</label>
            <input type="text" name="unidad_medida" id="unidad_medida" placeholder="kg, unidad, docena..." readonly>
          </div>

          <div class="form-field" style="grid-column: span 8;">
            <label>Descripción</label>
            <input type="text" name="descripcion" id="descripcion" placeholder="Detalle del producto">
          </div>

          <div class="form-field" style="grid-column: span 2;">
            <label>Precio (S/.)</label>
            <input type="number" step="0.01" min="0" name="precio" id="precio" required>
          </div>

          <div class="form-field" style="grid-column: span 2;">
            <label>Stock</label>
            <input type="number" min="0" step="1" name="stock" id="stock" required>
          </div>

          <div class="form-field" style="grid-column: span 3;">
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

    <!-- TABLA -->
    <div class="card">
      <h3 style="margin-bottom: 10px;">Listado de productos</h3>
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
              boolean alerta = false;
              try { alerta = (p.getStockMinimo()!=null && p.getStock() <= p.getStockMinimo()); } catch(Exception ex) { alerta=false; }
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
/* === lógica original intacta === */
const CATALOGO = {
  "pollo": [
    { nombre: "Pollo entero", unidad: "unidad", precio: 18.00 },
    { nombre: "Pechuga de pollo", unidad: "kg", precio: 22.00 },
    { nombre: "Pierna de pollo", unidad: "kg", precio: 17.00 },
    { nombre: "Ala de pollo", unidad: "kg", precio: 14.00 },
    { nombre: "Menudencia de pollo", unidad: "kg", precio: 9.00 },
    { nombre: "Pollo pelado", unidad: "unidad", precio: 19.00 }
  ],
  "pavo": [
    { nombre: "Pavo entero", unidad: "unidad", precio: 70.00 },
    { nombre: "Pechuga de pavo", unidad: "kg", precio: 45.00 },
    { nombre: "Pierna de pavo", unidad: "kg", precio: 32.00 }
  ],
  "gallina": [
    { nombre: "Gallina viva", unidad: "unidad", precio: 25.00 },
    { nombre: "Gallina pelada", unidad: "unidad", precio: 30.00 },
    { nombre: "Gallina trozada", unidad: "kg", precio: 18.00 }
  ],
  "pato": [
    { nombre: "Pato entero", unidad: "unidad", precio: 40.00 },
    { nombre: "Pechuga de pato", unidad: "kg", precio: 38.00 }
  ],
  "codorniz": [
    { nombre: "Codorniz entera", unidad: "unidad", precio: 8.00 },
    { nombre: "Huevos de codorniz", unidad: "docena", precio: 6.00 }
  ],
  "huevo": [
    { nombre: "Huevo blanco", unidad: "jaba", precio: 18.00 },
    { nombre: "Huevo de corral", unidad: "jaba", precio: 22.00 },
    { nombre: "Huevo codorniz", unidad: "docena", precio: 7.00 }
  ]
};

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
let precioEditado = false;

precio.addEventListener("input", ()=>{ precioEditado = true; });

function cargarProductosPorCategoria(cat, seleccionado = "") {
  nombre.innerHTML = '<option value="" disabled selected>— Selecciona —</option>';
  const lista = CATALOGO[cat] || [];
  lista.forEach(item => {
    const opt = document.createElement("option");
    opt.value = item.nombre;
    opt.textContent = item.nombre;
    if (seleccionado && seleccionado === item.nombre) opt.selected = true;
    nombre.appendChild(opt);
  });
  const optOtro = document.createElement("option");
  optOtro.value = "OTRO";
  optOtro.textContent = "Otro (especificar manualmente)";
  nombre.appendChild(optOtro);
  unidad.value = ""; unidad.readOnly = false; setStepStock(""); precio.value = ""; precioEditado = false;
}

function autocompletarUnidad(cat, nom) {
  if (nom === "OTRO" || !CATALOGO[cat]) {
    unidad.readOnly = false;
    unidad.value = "";
    setStepStock("");
    if (!precioEditado) precio.value = ""; 
    return;
  }
  const item = (CATALOGO[cat] || []).find(i => i.nombre === nom);
  if (item) {
    unidad.value = item.unidad || "";
    unidad.readOnly = true;
    setStepStock(unidad.value);
    if (!precioEditado) {
      precio.value = item.precio != null ? Number(item.precio).toFixed(2) : "";
    }
  } else {
    unidad.readOnly = false;
  }
}

function setStepStock(unidadMedida) {
  stock.step = "1"; 
  if (!unidadMedida) return;
  const u = unidadMedida.toLowerCase();
  if (u === "kg" || u === "litro") stock.step = "0.001";
}

categoria.addEventListener("change", ()=>{
  cargarProductosPorCategoria(categoria.value);
});
nombre.addEventListener("change", ()=>{
  autocompletarUnidad(categoria.value, nombre.value);
});

form.addEventListener("submit", function(){});

function cargarEdicion(btn){
  accion.value = "actualizar";
  idProd.value = btn.dataset.id;

  const cat = (btn.dataset.categoria || "").toLowerCase();
  const nom = btn.dataset.nombre || "";
  categoria.value = cat || "";
  cargarProductosPorCategoria(categoria.value, nom);

  unidad.value = btn.dataset.unidad || "";
  autocompletarUnidad(categoria.value, nom);

  descripcion.value = btn.dataset.descripcion || "";
  precio.value = btn.dataset.precio || "";
  stock.value = btn.dataset.stock || "";
  prov.value = btn.dataset.proveedor || "";

  // Ya hay precio real cargado → no lo sobrescribimos luego
  precioEditado = true;

  btnGuardar.textContent = "Guardar cambios";
  btnCancelar.style.display = "inline-block";
  msg.textContent = "Editando ID " + idProd.value;
  msg.className = "mensaje";
}

btnCancelar.addEventListener("click", ()=>{
  accion.value = "agregar";
  idProd.value = "";
  form.reset();
  nombre.innerHTML = '<option value="" disabled selected>— Selecciona la categoría primero —</option>';
  unidad.readOnly = false;
  setStepStock("");
  precioEditado = false;
  btnGuardar.textContent = "Agregar producto";
  btnCancelar.style.display = "none";
  msg.textContent = "";
  msg.className = "mensaje";
});


(function init(){
  if (categoria.value) {
    cargarProductosPorCategoria(categoria.value, nombre.value);
    if (nombre.value) autocompletarUnidad(categoria.value, nombre.value);
  }
})();
</script>
</body>
</html>
