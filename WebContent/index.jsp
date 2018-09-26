<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page language="java" import="projetoJSP2.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<link rel="stylesheet" href="style/reset.css">
<link rel="stylesheet" href="style/main.css?1">

<title>The Kings Hotel</title>
</head>

<body>

<%
	String usuario = request.getParameter("usuario");
	
	String status = "";

	if (usuario != null) {
		String senha = request.getParameter("senha");
		Conexao c = new Conexao();

		boolean success = c.fazerLogin(usuario, senha);

		if (success) {
			String newUrl = "./usuarios.jsp?action=display";
			response.sendRedirect(newUrl);
		} else {
			status = "Senha inválida"; 
		}
	}
%>

	<div id="main-login">

		<form id="login-form" action="index.jsp" method="post">
			<img id="main-logo" src="media/logo-e.png" alt="Logotipo">
			<h1>The Kings Hotel</h1>
			<fieldset>

				<label for="usuario">Usuário:</label> <br> 
				<input type="text" name="usuario" id="usuario" placeholder="user: admin | pass: admin"> <br> 
				
				<label for="senha">Senha:</label> <br> 
				<input type="password" name="senha" id="senha"> <br>
				
				<% if (!status.isEmpty()) {%>
					<p id="main-status"><%= status %></p>
				<%} %>
				
				<input type="submit" value="Confirmar">
				
				
			</fieldset>
		</form>

	</div>

</body>

</html>