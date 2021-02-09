package com.spring.cjs2008;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.cjs2008.pagination.PageProcess;
import com.spring.cjs2008.service.BoardService;
import com.spring.cjs2008.vo.BoardReplyVo;
import com.spring.cjs2008.vo.BoardVo;

import lombok.Data;

@Controller
@RequestMapping("/board")
public class BoardController {
	String msgFlag = "";
	
	@Autowired
	BoardService boardService;
	
	@Autowired 
	PageProcess pageProcess;
	
	/*
	 * @RequestMapping(value="/bList", method=RequestMethod.GET) public String
	 * bListGet(Model model,HttpServletRequest request) { int pag =
	 * request.getParameter("pag")==null? 1 :
	 * Integer.parseInt(request.getParameter("pag")); int pageSize =
	 * request.getParameter("pageSize")==null? 5 :
	 * Integer.parseInt(request.getParameter("pageSize"));
	 * 
	 * PageVo p = boardService.pagination(pag,pageSize); List<BoardVo> vos =
	 * boardService.bList(p.getStartNo(),p.getPageSize()); int curScrNo =
	 * p.getCurScrNo();
	 * 
	 * model.addAttribute("p",p); model.addAttribute("vos",vos);
	 * model.addAttribute("curScrNo",curScrNo);
	 * 
	 * return "board/bList"; }
	 */
	
	@RequestMapping(value="/bList", method=RequestMethod.GET)
	public String bListGet(Model model,HttpServletRequest request) {
		int pag = request.getParameter("pag")==null? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		com.spring.cjs2008.pagination.PageVo pageVo = pageProcess.pagination(pag,pageSize,"board");
		List<BoardVo> vos = boardService.bList(pageVo.getStartNo(),pageVo.getPageSize());
		int curScrNo = pageVo.getCurScrNo();
		
		model.addAttribute("p",pageVo);
		model.addAttribute("vos",vos);
		model.addAttribute("curScrNo",curScrNo);
		
		return "board/bList";
	}
	
	@RequestMapping(value="/bInput", method=RequestMethod.GET)
	public String bInputGet() {
	  	return "board/bInput";
	}
	

	@RequestMapping(value="/bInput", method=RequestMethod.POST)
		//	public String bInputPost(BoardVo vo, HttpServletRequest request) {
		//@SuppressWarnings("deprecation")
		//String uploadPath = request.getRealPath("/");
	public String bInputPost(BoardVo vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); 
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/ckeditor/images/"); //ckeditor를 통해 서버에 저장되는 그림파일의 경로
		
		//실제 업로드하는 경로
		vo.setContent(vo.getContent().replace("/resources/ckeditor/images/", "/resources/ckeditor/images/src/"));
		
		//이미지를 발췌해서 'src'폴더로 복사처리
		boardService.imgCheck(vo.getContent(), uploadPath, 44);
		
		//경로 변경한 vo를 데이터베이스에 저장
		boardService.setBoardInput(vo);
		msgFlag = "bInputOk";
		return "redirect:/msg/"+msgFlag;
	}

	@RequestMapping(value="/bContent", method=RequestMethod.GET)
	public String bContentGet(Model model, HttpServletRequest request) {
		//request 로 받거나, 매개 변수로 받거나.
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		//조회수증가
		boardService.addReadnum(idx);
		BoardVo vo = boardService.getbContent(idx);
		List<BoardReplyVo> cVos = boardService.getBoardReply(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("cVos",cVos);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		
		return "board/bContent";
	}
	
	@RequestMapping(value="/bUpdate", method=RequestMethod.GET)
	public String bUpdateGet(HttpServletRequest request,Model model) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pag = Integer.parseInt(request.getParameter("pag"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		String pwd = request.getParameter("pwd");
		
		BoardVo vo = boardService.passwordCheck(idx,pwd);
		System.out.println("vo" + vo);
		
		if(vo == null) { //비밀번호가 틀렸으면 메세지 출력후 bContent.jsp 로 돌려보냄
			msgFlag = "boardUpdNo$idx="+idx+"&pag="+pag+"&pageSize="+pageSize; //변수를 ?를 제외한 다른 특수기호를 붙여서 전달한다.
			return "redirect:/msg/"+msgFlag;
		}
		
		//내용물중에 그림파일이 있다면 db수정 작업 전에 기존 src폴더에 들어있는 파일을 images폴더로 복사시킨다.
		String uploadPath = request.getRealPath("/resources/ckeditor/images/");
		boardService.imgBackup(vo.getContent(),uploadPath);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		
	  	return "board/bUpdate";
	}
	
	@RequestMapping(value="/bUpdate", method=RequestMethod.POST)
	public String bUpdatePost(BoardVo vo,HttpServletRequest request) {
		//받아올때 부터 배열 값으로 받아옴
		//기존의 내용을 변경시켰고, content안에 'src'태그속성이 있다면 그림파일이 변경처리되어 있다고 가정하여, images방의 그림파일을 src폴더로 복사처리함
		if(!vo.getOriContent().equals(vo.getContent()) && vo.getContent().indexOf("src=\"/") != -1) { //내용 수정, 그림이 있을 때 (그림 안바꾸어도 글자 하나만 바뀌면 새로 업로드함)
			//앞에서(수정처리를 위해 bUpdateGet메소드 수행후) 이미지의 위치가 src폴더에서 images로 복사된다.
			//따라서 db에 저장된 실제 그림의 경로도 변경시켜줘야 한다.
			vo.setContent(vo.getContent().replace("/resources/ckeditor/images/src/", "/resources/ckeditor/images/"));
			
			//현재 서버에 저장(위치: '/src/')되어 있는 이미지를 삭제처리한다.
			String uploadPath = request.getRealPath("/resources/ckeditor/images/src/");
			boardService.imgDelete(vo.getOriContent(),uploadPath); //이미지 삭제처리
			
			//새롭게 업로드를 위한 이미지를 'src'폴더에 재등록한다.
			uploadPath = request.getRealPath("/resources/ckeditor/images/");
			boardService.imgCheck(vo.getContent(), uploadPath, 40); //content필드안의 그림파일들을 모두 src폴더로 복사
			vo.setContent(vo.getContent().replace("/resources/ckeditor/images/","/resources/ckeditor/images/src/"));
		}
		
		//잘 정비된 vo자료를 db에 update 시켜준다.
		boardService.setBoardUpdate(vo);
		
		int pag = Integer.parseInt(request.getParameter("pag"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		msgFlag = "bUpdateOk$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/"+msgFlag;
	}
	
	@RequestMapping(value="/bDelete", method=RequestMethod.GET) 
	public String bDeleteGet(HttpServletRequest request,int idx, String pwd, int pag, int pageSize) {
		BoardVo vo = boardService.passwordCheck(idx, pwd);
		
		if(vo == null) {
			msgFlag = "boardDelNo$idx="+idx+"&pag="+pag+"&pageSize="+pageSize; //변수를 ?를 제외한 다른 특수기호를 붙여서 전달한다.
			return "redirect:/msg/"+msgFlag;
		}
		
		//실제 서버에 저장된 그림파일을 삭제처리
		String uploadPath = request.getRealPath("/resources/ckeditor/images/src/");
		boardService.imgDelete(vo.getContent(),uploadPath);
		
		//DB에서 실제 게시글을 삭제처리한다
		boardService.setBoardDelete(idx);
		msgFlag = "bDeleteOk$pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/"+msgFlag;
	}
	
	//댓글(답변글) 달기(댓글의 level은 0)
	@ResponseBody
	@RequestMapping(value="/bReplyInsert", method=RequestMethod.GET)
	public int bReplyInsertGet(BoardReplyVo cVo) {
		/*
		 * //현재 본문글에 해당하는 댓글의 levelOrder값을 구해온다.(없으면 levelOrder는 0, 댓글 있으면 levelOrder의 최대값보다 1씩 커야한다
		 * strLevelOrder = boardService.maxLevelOrder(boardIdx); //없을 경우 null 값이옴 int
		 * levelOrder = 0; if(strLevelOrder != null) levelOrder =
		 * Integer.parseInt(strLevelOrder) + 1;
		 * 
		 * boardService.setReplyInsert(boardIdx,nickname,hostip,content,levelOrder);
		 */
		
		String strLevelOrder = boardService.maxLevelOrder(cVo.getBoardIdx());
		int levelOrder = 0;
		if(strLevelOrder != null) levelOrder = Integer.parseInt(strLevelOrder) + 1;
		cVo.setLevelOrder(levelOrder);
		
		boardService.setReplyInsert(cVo);
		
		return 1;
	}
	
	@ResponseBody
	@RequestMapping(value="/bReplyDelete", method=RequestMethod.GET)
	public int bReplyDeleteGet(int idx) {
		boardService.bReplyDeleteGet(idx);
		return 1;
	}
	
	//부모댓글의 답변글(대댓글) 입력처리
	@ResponseBody
	@RequestMapping(value="/bContReplyInsert", method=RequestMethod.GET)
	public int bContReplyInsertGet(BoardReplyVo cVo) {
		//부모댓글보다 큰 모든 댓글의 levelOrder를 부모 댓글의 levelOrder 값에 +1하여 지정
		boardService.levelOrderPlusUpdate(cVo);
		//자신의 레벨은 부모의 레벨보다 +1
		cVo.setLevel(cVo.getLevel()+1);
		//자신의 레벨오더는 부모의 레벨오더보다 +1
		cVo.setLevelOrder(cVo.getLevelOrder()+1);
		
		//모든 설정이 끝난 cVo에 담긴 내용을 대댓글 테이블에 저장한다.
		boardService.bContReplyInsert(cVo);
		
		return 1; 
	}

	
	
}
