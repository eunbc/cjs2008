package com.spring.cjs2008.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2008.dao.BoardDao;
import com.spring.cjs2008.dao.GuestDao;

@Service
public class PageProcess {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	GuestDao guestDao;
	public PageVo pagination(int pag, int pageSize, String partFlag) {
		int totRecCnt = 0;
		int blockSize = 3;
		PageVo pageVo = new PageVo();
		
		if(partFlag.equals("board")) {
			totRecCnt = boardDao.bListTotRecCnt(); 
		} 
		else if(partFlag.equals("guest")) {
			totRecCnt = guestDao.totRecCnt();
		}
		
		int totPage = (totRecCnt % pageSize)==0? totRecCnt/pageSize : (int) (totRecCnt/pageSize) +1;
		int startNo = (pag -1) * pageSize;
		int curScrNo = totRecCnt - startNo;
		
		pageVo.setPag(pag);
		pageVo.setPageSize(pageSize);
		pageVo.setBlockSize(curScrNo);
		pageVo.setTotRecCnt(totRecCnt);
		pageVo.setTotPage(totPage);
		pageVo.setStartNo(startNo);
		pageVo.setCurScrNo(curScrNo);
		
		return pageVo;
	}
}
