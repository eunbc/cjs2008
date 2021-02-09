package com.spring.cjs2008;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs2008.service.AdminService;
import com.spring.cjs2008.service.MemberService;
import com.spring.cjs2008.vo.GuestVo;
import com.spring.cjs2008.vo.MemberVo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/aCheck",method=RequestMethod.GET)
	public String aCheckGet() {
		return "admin/admin";
	}

	@RequestMapping(value="/aLeft",method=RequestMethod.GET)
	public String aLeftGet() {
		return "admin/leftMenu";
	}
	
	@RequestMapping(value="/aContent",method=RequestMethod.GET)
	public String aContentGet() {
		return "admin/content";
	}
	
	@RequestMapping(value="/guest/aGList",method=RequestMethod.GET)
	public String aGListGet() {
		return "admin/guest/aGList";
	}
	
	@RequestMapping(value="/member/aMList",method=RequestMethod.GET)
	public String aMListGet(HttpServletRequest request,Model model) {
	    // 블록페이지를 위한 준비 시작
	    int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
	    int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
	    int totRecCnt = memberService.totRecCnt();
	    int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (int) totRecCnt/pageSize + 1;
	    int startNo = (pag - 1) * pageSize;
	    int curScrNo = totRecCnt - startNo;
	    int blockSize = 3; // 블록의 크기를 3으로 지정함.
	    // 블록페이지를 위한 준비 끝
	    
	    List<MemberVo> vos = memberService.getMemberList(startNo, pageSize);
	    
	    model.addAttribute("vos",vos);
	    
	    // 블록페이지를 위해 넘겨주는 변수들
	    request.setAttribute("pag", pag);
	    request.setAttribute("totPage", totPage);
	    request.setAttribute("curScrNo", curScrNo);
	    request.setAttribute("blockSize", blockSize);
		
		return "admin/member/aMList";
	}
	
	@RequestMapping(value="/adminOut",method=RequestMethod.GET)
	public String adminOutGet() {
		return "redirect:/";
	}

	@RequestMapping(value="/member/updateLevel",method=RequestMethod.POST)
	public String updateLevelPost(int level, int idx, int pag) {
		memberService.updateLevel(idx,level);
		msgFlag="updateLevelOK";
		return "redirect:/msg/"+msgFlag;
	}
	
	@RequestMapping(value="/file/tempDelete",method=RequestMethod.GET)
	public String tempDeleteGet() {
		return "admin/file/tempDelete";
	}
	
	@RequestMapping(value="/file/boardTempDelete",method=RequestMethod.GET)
	public String boardTempDeleteGet(HttpServletRequest request) {
		//board작업시에 생성된 'ckeditor/images' 폴더의 모든 그림 파일들을 삭제처리시킨다
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/ckeditor/images/");
		int fileCnt = adminService.imgDelete(uploadPath);
		
		msgFlag = "imgDeleteOk$"+fileCnt;
		
		return "redirect:/msg/"+msgFlag;
	}
	
}
