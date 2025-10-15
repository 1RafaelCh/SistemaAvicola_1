<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Avícola David & Daniel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Fuente moderna -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      /* ? Fondo personalizado  proyecto */
      --bg-url: url('<%=ctx%>/recursos/img/fondo_index.jpg');
      --brand: #d32f2f;
      --brand-dark: #b71c1c;
      --accent: #f9a825;
    }

    * {
      font-family: 'Poppins', sans-serif;
    }

    html, body { height: 100%; margin: 0; }

    body {
      background: 
        linear-gradient(rgba(0,0,0,.45), rgba(0,0,0,.45)),
        var(--bg-url) center/cover no-repeat fixed;
      display: flex;
      flex-direction: column;
      color: #333;
    }

    .page-wrap {
      min-height: 100%;
      display: flex;
      flex-direction: column;
    }

    header {
      background: rgba(0,0,0,0.4);
      color: #fff;
      backdrop-filter: blur(2px);
    }

    .hero {
      flex: 1;
      display: grid;
      place-items: center;
      padding: 24px;
    }

    .brand-card {
      width: min(560px, 92vw);
      background: #ffffffee;
      border-radius: 18px;
      border: none;
      box-shadow: 0 10px 35px rgba(0,0,0,.25);
      padding: 32px 28px;
      backdrop-filter: blur(4px);
      animation: fadeInUp 0.8s ease;
    }

    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .brand-card .logo {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 14px;
      background: #fff;
      box-shadow: 0 2px 10px rgba(0,0,0,.1);
      padding: 6px;
    }

    .brand-title {
      color: var(--brand);
      font-weight: 700;
      margin-bottom: 4px;
    }

    .brand-sub {
      color: #5f6368;
      font-size: 0.95rem;
      margin-bottom: 18px;
    }

    .lead {
      color: #374151;
      font-size: 1.05rem;
    }

    .btn-brand {
      background: linear-gradient(45deg, var(--brand), var(--accent));
      border: none;
      padding: 12px 18px;
      font-weight: 600;
      border-radius: 10px;
      color: #fff;
      transition: 0.25s;
    }

    .btn-brand:hover {
      transform: translateY(-2px);
      background: linear-gradient(45deg, var(--brand-dark), var(--accent));
    }

    .site-footer {
      flex-shrink: 0;
      color: #fff;
      background: rgba(0,0,0,.5);
      backdrop-filter: blur(3px);
      padding: 12px;
      font-size: .9rem;
    }
    @media (max-width: 480px) {
      .lead { font-size: .95rem; }
    }
  </style>
</head>
<body>
  <div class="page-wrap">
    <header class="py-3 px-3 d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center gap-2">
        <!-- Logo local -->
        <img src="<%=ctx%>/recursos/img/logo.png" alt="Logo" width="38" height="38" />
        <span class="fw-semibold">Avícola D&amp;D</span>
      </div>
    </header>

    <main class="hero">
      <div class="card brand-card text-center">
        <img class="logo mx-auto" src="<%=ctx%>/recursos/img/logo.png" alt="Logo Avícola" />
        <h1 class="display-6 brand-title mt-3">Avícola David &amp; Daniel</h1>
        <p class="brand-sub">Sistema de Gestión de Ventas, Productos e Inventario</p>
        <hr class="my-3">
        <p class="lead px-2">
          Bienvenido al panel administrativo. Gestiona <strong>productos</strong>,
          controla <strong>inventario</strong> y emite <strong>reportes</strong> desde un solo lugar.
        </p>
        <div class="d-grid mt-4">
          <a href="<%=ctx%>/vistas/login.jsp" class="btn btn-brand btn-lg">
            🔐 Iniciar sesión
          </a>
        </div>

        <div class="row text-center mt-4 g-3">
          <div class="col-4">
            <small class="text-muted">Seguridad</small>
            <div class="fw-semibold">Roles y permisos</div>
          </div>
          <div class="col-4">
            <small class="text-muted">Inventario</small>
            <div class="fw-semibold">Stock en tiempo real</div>
          </div>
          <div class="col-4">
            <small class="text-muted">Reportes</small>
            <div class="fw-semibold">Ventas y KPI</div>
          </div>
        </div>
      </div>
    </main>

    <footer class="site-footer text-center">
      © <%= java.time.Year.now() %> Avícola David &amp; Daniel — Todos los derechos reservados 🐣
    </footer>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
