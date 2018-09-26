package projetoJSP2;

public class Geral {
	public static Usuario usuario = null;
	
	public static boolean compare(String s1, String s2) {
		return (s1 != null && s2 != null && s1.equals(s2));
	}
	
	public static boolean notEmpty(String... strings) {
		
		for (String str: strings) {
			if (str.isEmpty()) return false;
		}
		
		return true;		
	}
}
