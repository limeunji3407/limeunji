package egovframework.com.mng.mem.service;

/**
 * 메세지권한에 관한 인터페이스클래스를 정의한다.
 * @author 김수로
 * @since 2020.02
 * @version 1.0
 * @see
 *
 * 
 */
public interface EgovMessageRoleService {

	/**
	 *  
	 * @param adminId 관리자아이디
	 * @return MessageRoleVO  
	 * @throws Exception
	 */
	public MessageRoleVO selectMessageRole() throws Exception;
	
	
	/**
	 * @param MessageRoleVO 메세지권한등록
	 * @return 등록결과
	 * @throws Exception
	 */
	public String insertMessageRole(MessageRoleVO msgRoleVO) throws Exception;
	public void updateMessageRole(MessageRoleVO msgRoleVO) throws Exception;
	
	public void insMsgPartCash(MessageRoleVO msgRoleVO) throws Exception;
	public void updMsgPartCash(MessageRoleVO msgRoleVO) throws Exception;
	
	public void insMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception;
	public void updMsgUsrCash(MessageRoleVO msgRoleVO) throws Exception;
	
	public String insertMessageCash(MessageRoleVO msgRoleVO) throws Exception;

	public Integer countRole() throws Exception;
	 
  

}