package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

//����ڿ��� SMTP�� �̿��� �̸��� ���� �޽����� �����ϱ� ���� Ŭ����
public class Gmail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("vhsxm104", "jungtoto12!");
	}
	
}
