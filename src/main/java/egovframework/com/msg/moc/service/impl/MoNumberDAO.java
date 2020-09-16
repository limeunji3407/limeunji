package egovframework.com.msg.moc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.moc.service.MoNumber;


@Repository("MoNumberDAO")
public class MoNumberDAO extends EgovComAbstractDAO{
	
	/**
     * 주어진 조건에 따른 번호목록을 불러온다.
     */
	 
	public List<MoNumber> moNumberList(MoNumber moMoNumber) throws Exception {
        return selectList("MoNumberDAO.moNumberList", moMoNumber);
    }
	
	public String moNumberInsert(MoNumber moNumber) throws Exception{
		return String.valueOf((int)insert("MoNumberDAO.moNumberInsert", moNumber));
	}
	
	public String moNumberUpdate(MoNumber moNumber) throws Exception{
		return String.valueOf((int)update("MoNumberDAO.moMoNumberUpdate", moNumber));
	}
	
	public MoNumber searchMoNum(MoNumber moNumber) throws Exception{
		return selectOne("MoNumberDAO.searchMoNum", moNumber);
	}
}
