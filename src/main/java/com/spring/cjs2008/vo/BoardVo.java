package com.spring.cjs2008.vo;

public class BoardVo {
	private int idx;
	private String mid;
	private String name;
	private String title;
	private String email;
	private String homepage;
	private String pwd;
	private String wdate;
	private int readnum;
	private String hostip;
	private String content;
	private String oriContent; //변경되기 전의 원본 content를 저장
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getReadnum() {
		return readnum;
	}
	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}
	public String getHostip() {
		return hostip;
	}
	public void setHostip(String hostip) {
		this.hostip = hostip;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOriContent() {
		return oriContent;
	}
	public void setOriContent(String oriContent) {
		this.oriContent = oriContent;
	}
	
	@Override
	public String toString() {
		return "BoardVo [idx=" + idx + ", mid=" + mid + ", name=" + name + ", title=" + title + ", email=" + email
				+ ", homepage=" + homepage + ", pwd=" + pwd + ", wdate=" + wdate + ", readnum=" + readnum + ", hostip="
				+ hostip + ", content=" + content + ", oriContent=" + oriContent + "]";
	}
		
}
