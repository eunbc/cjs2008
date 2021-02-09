package com.spring.cjs2008.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2008.vo.BoardReplyVo;
import com.spring.cjs2008.vo.BoardVo;

public interface BoardDao {

	public void setBoardInput(@Param("vo") BoardVo vo);

	public List<BoardVo> bList(@Param("startNo") int startNo, @Param("pageSize") int pageSize);

	public BoardVo getbContent(@Param("idx") int idx);

	public int bListTotRecCnt();

	public BoardVo passwordCheck(@Param("idx") int idx, @Param("pwd") String pwd);

	public void setBoardUpdate(@Param("vo") BoardVo vo);

	public void setBoardDelete(@Param("idx") int idx);

	public String maxLevelOrder(@Param("boardIdx") int boardIdx);

	public void setReplyInsert(@Param("cVo") BoardReplyVo cVo);

	public List<BoardReplyVo> getBoardReply(@Param("boardIdx") int boardidx);

	public void bReplyDeleteGet(@Param("idx") int idx);

	public void levelOrderPlusUpdate(@Param("cVo") BoardReplyVo cVo);   //객체는 반드시 param 써줘야함. 값이 한개일때는 생략가능

	public void bContReplyInsert(@Param("cVo") BoardReplyVo cVo);

	public void addReadnum(@Param("idx") int idx);


}
