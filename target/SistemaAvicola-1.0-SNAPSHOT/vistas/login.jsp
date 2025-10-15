<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Iniciar sesión - Avícola David & Daniel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap y fuente -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --bg-url: url('<%=ctx%>/recursos/img/fondo_index.jpg');
      --brand: #d32f2f;
      --brand-dark: #b71c1c;
      --accent: #f9a825;
    }

    * {
      font-family: 'Poppins', sans-serif;
    }

    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(rgba(0,0,0,.45), rgba(0,0,0,.45)),
                  var(--bg-url) center/cover no-repeat fixed;
    }

    .login-card {
      width: min(380px, 92vw);
      background: #ffffffee;
      border: none;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0,0,0,.3);
      padding: 30px 28px;
      text-align: center;
      backdrop-filter: blur(5px);
      animation: fadeIn 0.7s ease-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(15px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .login-card img {
      width: 90px;
      height: 90px;
      border-radius: 12px;
      object-fit: cover;
      background: #fff;
      box-shadow: 0 2px 10px rgba(0,0,0,.1);
    }

    h2 {
      color: var(--brand);
      font-weight: 700;
      margin-top: 14px;
      margin-bottom: 6px;
    }

    p.subtitle {
      color: #666;
      font-size: 0.9rem;
      margin-bottom: 18px;
    }

    input {
      width: 100%;
      margin: 8px 0;
      padding: 11px 12px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 0.95rem;
      transition: 0.25s;
    }
    input:focus {
      outline: none;
      border-color: var(--brand);
      box-shadow: 0 0 6px rgba(211,47,47,.3);
    }

    button {
      background: linear-gradient(45deg, var(--brand), var(--accent));
      color: white;
      border: none;
      padding: 11px;
      font-weight: 600;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      margin-top: 10px;
      transition: 0.25s;
    }
    button:hover {
      transform: translateY(-2px);
      background: linear-gradient(45deg, var(--brand-dark), var(--accent));
    }

    .error {
      color: #c62828;
      font-weight: 500;
      font-size: 0.9rem;
      margin-top: 10px;
    }

    .back-link {
      display: block;
      margin-top: 16px;
      color: #555;
      text-decoration: none;
      font-size: 0.9rem;
    }
    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="login-card">
    <img src="<%=ctx%>/recursos/img/logo.png" alt="Logo Avícola">
    <h2>Iniciar Sesión</h2>
    <p class="subtitle">Panel administrativo de Avícola D&amp;D</p>

    <form action="<%=ctx%>/LoginServlet" method="post">
      <input type="email" name="email" placeholder="Correo electrónico" required>
      <input type="password" name="password" placeholder="Contraseña" required>
      <button type="submit">Ingresar 🔐</button>
    </form>

    <% if (request.getParameter("error") != null) { %>
      <div class="error">⚠️ Usuario o contraseña incorrectos.</div>
    <% } %>

    <a href="<%=ctx%>/index.jsp" class="back-link">← Volver al inicio</a>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
