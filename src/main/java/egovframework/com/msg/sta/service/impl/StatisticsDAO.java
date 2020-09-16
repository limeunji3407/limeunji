package egovframework.com.msg.sta.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.msg.sta.service.SearchEntity;
import egovframework.com.msg.sta.service.StatisticsVO;
import egovframework.com.msg.sta.service.TableEntity;


@Repository("StatisticsDAO")
public class StatisticsDAO extends EgovComAbstractDAO{
		
	public List<StatisticsVO> dataList(Object vo){
		System.out.println("DAO dataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.statisticsDateList", vo);
		
		return list;
	}
	
	public List<StatisticsVO> monthDataList(SearchEntity vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.monthDataList", vo);
		
		return list;
	}
	
	public List<TableEntity> tabelList(SearchEntity vo){
		System.out.println("DAO tabelList invoked;;");
		System.out.println(vo.toString());
		
		List<TableEntity> list = selectList("StatisticsDAO.tabelList", vo);
		
		return list;
	}
	
	public List<StatisticsVO> yearDataList(SearchEntity vo){
		System.out.println("DAO yearDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.yearDataList", vo);
		
		return list;
	}
	
	public List<StatisticsVO> partDailystatistics(Object vo){
		System.out.println("DAO dataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.partDailystatistics", vo);
		
		return list;
	}
	
	public List<StatisticsVO> partMonthstatistics(SearchEntity vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.partMonthstatistics", vo);
		
		return list;
	}
	
	public List<StatisticsVO> partYearStatistics(SearchEntity vo){
		System.out.println("DAO yearDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.partYearStatistics", vo);
		
		return list;
	}
	
	public List<StatisticsVO> partStatisticsbyjobSearch(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.partStatisticsbyjobSearch", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngDailystatistics(Object vo){
		System.out.println("DAO dataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngDailystatistics", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngMonthStatistics(SearchEntity vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngMonthStatistics", vo);
		
		return list;
	}
	public List<StatisticsVO> mngYearStatistics(SearchEntity vo){
		System.out.println("DAO yearDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngYearStatistics", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbyjob(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbyjob", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeSms(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbytypeSms", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeAls(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbytypeAls", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeFls(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbytypeFls", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbyaltSearch(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbyaltSearch", vo);
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbypart(Object vo){
		System.out.println("DAO monthDataList invoked;;");
		System.out.println(vo.toString());
		
		List<StatisticsVO> list = selectList("StatisticsDAO.mngStatisticsbypart", vo);
		
		return list;
	}
}
