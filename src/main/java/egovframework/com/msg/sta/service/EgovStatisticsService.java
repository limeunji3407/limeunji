package egovframework.com.msg.sta.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import egovframework.com.msg.sta.service.impl.StatisticsDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("EgovStatisticsService")
public class EgovStatisticsService extends EgovAbstractServiceImpl{
	
	@Resource(name = "StatisticsDAO") 
	private StatisticsDAO statisticsDAO;
	
	public List<StatisticsVO> dataList(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.dataList(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> monthDataList(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.monthDataList(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<TableEntity> tabelList(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<TableEntity> list = statisticsDAO.tabelList(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> yearDataList(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.yearDataList(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> partDailystatistics(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.partDailystatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> partMonthstatistics(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.partMonthstatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> partYearStatistics(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.partYearStatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> partStatisticsbyjobSearch(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.partStatisticsbyjobSearch(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngDailystatistics(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngDailystatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	public List<StatisticsVO> mngMonthStatistics(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngMonthStatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	public List<StatisticsVO> mngYearStatistics(SearchEntity vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngYearStatistics(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbyjob(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbyjob(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeSms(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbytypeSms(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeAls(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbytypeAls(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbytypeFls(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbytypeFls(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbyaltSearch(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbyaltSearch(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
	
	public List<StatisticsVO> mngStatisticsbypart(Object vo){
		System.out.println("dataList invoked;;");
		
		List<StatisticsVO> list = statisticsDAO.mngStatisticsbypart(vo);
		
		System.out.println("list :: "+ new Gson().toJson(list));
		
		return list;
	}
}
