package egovframework.com.msg.sta.util;

import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

/**
 * @version : java1.8
 * @author : ohs
 * @date : 2018. 8. 8.
 * @class :
 * @message : API 서버 공통 소스
 * @constructors :
 * @method :
 */
public class StatisticsCommon {
	static Gson gson = new GsonBuilder().setPrettyPrinting().serializeNulls().create();
	public static String GmakeDynamicValueObject(ResponseEntity<String> entity){
		String ss = "";
		ss += gson.toJson(entity);
		return ss;
	}
	
	public static void returnPrint(String str){
		
		JsonParser jp = new JsonParser();
		JsonElement je = jp.parse(str);
		str = gson.toJson(je);
		
		System.out.println("--------------------      Response Param     ---------------------------");
		System.out.println(str);
		System.out.println("------------------------------------------------------------------------");
	}
}
