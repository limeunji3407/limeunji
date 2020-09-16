package egovframework.com.msg.moc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.moc.service.MoSurveyReceiverVO;


@Repository("MoSurveyReceiverDAO")
public class MoSurveyReceiverDAO extends EgovComAbstractDAO {
	
	public List<MoSurveyReceiverVO> moSurveyReceiverList(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception {
        return selectList("MoSurveyReceiverDAO.moSurveyReceiverList", moSurveyReceiverVO);
    }
	
	public String moSurveyReceiverInsert(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception{
		return String.valueOf((int)insert("MoSurveyReceiverDAO.moSurveyReceiverInsert", moSurveyReceiverVO));
	}
	
	public String moSurveyReceiverUpdate(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception{
		return String.valueOf((int)update("MoSurveyReceiverDAO.moSurveyReceiverUpdate", moSurveyReceiverVO));
	}
	
	public String moSurveyReceiverDelete(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception{
		return String.valueOf((int)delete("MoSurveyReceiverDAO.moSurveyReceiverDelete", moSurveyReceiverVO));
	}
}
