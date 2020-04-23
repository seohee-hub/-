package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

//사용자에게 SMTP를 이용해 이메일 인증 메시지를 전송하기 위한 클래스
public class Gmail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("vhsxm104", "jungtoto12!");
	}
	
}
