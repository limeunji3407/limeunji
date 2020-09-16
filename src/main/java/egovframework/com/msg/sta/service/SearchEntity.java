package egovframework.com.msg.sta.service;

import java.util.List;

public class SearchEntity {
	
	String user_id;
	String orgnztId;
	String start_dt;
	String end_dt;
	List<DateEntity> date_list;
	List<TableEntity > table_list;
	int date_list_size;
	String part_id;
	
	String work_seq;
	
	
	
	public String getPart_id() {
		return part_id;
	}
	public void setPart_id(String part_id) {
		this.part_id = part_id;
	}
	public String getWork_seq() {
		return work_seq;
	}
	public void setWork_seq(String work_seq) {
		this.work_seq = work_seq;
	}
	public List<TableEntity> getTable_list() {
		return table_list;
	}
	public void setTable_list(List<TableEntity> table_list) {
		this.table_list = table_list;
	}
	public int getDate_list_size() {
		return date_list_size;
	}
	public void setDate_list_size(int date_list_size) {
		this.date_list_size = date_list_size;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public List<DateEntity> getDate_list() {
		return date_list;
	}
	public void setDate_list(List<DateEntity> date_list) {
		this.date_list = date_list;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOrgnztId() {
		return orgnztId;
	}
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}
	
}
