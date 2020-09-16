package egovframework.com.msg.moc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.msg.moc.service.EgovMoNumberService;
import egovframework.com.msg.moc.service.MoNumber;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("egovMoNumberService")
public class EgovMoNumberServiceImpl extends EgovAbstractServiceImpl implements EgovMoNumberService{
	
	@Resource(name = "MoNumberDAO")
    private MoNumberDAO moNumberDAO;
    
    @Resource(name = "egovAdbkIdGnrService")
    private EgovIdGnrService idgenService;
    
    @Resource(name = "egovAdbkUserIdGnrService")
    private EgovIdGnrService idgenService2;

	@Override
	public List<MoNumber> moNumberList(MoNumber moNumber) throws Exception {
		List<MoNumber> result = moNumberDAO.moNumberList(moNumber);
        return result;
	}

	@Override
	public String moNumberInsert(MoNumber moNumber) throws Exception {
		String result = moNumberDAO.moNumberInsert(moNumber);
		return result;
	}

	@Override
	public String moNumberUpdate(MoNumber moNumber) throws Exception {
		String result = moNumberDAO.moNumberUpdate(moNumber);
		return result;
	}

	@Override
	public MoNumber searchMoNum(MoNumber moNumber) throws Exception {
		MoNumber result = moNumberDAO.searchMoNum(moNumber);
		return result;
	}

	 

}
