<%@page import="modelo.Inventario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  if (request.getAttribute("listaInventario") == null) {
    response.sendRedirect(ctx + "/InventarioServlet?accion=listar");
    return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Inventario - Avícola D&D</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  
  <!-- Fuente y Bootstrap -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root {
      --brand: #d32f2f;
      --brand-dark: #b71c1c;
      --accent: #f9a825;
      --bg-light: #fff8f8;
    }

    * { font-family: 'Poppins', sans-serif; }

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
    }

    .main-content h1 {
      color: var(--brand);
      font-weight: 700;
      margin-bottom: 25px;
    }

    /* ==== CARD Y TABLA ==== */
    .card {
      background: #fff;
      border: none;
      border-radius: 14px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.1);
      padding: 22px 24px;
      animation: fadeIn 0.6s ease;
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
    }

    th, td {
      padding: 10px 12px;
      border: 1px solid #eee;
      text-align: center;
    }

    th {
      background: var(--brand);
      color: #fff;
    }

    tr:nth-child(even){ background:#fafafa; }

    .mono { font-variant-numeric: tabular-nums; }

    .badge-low { 
      display:inline-block; 
      padding:2px 8px; 
      border-radius:999px; 
      background:#ffebee; 
      color:#c62828; 
      font-size:12px; 
      font-weight:700; 
    }

    button {
      background: var(--brand);
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 6px 10px;
      cursor: pointer;
      transition: background 0.3s;
    }

    button:hover {
      background: var(--brand-dark);
    }

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

      .sidebar h3 { display: none; }

      table { font-size: 14px; }
      th, td { padding: 8px; }
    }
  </style>
</head>

<body>
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <a href="<%=ctx%>/Dashboard" class="active">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar">👤 Usuarios</a>
    <a href="<%=ctx%>/ProductoServlet?accion=listar">? Productos</a>
    <a href="<%=ctx%>/InventarioServlet?accion=listar" class="active">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/vistas/login.jsp">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1>Inventario</h1>

    <div class="card">
      <table>
        <tr>
          <th>ID</th>
          <th>Producto</th>
          <th>Unidad</th>
          <th>Categoría</th>
          <th>Stock actual</th>
          <th>Mínimo</th>
          <th>Máximo</th>
          <th>Acciones</th>
        </tr>
        <%
          List<Inventario> lista = (List<Inventario>) request.getAttribute("listaInventario");
          if (lista != null && !lista.isEmpty()) {
            for (Inventario inv : lista) {
              boolean bajo = (inv.getStockMinimo()!=null && inv.getStockActual() <= inv.getStockMinimo());
        %>
        <tr>
          <td class="mono"><%= inv.getId_producto() %></td>
          <td><%= inv.getNombreProducto() %></td>
          <td><%= inv.getUnidad_medida()==null?"":inv.getUnidad_medida() %></td>
          <td><%= inv.getCategoria()==null?"":inv.getCategoria() %></td>
          <td class="mono">
            <%= (inv.getUnidad_medida()!=null && inv.getUnidad_medida().equalsIgnoreCase("kg"))
                  ? String.format(java.util.Locale.US,"%.3f", inv.getStockActual())
                  : String.format(java.util.Locale.US,"%.0f", inv.getStockActual()) %>
            <% if (bajo) { %><span class="badge-low">¡Bajo!</span><% } %>
          </td>
          <td class="mono"><%= inv.getStockMinimo()==null ? "-" : inv.getStockMinimo() %></td>
          <td class="mono"><%= inv.getStockMaximo()==null ? "-" : inv.getStockMaximo() %></td>
          <td>
            <form action="<%=ctx%>/InventarioServlet" method="post" style="display:flex;gap:6px;align-items:center;justify-content:center;flex-wrap:wrap;">
              <input type="hidden" name="accion" value="guardar-limites">
              <input type="hidden" name="id_producto" value="<%=inv.getId_producto()%>">
              <input type="number" name="stock_minimo" placeholder="Mín" style="width:80px"
                     value="<%= (inv.getStockMinimo()==null ? "" : String.valueOf(inv.getStockMinimo())) %>">

              <input type="number" name="stock_maximo" placeholder="Máx" style="width:80px"
                     value="<%= (inv.getStockMaximo()==null ? "" : String.valueOf(inv.getStockMaximo())) %>">

              <button type="submit">Guardar</button>
            </form>
          </td>
        </tr>
        <%  }
          } else { %>
        <tr><td colspan="8" style="text-align:center;">No hay productos</td></tr>
        <% } %>
      </table>
    </div>
  </div>
</body>
</html>

