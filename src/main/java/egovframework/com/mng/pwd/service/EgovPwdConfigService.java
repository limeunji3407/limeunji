package egovframework.com.mng.pwd.service;

public interface EgovPwdConfigService {
	
	public PasswordSetVO pwSet() throws Exception;
	
	public void pwdConfigInsert(PasswordSetVO passwordSetVO) throws Exception;
	
	public void pwdConfigUpdate(PasswordSetVO passwordSetVO) throws Exception;
}
