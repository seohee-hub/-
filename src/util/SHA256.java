package util;

import java.security.MessageDigest;

//회원가입 및 이메일 인증에 사용할 해시 데이터를 생성
public class SHA256 {
	public static String getSHA256 (String input) {
		StringBuffer result= new StringBuffer();
		try {
			// MessageDigest가 SHA-256으로 암호화된 값을 들고 있음
			MessageDigest digest= MessageDigest.getInstance("SHA-256");
			
			//해시 데이터를 생성할 때 악의적인 공격자가 원래의 데이터를 파악하기 어렵게 만듬
			byte[] salt= "Hello! This is Salt.".getBytes();
			digest.reset();
			digest.update(salt);
			byte[] chars= digest.digest(input.getBytes("UTF-8"));
			for(int i=0; i<chars.length; i++) {
				String hex= Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append("0");
				result.append(hex);
			}
 		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
