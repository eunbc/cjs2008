package com.spring.cjs2008.vo;

public class PageVo {
	private int pageSize;
	private int pag;
	private int totRecCnt;
	private int totPage;
	private int startNo;
	private int curScrNo;
	private int blockSize;
	
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPag() {
		return pag;
	}
	public void setPag(int pag) {
		this.pag = pag;
	}
	public int getTotRecCnt() {
		return totRecCnt;
	}
	public void setTotRecCnt(int totRecCnt) {
		this.totRecCnt = totRecCnt;
	}
	public int getTotPage() {
		return totPage;
	}
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getCurScrNo() {
		return curScrNo;
	}
	public void setCurScrNo(int curScrNo) {
		this.curScrNo = curScrNo;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	@Override
	public String toString() {
		return "PageVo [pageSize=" + pageSize + ", pag=" + pag + ", totRecCnt=" + totRecCnt + ", totPage=" + totPage
				+ ", startNo=" + startNo + ", curScrNo=" + curScrNo + ", blockSize=" + blockSize + "]";
	}
	
}
