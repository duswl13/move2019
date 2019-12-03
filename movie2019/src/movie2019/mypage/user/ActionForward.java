package movie2019.mypage.user;

//ActionForward Ŭ������ Action �������̽����� ������ �����ϰ� ��� ���� ������ ������ �� �� ���Ǵ� Ŭ���� �Դϴ�.
//�� Ŭ������ Redirect ���� ���� �������� �������� ��ġ�� ������ �ֽ��ϴ�.
//�� ������ FrontController���� ActionForward Ŭ���� Ÿ������ ��ȯ����
//�������� �� ���� Ȯ���Ͽ� �ش��ϴ� ��û �������� ������ ó���� �մϴ�.
public class ActionForward {
	private boolean redirect=false;
	private String path=null;
	
	//property redirect�� is �޼ҵ�
	public boolean isRedirect() {
		//������Ƽ Ÿ���� boolean�� ��� get ��� is�� �տ� ���� �� �ֽ��ϴ�.
		return redirect;
	}
	public String getPath() {
		return path;
	}
	//property redirect�� set �޼ҵ�
	public void setRedirect(boolean b) {
		this.redirect = b;
	}

	public void setPath(String path) {
		this.path = path;
	}
}