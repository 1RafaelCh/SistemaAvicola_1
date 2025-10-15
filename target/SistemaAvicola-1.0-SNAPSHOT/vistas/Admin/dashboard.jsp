<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath(); // ej: /SistemaAvicola_1

    // Valores desde el servlet (defaults si entran directo)
    Integer totalUsuarios    = (request.getAttribute("totalUsuarios")==null)? 0 : (Integer) request.getAttribute("totalUsuarios");
    Integer productosActivos = (request.getAttribute("productosActivos")==null)? 0 : (Integer) request.getAttribute("productosActivos");
    Long    stockTotal       = (request.getAttribute("stockTotal")==null)? 0L : (Long) request.getAttribute("stockTotal");
    Double  ventasHoy        = (request.getAttribute("ventasHoy")==null)? 0.0 : (Double) request.getAttribute("ventasHoy");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel de Administración - Avícola D&D</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  
  <!-- Fuente y Bootstrap -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root { --brand:#d32f2f; --brand-dark:#b71c1c; --accent:#f9a825; --bg-light:#fff8f8; }
    * { font-family: 'Poppins', sans-serif; }
    body { display:flex; margin:0; background:var(--bg-light); min-height:100vh; }

    .sidebar { width:230px; background:linear-gradient(180deg, var(--brand), var(--brand-dark)); color:#fff;
               display:flex; flex-direction:column; padding:22px 15px; box-shadow:4px 0 12px rgba(0,0,0,.2);
               position:fixed; height:100vh; }
    .sidebar h3 { text-align:center; font-weight:700; margin-bottom:28px; letter-spacing:.5px; }
    .sidebar a { color:#fff; text-decoration:none; padding:10px 14px; border-radius:10px; margin-bottom:8px; display:block; font-weight:500; transition:.25s; }
    .sidebar a:hover { background:rgba(255,255,255,.15); transform:translateX(4px); }
    .sidebar a.active { background:var(--accent); color:#222; font-weight:600; }

    .main-content { margin-left:230px; padding:30px 40px; flex:1; }
    .main-content h1 { color:var(--brand); font-weight:700; margin-bottom:10px; }
    .main-content p { color:#555; font-size:1rem; margin-bottom:28px; }

    .cards { display:grid; grid-template-columns: repeat(4, minmax(0,1fr)); gap:16px; margin-bottom:18px; }
    .kpi { background:#fff; border:none; border-radius:14px; box-shadow:0 4px 16px rgba(0,0,0,.1); padding:18px; }
    .kpi h4 { margin:0; font-size:14px; color:#666; }
    .kpi .val { font-size:28px; font-weight:800; color:#222; }

    .card { background:#fff; border:none; border-radius:14px; box-shadow:0 4px 16px rgba(0,0,0,.1); padding:22px 24px; max-width:600px; }
    .card h2 { color:var(--brand-dark); font-size:1.3rem; margin-bottom:12px; }
    .card ul { list-style:none; padding:0; margin:0; }
    .card li { padding:10px 0; border-bottom:1px solid #eee; color:#444; }
    .card li:last-child { border-bottom:none; }

    @media (max-width: 992px){ .cards{ grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 768px){
      .sidebar { width:100%; height:auto; flex-direction:row; justify-content:space-around; position:relative; box-shadow:none; }
      .main-content { margin-left:0; padding:20px; }
      .sidebar h3 { display:none; }
      .cards{ grid-template-columns:1fr; }
    }
  </style>
</head>

<body>
  <div class="sidebar">
    <h3>🐔 Avícola D&D</h3>
    <!-- Inicio ahora va al servlet -->
    <a href="<%=ctx%>/Dashboard" class="active">🏠 Inicio</a>
    <a href="<%=ctx%>/UsuarioServlet?accion=listar">👤 Usuarios</a>
    <a href="<%=ctx%>/ProductoServlet?accion=listar">📦 Productos</a>
    <a href="<%=ctx%>/InventarioServlet?accion=listar">📊 Inventario</a>
    <a href="<%=ctx%>/vistas/admin/reportes.jsp">📈 Reportes</a>
    <a href="<%=ctx%>/vistas/admin/proveedores.jsp">🚚 Proveedores</a>
    <a href="<%=ctx%>/vistas/login.jsp">🚪 Cerrar sesión</a>
  </div>

  <div class="main-content">
    <h1>Bienvenido, Administrador</h1>
    <p>Desde este panel puedes gestionar usuarios, productos, inventario, reportes y proveedores.</p>

    <!-- KPIs -->
    <div class="cards">
      <div class="kpi">
        <h4>Total de usuarios</h4>
        <div class="val"><%= totalUsuarios %></div>
      </div>
      <div class="kpi">
        <h4>Productos activos</h4>
        <div class="val"><%= productosActivos %></div>
      </div>
      <div class="kpi">
        <h4>Stock total</h4>
        <div class="val"><%= stockTotal %></div>
      </div>
      <div class="kpi">
        <h4>Ventas de hoy</h4>
        <div class="val">S/ <%= String.format(java.util.Locale.US, "%.2f", ventasHoy) %></div>
      </div>
    </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

