package egovframework.com.mng.msd.service;


/**
 
 */
public interface EgovMessageLineConfigService {

	public MessageLineConfigVO selectMessageLineConfig() throws Exception;
	public String insertMessageLineConfig(MessageLineConfigVO msglineconfVO) throws Exception; 
    public Integer countRole() throws Exception;
    public void updateMessageLineConfig(MessageLineConfigVO cfgvo) throws Exception;
}