<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page language="java" import="java.sql.*, projetoJSP2.*"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<link rel="stylesheet" href="style/reset.css">
<link rel="stylesheet" href="style/style.css?6">

<title>Novo Usuário | The Kings Hotel</title>
</head>

<%
	Conexao c = new Conexao();
	ResultSet rs = c.selectUsuarios();

	String userName = Geral.usuario.getNome();
	boolean isAdmin = Geral.usuario.isAdmin();
	String userPriv = isAdmin ? "Admin" : "Funcionário";

	String action = request.getParameter("action");

	if (Geral.compare(action, "add")) {

		System.out.println("Action: ADD");

		String nome = request.getParameter("nome");
		String usuario = request.getParameter("usuario");
		String senha = request.getParameter("senha");
		
		boolean success = false;
		
		if (Geral.notEmpty(nome, usuario, senha)) {
			success = c.insertUsuario(nome, usuario, senha);
		}

		String newUrl = "";

		if (success) {
	newUrl = "./usuarios.jsp?action=insertsuccess";
		} else {
	newUrl = "./usuarios.jsp?action=insertfail";
		}
		response.sendRedirect(newUrl);
		
		
	} else if (Geral.compare(action, "edit")) {

		System.out.println("Action: EDIT");

		String nome = request.getParameter("nome");
		String usuario = request.getParameter("usuario");
		String senha = request.getParameter("senha");
		String sid = request.getParameter("id");
		sid = sid.replaceAll(" ", "");
		
		boolean success = false;
		
		if (Geral.notEmpty(nome, usuario, senha, sid)) {
			System.err.println(nome + " - " + usuario + " - " + senha + " - " + sid);
			
			int id = Integer.parseInt( sid );
			int amt = c.updateUsuario(id, nome, usuario, senha);
			if (amt > 0) success = true;
		}

		String newUrl = "";

		if (success) {
	newUrl = "./usuarios.jsp?action=updatesuccess";
		} else {
	newUrl = "./usuarios.jsp?action=updatefail";
		}
		response.sendRedirect(newUrl);
	}
%>

<body>

	<div id="msg">
		<div id="box">
			<p id="msg-p">STATUS MSG</p>
			<input type="button" value="Ok" onclick="fecharMsg()">
		</div>
	</div>
	
	<script src="scripts/script.js"></script>

	<header>
		<h1>The Kings Hotel</h1>
	</header>

	<div id="dash-main">
		<aside>

			<img src="media/logo-e.png" alt="Logotipo">

			<div id="title">
				<p>
					Usuário: <span class="hl"><%=userName%></span>
				</p>
				<p>
					Privilégio: <span class="hl"><%=userPriv%></span>
				</p>
			</div>

			<ul>
				<a href="usuarios.jsp?action=display">
					<li>Usuários</li>
				</a>

				<a href="quartos.html">
					<li>Quatos</li>
				</a>

			</ul>

		</aside>

		<article>

			<h2>Novo usuário</h2>

			
			<form action="insertUsuario.jsp" method="post">
                <label for="nome">Nome</label>
                <input type="text" name="nome" id="nome" value="<%= 
                	request.getParameter("nome") == null ? "" : request.getParameter("nome")%>">
                
                <label for="usuario">Usuário</label>
                <input type="text" name="usuario" id="usuario" value="<%= 
                	request.getParameter("usuario") == null ? "" : request.getParameter("usuario") %>">
                
                <label for="senha">Senha</label>
                <input type="text" name="senha" id="senha" value="<%= 
                	request.getParameter("senha") == null ? "" : request.getParameter("senha") %>">
                	
                <input type="hidden" name="id" value="<%= 
                	request.getParameter("id") == null ? "" : request.getParameter("id") %> ">
                
                
                <input type="hidden" name="action" value="<%= Geral.compare(request.getParameter("action"), "novo") ? "add": "edit"%>">

                <input type="submit" value="Confirmar">
            </form>
			

			<%
				String msg = "";
				boolean display = true;
				if (action != null) {
					if (action.equals("deletesuccess")) {
						msg = "Deletado com sucesso.";
					} else if (action.equals("deletefail")) {
						msg = "Falha ao deletar.";
					} else {
						display = false;
					}
				} else {
					display = false;
				}

				if (display) {
			%>

			<script>
			setTimeout( () => {
				setMsg("<%=msg%>");
				console.log("MSG");
			}, 100);
			</script>

			<%
				}
			%>


		</article>

	</div>

	<footer> </footer>	

</body>

</html>