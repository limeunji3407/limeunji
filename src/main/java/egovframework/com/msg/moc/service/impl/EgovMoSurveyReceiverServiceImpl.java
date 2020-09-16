package egovframework.com.msg.moc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.moc.service.EgovMoSurveyReceiverService;
import egovframework.com.msg.moc.service.MoSurveyReceiverVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("egovMoSurveyReceiverService")
public class EgovMoSurveyReceiverServiceImpl extends EgovAbstractServiceImpl implements EgovMoSurveyReceiverService{
	
	@Resource(name = "MoSurveyReceiverDAO")
    private MoSurveyReceiverDAO moSurveyReceiverDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;

	@Override
	public List<MoSurveyReceiverVO> moSurveyReceiverList(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		List<MoSurveyReceiverVO> result = moSurveyReceiverDAO.moSurveyReceiverList(moSurveyReceiverVO);
        return result;
	}

	@Override
	public String moSurveyReceiverInsert(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		String result = moSurveyReceiverDAO.moSurveyReceiverInsert(moSurveyReceiverVO);
		return result;
	}

	@Override
	public String moSurveyReceiverUpdate(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		String result = moSurveyReceiverDAO.moSurveyReceiverUpdate(moSurveyReceiverVO);
		return result;
	}

	@Override
	public String moSurveyReceiverDelete(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
		String result = moSurveyReceiverDAO.moSurveyReceiverDelete(moSurveyReceiverVO);
		return result;
	}

}
