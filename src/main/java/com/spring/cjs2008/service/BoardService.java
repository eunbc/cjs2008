package com.spring.cjs2008.service;

import java.util.List;

import com.spring.cjs2008.vo.BoardReplyVo;
import com.spring.cjs2008.vo.BoardVo;
import com.spring.cjs2008.vo.PageVo;

public interface BoardService {

	public void setBoardInput(BoardVo vo);

	public List<BoardVo> bList(int startNo, int pageSize);

	public BoardVo getbContent(int idx);

	public void imgCheck(String content, String uploadPath, int position_number);

	public PageVo pagination(int pag, int pageSize);

	public BoardVo passwordCheck(int idx, String pwd);

	public void imgBackup(String content, String uploadPath);

	public void imgDelete(String oriContent, String uploadPath);

	public void setBoardUpdate(BoardVo vo);

	public void setBoardDelete(int idx);

	public String maxLevelOrder(int boardIdx);

	public void setReplyInsert(BoardReplyVo cVo);

	public List<BoardReplyVo> getBoardReply(int boardIdx);

	public void bReplyDeleteGet(int idx);

	public void levelOrderPlusUpdate(BoardReplyVo cVo);

	public void bContReplyInsert(BoardReplyVo cVo);

	public void addReadnum(int idx);


}
