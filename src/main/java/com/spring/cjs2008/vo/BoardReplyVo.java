package com.spring.cjs2008.vo;

import lombok.Data;

//@Getter
//@Setter
//@ToString
@Data
public class BoardReplyVo {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickname;
	private String wdate;
	private String hostip;
	private String content;
	private int level;
	private int levelOrder;
}
