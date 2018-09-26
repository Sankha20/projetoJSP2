package projetoJSP2;

public class Usuario {
	
	private String nome;
	private boolean isAdmin;
	
	public Usuario(String nome, boolean admin) {
		this.nome = nome;
		this.isAdmin = admin;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	
	

}
