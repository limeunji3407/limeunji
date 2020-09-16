package egovframework.com.mng.pwd.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.mng.pwd.service.PasswordSetVO;

@Repository("pwdConfigDAO")
public class PwdConfigDAO extends EgovComAbstractDAO{
	
	public PasswordSetVO pwSet() throws Exception{
		return selectOne("PwdConfigDAO.pwSet");
	}
	
	public void pwdConfigInsert(PasswordSetVO passwordSetVO) throws Exception {
		insert("PwdConfigDAO.pwdConfigInsert", passwordSetVO);
	}

	public void pwdConfigUpdate(PasswordSetVO passwordSetVO) throws Exception {
		update("PwdConfigDAO.pwdConfigUpdate", passwordSetVO);
	}
}
