package egovframework.com.msg.rcv.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


/**
 * @version : java1.8 
 * @author : ohs
 * @date : 2018. 1. 17.
 * @msg : 파일 업로드 하는 함수들 바이너리형식으로 요청, multipart-form-data 형식  두가지 지원가능
*/
@Controller
@RequestMapping("/api/file/*")
public class FileUploadController { 
	String setCharEncoding = "UTF-8"; 
	
	 
	/**
	 * @msg : 업로드 관련 path 모음
	 */
	public static String UPLOAD_PATH = "/images/egovframework/"; 
	
	
	@Value("#{globalsProperties['PUSERIMAGEPATH']}")
	String PUSERIMAGEPATH;

	@Value("#{globalsProperties['PUSERIMAGEPATH.web.url']}")
	String PUSERIMAGEPATH__;
	
	public String fileupload(MultipartFile file1, HttpServletRequest request) { 
		try{
			if(!file1.isEmpty()){ //첨부파일이 존재하면
				
				String fileName=""; 
				String strToday = FileUploadController.simpleDate("yyyyMMddkms");
				String path = request.getServletContext().getRealPath(FileUploadController.UPLOAD_PATH);
				
				//첨부파일의 이름 
				fileName=file1.getOriginalFilename();
				String ext = fileName.substring(fileName.lastIndexOf(".") + 1);//확장자 구하기
				//파일명이 한글명일경우 UUID객체 이용하여 유니크값으로 파일명을 대체한다.
				if(FileUploadController.checkLang(fileName)){
					fileName = UUID.randomUUID().toString().replace("-", "")+"."+ext;
				}
				fileName = strToday+"_"+fileName;
				file1.transferTo(new File(path+fileName));
				return PUSERIMAGEPATH+FileUploadController.UPLOAD_PATH+fileName;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * @param realPath : 해당 경로에 디렉토리가 있다면 넘어가고 없다면 디렉토리를 생성한다.
	 */
	public static void mkDir(String realPath){
		File updir = new File(realPath);
		if (!updir.exists()) updir.mkdirs();
	}
	
	/**
	 * 
	 * @message : 포맷패턴을 넘겨주면 그에 맞게 날짜형식을 리턴한다.
	 * @param fommat : 포맷패턴
	 * @return : 포맷에 따른 날짜를 String형식으로 리턴
	 */
	public static String simpleDate(String fommat){
		SimpleDateFormat sdf = new SimpleDateFormat(fommat);
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		return strToday;
	}
	
	/**
	 * @msg : 해당 문자열에 한글이 포함됬는지 확인 함수
	 * @param str : 검사할 문자열
	 * @return : true 한글존재, false 한글 없음
	 */
	public static boolean checkLang(String str){
		if(str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * @msg : 파일업로드 하는 객체이며 binary 형식으로 넘어왔을 때만 사용하는 객체이다, 스마트에디터 html 지원 브라우저에서 사용하는 방식
	 */
	@RequestMapping(value = "/upload_binary.do")
	private @ResponseBody String file_uploader(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		request.setCharacterEncoding("utf-8");
		//보낼떄 header에 담아서 보내서 getHeader로 가져옴
		String realname = request.getHeader("file-name");
		
		//확장자 얻어오는
		String path = request.getServletContext().getRealPath(UPLOAD_PATH);
		mkDir(path);
		  
		
		InputStream is = request.getInputStream();
		OutputStream os = new FileOutputStream(path + realname);
		int numRead;
		byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
		while ((numRead = is.read(b, 0, b.length)) != -1) {
			os.write(b, 0, numRead);
		}
		if (is != null) {
			is.close();
		}
		os.flush();
		os.close();
		
		//밑의 리턴 방식은내가 커스텀한 것 사용시 리턴 방식
		String sFileInfo = "<img src=\"/resources/upload/"+realname+"\" style=\"width:100px;height:100px;\" ><br> "; 
		return sFileInfo;
	}
	
	
	/**
	 * @msg : 파일업로드 하는 객체이며 multipart 형식으로 넘어왔을 때만 사용하는 객체이다
	 */
	@RequestMapping(value = "/upload_multipart")
	private @ResponseBody String file_uploader2(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		response.setCharacterEncoding(setCharEncoding);
		response.setContentType("text/html; charset="+setCharEncoding+" \" ");
		
		String realPath = request.getServletContext().getRealPath(UPLOAD_PATH);
		String filename = multipart_upload(request, realPath);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("opener.pasteHTML('"+filename+"');");
		out.println("self.close();");
		out.println("</script>");
		out.flush();
		return null;
	}
	
	/**
	 * @msg : 파일업로드 하는 객체이며 multipart 형식으로 넘어왔을 때만 사용하는 객체이며 thumb를 만든다. 또한 위의 객체와 리턴방식이 다름
	 */
	@PostMapping(value = "/ajaxupload") // thumb 도 만들기
	private @ResponseBody String ajaxupload(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
//		response.setCharacterEncoding(setCharEncoding);
		response.setContentType("text/html; charset="+setCharEncoding+" \" ");
		
		String realPath = request.getServletContext().getRealPath(UPLOAD_PATH);
		String filename = multipart_upload(request, realPath);
		
		return PUSERIMAGEPATH__ + filename;
	}
	@PostMapping(value = "/ajaxupload2") // thumb 도 만들기
	private @ResponseBody String ajaxupload2(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception {
		response.setContentType("text/html; charset="+setCharEncoding+" \" ");
		
		String realPath = request.getServletContext().getRealPath(UPLOAD_PATH);
		String filename = multipart_upload2(request, realPath, request.getParameter("is_real"));
		
		return PUSERIMAGEPATH__ + filename;
	}
	
	/**
	 * @message : 실질적인 업로드하는 객체
	 * @param request : 업로드할 객체를 가지고 있는 요청데이터
	 * @param realPath : 실질적으로 사진을 업로드할 경고
	 * @return : 이미지 업로드 후 업로드한 파일명
	 */
	public String multipart_upload(HttpServletRequest request, String realPath) throws IllegalStateException, IOException{
		mkDir(realPath);
		String filename = "";
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile mrequest = null;
//		String strToday = simpleDate("yyyyMMddkms");
		
		while(iterator.hasNext()){
			mrequest = multipartHttpServletRequest.getFile(iterator.next());
			
			String filenameTemp = mrequest.getOriginalFilename();
			String ext = filenameTemp.substring(filenameTemp.lastIndexOf(".") + 1); //확장자 구하기
			filename += UUID.randomUUID().toString().replace("-", "")+"."+ext;
			if(mrequest.isEmpty() == false) mrequest.transferTo(new File(PUSERIMAGEPATH + filename));
			
		}
		
		
		return filename.replaceAll("\"", "");
	}
	public String multipart_upload2(HttpServletRequest request, String realPath, String real_name) throws IllegalStateException, IOException{
		mkDir(realPath);
		String filename = "";
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile mrequest = null;
//		String strToday = simpleDate("yyyyMMddkms");
		
		while(iterator.hasNext()){
			mrequest = multipartHttpServletRequest.getFile(iterator.next());
			
			String filenameTemp = mrequest.getOriginalFilename();
			String ext = filenameTemp.substring(filenameTemp.lastIndexOf(".") + 1); //확장자 구하기
			filename += UUID.randomUUID().toString().replace("-", "")+"."+ext;
			
			if(real_name != null && real_name.equals("Y")) {
				filename = filenameTemp;
			}
			
			if(mrequest.isEmpty() == false) mrequest.transferTo(new File(PUSERIMAGEPATH + filename));
			
		}
		
		
		return filename.replaceAll("\"", "");
	}
	
}
