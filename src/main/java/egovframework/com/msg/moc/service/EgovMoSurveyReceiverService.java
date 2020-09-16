package egovframework.com.msg.moc.service;

import java.util.List;

public interface EgovMoSurveyReceiverService {

	public List<MoSurveyReceiverVO> moSurveyReceiverList(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception;
	
	public String moSurveyReceiverInsert(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception;
	
	public String moSurveyReceiverUpdate(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception;
	
	public String moSurveyReceiverDelete(MoSurveyReceiverVO moSurveyReceiverVO) throws Exception;
}
