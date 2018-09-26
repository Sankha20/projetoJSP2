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
<link rel="stylesheet" href="style/style.css?5">

<title>Dashboard | The Kings Hotel</title>
</head>

<%
	Conexao c = new Conexao();
	ResultSet rs = c.selectUsuarios();

	System.out.println("USUARIO: " + Geral.usuario);

	if (Geral.usuario == null) {
		response.sendRedirect("./index.jsp");

	}

	String userName = Geral.usuario.getNome();
	boolean isAdmin = Geral.usuario.isAdmin();
	String userPriv = isAdmin ? "Admin" : "Funcionário";

	String action = request.getParameter("action");

	if (action != null && action.equals("deletar")) {

		System.out.println("Action: DELETAR");

		int id = Integer.parseInt(request.getParameter("id"));

		boolean success = c.deleteUsuario(id);

		String newUrl = "";

		if (success) {
			newUrl = "./usuarios.jsp?action=deletesuccess";
		} else {
			newUrl = "./usuarios.jsp?action=deletefail";
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

				<!-- 
				<a href="quartos.html">
					<li>Quatos</li>
				</a>
				 -->

			</ul>

		</aside>

		<article>

			<h2>Usuarios</h2>

			<a href="insertUsuario.jsp?action=novo">Novo usuário</a>

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>Usuário</th>
						<th>Senha</th>
						<th>Admin</th>
						<th colspan="2">Comandos</th>
					</tr>
				</thead>

				<tbody>
					<%
						while (rs != null && rs.next() && isAdmin) {
							int id = rs.getInt("id");
							String nome = rs.getString("nome");
							String user = rs.getString("usuario");
							String pass = rs.getString("senha");
							String priv = rs.getInt("is_admin") == 1 ? "Sim" : "Não";
					%>
					<tr>
						<td><%=id%></td>
						<td><%=nome%></td>
						<td><%=user%></td>
						<td><%=pass%></td>
						<td><%=priv%></td>
						<td><a
							href="insertUsuario.jsp?action=editmode&nome=<%=nome%>&usuario=<%=user%>&senha=<%=pass%>&id=<%=id%>">
								Editar </a></td>
						<td><a href="usuarios.jsp?action=deletar&id=<%=id%>">Deletar</a></td>
					</tr>

					<%
						}
					%>
				</tbody>
			</table>

			<%
				if (!isAdmin)
					out.println("Você não tem permissão para ver os dados dos funcionários.");
			%>

			<%
				String msg = "";
				boolean display = true;
				if (action != null) {
					if (action.equals("deletesuccess")) {
						msg = "Deletado com sucesso.";
					} else if (action.equals("deletefail")) {
						msg = "Falha ao deletar.";
					}

					else if (action.equals("insertsuccess")) {
						msg = "Inserido com sucesso.";
					} else if (action.equals("insertfail")) {
						msg = "Erro ao inserir. Confira os dados.";
					}

					else if (action.equals("updatesuccess")) {
						msg = "Atualizado com sucesso.";
					} else if (action.equals("updatefail")) {
						msg = "Erro ao atualizar. Confira os dados.";
					}

					else {
						display = false;
					}
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