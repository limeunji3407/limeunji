package egovframework.com.mng.pwd.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mng.pwd.service.EgovPwdConfigService;
import egovframework.com.mng.pwd.service.PasswordSetVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("egovPwdConfigService")
public class EgovPwdConfigServiceImpl extends EgovAbstractServiceImpl implements EgovPwdConfigService{

	@Resource(name="pwdConfigDAO")
	private PwdConfigDAO pwdConfigDAO;

	@Override
	public PasswordSetVO pwSet() throws Exception{
		return pwdConfigDAO.pwSet();
	}

	@Override
	public void pwdConfigInsert(PasswordSetVO passwordSetVO) throws Exception {
		pwdConfigDAO.pwdConfigInsert(passwordSetVO);
	}

	@Override
	public void pwdConfigUpdate(PasswordSetVO passwordSetVO) throws Exception {
		pwdConfigDAO.pwdConfigUpdate(passwordSetVO);
	}
}
