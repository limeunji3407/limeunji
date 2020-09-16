package egovframework.com.msg.sta.service;

public class StatisticsVO {
	
	String msgPayCode;
	String workSeq;
	String workNm;
	String currentDay;
	String seq;
	String tmpcode;
	String tmpname;
	String tmpsub;
	String tmpwork;
	String tmpcontent;
	String partId;
	String total; //총 발송건수
	String totals; // 총발송 성공건수
	String totalf; // 총발송 실패건수
	String sms; //SMS 발송건수
	String smss; //SMS 발송성공건수
	String smsf; //SMS 발송실패건수
	String lms; // LMS(장문) 발송건수
	String lmss; // LMS(장문) 발송성공
	String lmsf; // LMS(장문) 발송실패
	String mms;  // MMS(멀티) 발송건수
	String mmss; // MMS(멀티) 발송성공
	String mmsf; // MMS(멀티) 발송실패
	String not; // NOT(알림톡) 발송건수
	String nots; // NOT(알림톡) 발송성공건수
	String notf;// NOT(알림톡) 발송실패건수
	String notr;// NOT(알림톡 대체) 발송건수
	String notrs;// NOT(알림톡 대체) 발송성공건수
	String notrf;// NOT(알림톡 대체) 발송실패건수
	String frt;// 친구톡 텍스트  발송건수
	String frts;// 친구톡 텍스트  발송성공건수
	String frtf;// 친구톡 텍스트  발송실패건수
	String frtr;// 친구톡 텍스트 대체  발송건수
	String frtrs;// 친구톡 텍스트 대체  발송성공건수
	String frtrf;// 친구톡 텍스트 대체  발송실패건수
	String fri;// 친구톡 이미지  발송건수
	String fris;// 친구톡 이미지  발송성공건수
	String frif;// 친구톡 이미지  발송실패건수
	String frir;// 친구톡 이미지 대체  발송건수
	String frirs;// 친구톡 이미지 대체  발송성공건수
	String frirf;// 친구톡 이미지 대체  발송실패건수
	String fit;// 친구톡 이미지+텍스트   발송건수
	String fits;// 친구톡 이미지+텍스트   발송성공건수
	String fitf;// 친구톡 이미지+텍스트   발송실패건수
	String fitr;// 친구톡 이미지+텍스트 대체  발송건수
	String fitrs;// 친구톡 이미지+텍스트 대체  발송성공건수
	String fitrf;// 친구톡 이미지+텍스트 대체  발송실패건수
	
	
	public String getWorkNm() {
		return workNm;
	}
	public void setWorkNm(String workNm) {
		this.workNm = workNm;
	}
	public String getMsgPayCode() {
		return msgPayCode;
	}
	public void setMsgPayCode(String msgPayCode) {
		this.msgPayCode = msgPayCode;
	}
	public String getWorkSeq() {
		return workSeq;
	}
	public void setWorkSeq(String workSeq) {
		this.workSeq = workSeq;
	}
	public String getCurrentDay() {
		return currentDay;
	}
	public void setCurrentDay(String current_day) {
		this.currentDay = current_day;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTmpcode() {
		return tmpcode;
	}
	public void setTmpcode(String tmpcode) {
		this.tmpcode = tmpcode;
	}
	public String getTmpname() {
		return tmpname;
	}
	public void setTmpname(String tmpname) {
		this.tmpname = tmpname;
	}
	public String getTmpsub() {
		return tmpsub;
	}
	public void setTmpsub(String tmpsub) {
		this.tmpsub = tmpsub;
	}
	public String getTmpwork() {
		return tmpwork;
	}
	public void setTmpwork(String tmpwork) {
		this.tmpwork = tmpwork;
	}
	public String getTmpcontent() {
		return tmpcontent;
	}
	public void setTmpcontent(String tmpcontent) {
		this.tmpcontent = tmpcontent;
	}
	public String getPartId() {
		return partId;
	}
	public void setPartId(String partId) {
		this.partId = partId;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getTotals() {
		return totals;
	}
	public void setTotals(String totals) {
		this.totals = totals;
	}
	public String getTotalf() {
		return totalf;
	}
	public void setTotalf(String totalf) {
		this.totalf = totalf;
	}
	public String getSms() {
		return sms;
	}
	public void setSms(String sms) {
		this.sms = sms;
	}
	public String getSmss() {
		return smss;
	}
	public void setSmss(String smss) {
		this.smss = smss;
	}
	public String getSmsf() {
		return smsf;
	}
	public void setSmsf(String smsf) {
		this.smsf = smsf;
	}
	public String getLms() {
		return lms;
	}
	public void setLms(String lms) {
		this.lms = lms;
	}
	public String getLmss() {
		return lmss;
	}
	public void setLmss(String lmss) {
		this.lmss = lmss;
	}
	public String getLmsf() {
		return lmsf;
	}
	public void setLmsf(String lmsf) {
		this.lmsf = lmsf;
	}
	public String getMms() {
		return mms;
	}
	public void setMms(String mms) {
		this.mms = mms;
	}
	public String getMmss() {
		return mmss;
	}
	public void setMmss(String mmss) {
		this.mmss = mmss;
	}
	public String getMmsf() {
		return mmsf;
	}
	public void setMmsf(String mmsf) {
		this.mmsf = mmsf;
	}
	public String getNot() {
		return not;
	}
	public void setNot(String not) {
		this.not = not;
	}
	public String getNots() {
		return nots;
	}
	public void setNots(String nots) {
		this.nots = nots;
	}
	public String getNotf() {
		return notf;
	}
	public void setNotf(String notf) {
		this.notf = notf;
	}
	public String getNotr() {
		return notr;
	}
	public void setNotr(String notr) {
		this.notr = notr;
	}
	public String getNotrs() {
		return notrs;
	}
	public void setNotrs(String notrs) {
		this.notrs = notrs;
	}
	public String getNotrf() {
		return notrf;
	}
	public void setNotrf(String notrf) {
		this.notrf = notrf;
	}
	public String getFrt() {
		return frt;
	}
	public void setFrt(String frt) {
		this.frt = frt;
	}
	public String getFrts() {
		return frts;
	}
	public void setFrts(String frts) {
		this.frts = frts;
	}
	public String getFrtf() {
		return frtf;
	}
	public void setFrtf(String frtf) {
		this.frtf = frtf;
	}
	public String getFrtr() {
		return frtr;
	}
	public void setFrtr(String frtr) {
		this.frtr = frtr;
	}
	public String getFrtrs() {
		return frtrs;
	}
	public void setFrtrs(String frtrs) {
		this.frtrs = frtrs;
	}
	public String getFrtrf() {
		return frtrf;
	}
	public void setFrtrf(String frtrf) {
		this.frtrf = frtrf;
	}
	public String getFri() {
		return fri;
	}
	public void setFri(String fri) {
		this.fri = fri;
	}
	public String getFris() {
		return fris;
	}
	public void setFris(String fris) {
		this.fris = fris;
	}
	public String getFrif() {
		return frif;
	}
	public void setFrif(String frif) {
		this.frif = frif;
	}
	public String getFrir() {
		return frir;
	}
	public void setFrir(String frir) {
		this.frir = frir;
	}
	public String getFrirs() {
		return frirs;
	}
	public void setFrirs(String frirs) {
		this.frirs = frirs;
	}
	public String getFrirf() {
		return frirf;
	}
	public void setFrirf(String frirf) {
		this.frirf = frirf;
	}
	public String getFit() {
		return fit;
	}
	public void setFit(String fit) {
		this.fit = fit;
	}
	public String getFits() {
		return fits;
	}
	public void setFits(String fits) {
		this.fits = fits;
	}
	public String getFitf() {
		return fitf;
	}
	public void setFitf(String fitf) {
		this.fitf = fitf;
	}
	public String getFitr() {
		return fitr;
	}
	public void setFitr(String fitr) {
		this.fitr = fitr;
	}
	public String getFitrs() {
		return fitrs;
	}
	public void setFitrs(String fitrs) {
		this.fitrs = fitrs;
	}
	public String getFitrf() {
		return fitrf;
	}
	public void setFitrf(String fitrf) {
		this.fitrf = fitrf;
	}
	
	
	
}
