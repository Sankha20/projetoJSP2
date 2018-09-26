package projetoJSP2;

import java.sql.*;

public class Conexao {
	private String usuario = "usuario";
	private String senha = "usuario";
	private String dbName = "kingshotel";
	private String CSTRING = "jdbc:mysql://localhost:3306/"
			+ dbName
			+ "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&useSSL=false";
	
	
	private Connection criarConexao() {
		Connection connection = null;
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(
					CSTRING, usuario, senha);
		} catch (Exception e) {
			System.out.println("Erro: Conexao > criarConexao");
			System.err.println(e);
		}
		
		return connection;
	}
	
	public boolean fazerLogin(String user, String pass) {
		
		String query = "SELECT nome, senha, is_admin FROM usuarios WHERE usuario = ?;";
		
		boolean success = false;
	
		try {
			Connection c = criarConexao();
			PreparedStatement ps = c.prepareStatement(query);
			
			ps.setString(1, user);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				String senha = rs.getString("senha");
				String nome = rs.getString("nome");
				boolean isAdmin = Integer.parseInt(rs.getString("is_admin")) == 1 ? true: false;
				
				if (pass.equals(senha)) {
					Geral.usuario = new Usuario(nome, isAdmin);
					return true;
				}
			}
		} catch (SQLException e) {
			System.err.println(e);
		}
		
		return success;
	}
	
	public ResultSet selectUsuarios() {
		ResultSet rs = null;
		String query = "SELECT * FROM usuarios WHERE is_admin = 0;";
		
		try {
			Connection c = criarConexao();
			Statement stm = c.createStatement();
			return stm.executeQuery(query);
			
		} catch (SQLException e) {
			System.out.println("Erro: Conexao > selectUsuarios");
			System.err.println(e);
		}
		
		return rs;
	}
	
	public boolean deleteUsuario(int id) {
		String query = "DELETE FROM usuarios WHERE id = ?;";
		
		try {
			Connection c = criarConexao();
			PreparedStatement stm = c.prepareStatement(query);
			
			stm.setInt(1, id);
			
			stm.execute();
			
			return true;
			
			
		} catch (Exception e) {
			System.out.println("Erro: Conexao > deleteUsuario");
			System.err.println(e);
		}
		return false;
	}
	
	public boolean insertUsuario(String nome, String usuario, String senha) {
		String query = "INSERT INTO usuarios (nome, usuario, senha, is_admin) VALUES (?, ?, ?, 0);";
		
		try {
			Connection c = criarConexao();
			PreparedStatement stm = c.prepareStatement(query);
			
			stm.setString(1, nome);
			stm.setString(2, usuario);
			stm.setString(3, senha);
			
			stm.execute();
			
			return true;			
		} catch (SQLException e) {
			System.out.println("Erro: Conexao > insertUsuario");
			System.err.println(e);
		}
		
		return false;
	}
	
	public int updateUsuario(int id, String nome, String usuario, String senha) {
		
		String query = "UPDATE usuarios SET nome = ?, usuario = ?, senha = ? WHERE id = ?;";
		
		try {
			Connection c = criarConexao();
			PreparedStatement stm = c.prepareStatement(query);
			
			stm.setString(1, nome);
			stm.setString(2, usuario);
			stm.setString(3, senha);
			stm.setInt(4, id);
			
			int amt = stm.executeUpdate();
			
			c.close();
			
			return amt;
			
		} catch (SQLException e) {
			System.out.println("Erro: Conexao > updateUsuario");
			System.err.println(e);
		}
		
		return 0;
	}
}
