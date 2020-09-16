package egovframework.com.xls.service.impl;

import egovframework.com.usr.add.service.AddressBook;
import egovframework.rte.fdl.excel.EgovExcelMapping;
import egovframework.rte.fdl.excel.util.EgovExcelUtil;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Row;

/**
 *
 * Excel 매핑 클래스
 * @author 
 */
public class EgovExcelAddrBookMapping extends EgovExcelMapping {

	/**
	 * 주소록 엑셀파일 맵핑
	 */
	@Override
	public Object mappingColumn(Row row) {
		HSSFCell cell0 = (HSSFCell) row.getCell(0);
    	HSSFCell cell1 = (HSSFCell) row.getCell(1);
    	HSSFCell cell2 = (HSSFCell) row.getCell(2);
    	HSSFCell cell3 = (HSSFCell) row.getCell(3);
    	HSSFCell cell4 = (HSSFCell) row.getCell(4);
    	HSSFCell cell5 = (HSSFCell) row.getCell(5);
    	HSSFCell cell6 = (HSSFCell) row.getCell(6);
    	HSSFCell cell7 = (HSSFCell) row.getCell(7);

		AddressBook vo = new AddressBook();

		vo.setUser_id            (EgovExcelUtil.getValue(cell0));
		vo.setPart_id             (EgovExcelUtil.getValue(cell1));
		vo.setAddress_name             (EgovExcelUtil.getValue(cell2));
		vo.setCategory_type       (EgovExcelUtil.getValue(cell1));
		vo.setAddress_type       (EgovExcelUtil.getValue(cell3));
		vo.setAddress_capy          (EgovExcelUtil.getValue(cell4));
		vo.setAddress_date (EgovExcelUtil.getValue(cell7));
		vo.setAddress_group   (EgovExcelUtil.getValue(cell5));
		vo.setAddress_id (EgovExcelUtil.getValue(cell6)); 
		return vo;
	}

	public void insertExcel(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub 
	}
	
/*	public List<Map> selectRow() {

		List<Map> res = new List<Map>();
		AddressBook vo = new AddressBook();
		return res ;
		
	}*/

/*	public void insertExcel(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		
	}*/
}
