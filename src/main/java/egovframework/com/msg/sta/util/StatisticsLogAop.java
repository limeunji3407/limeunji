package egovframework.com.msg.sta.util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Aspect
public class StatisticsLogAop {
	
	private static final Logger logger = LoggerFactory.getLogger(StatisticsLogAop.class);
	

	//해당되는 컨트롤러로 요청이 들어왔을때는 AOP를 무시한다.
	// controller 패키지 안에 있는 파일들은 전부 AOP를 거친다 하지만 뒤에 정의 되어 있는 AjaxController, LoginController은 무시한다.
	// 여기에 작성하지 않으면 전부 무시되지만 밑의 처럼 controller 패키지 자체를 거치게 했는데 그중 무시하고자 하는 파일이 있을경우 아래처럼한다.
	@Around("execution(* com.kb.api.controller..*.*(..)) || execution(* com.kb.admin.controller..*.*(..)) ")
	public Object setMapParamter(ProceedingJoinPoint joinPoint) throws Throwable { //
		// request, response 객체 얻어오기
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
		/**
		 * 다음 프로젝트에서는 토큰 체크를 aop 에서 하자 대신 login등과 같은 경로는 필터를 거치지 않도록 만들어야 한다.
		 */
		/*
			Common common = new Common();
			DynamicValueObject error = new DynamicValueObject();
			DynamicValueObject rst_dy = new DynamicValueObject();
			DynamicValueObject data = new DynamicValueObject();
			int err_code = 0;
			err_code = common.checkToken(request);
			if(err_code > 0) return Common.common_error_return(error, rst_dy, data, err_code);
		 */
		
		
		// request에 담겨온 url, 파라미터 콘솔에출력
		logger.warn("################################################################################################");
		logger.warn("protocol    :  " + request.getProtocol());
		logger.warn("URL         :  " + request.getRequestURL());
		logger.warn("method      :  " + request.getMethod());
		logger.warn("referer     :  " + request.getHeader("referer"));
		Enumeration params = request.getParameterNames();
		int index = 1;
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			logger.warn("param [" + (index++) + "]   :  " + name + " - " + request.getParameter(name));
		}
		logger.warn("################################################################################################");
		return joinPoint.proceed();
	}
}
