package com.spring.cjs2008;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MsgController {
	@RequestMapping(value="/msg/{msgFlag}",method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,HttpSession session) {
		String nickname = session.getAttribute("snickname") == null? "" : (String) session.getAttribute("snickname");
		String strLevel = session.getAttribute("sStrLevel") == null? "" : (String) session.getAttribute("sStrLevel");
		
		if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg","파일이 업로드되었습니다.");
			model.addAttribute("url","study/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg","파일 업로드 실패.");
			model.addAttribute("url","study/fileUpload");
		}
		else if(msgFlag.equals("mInputOk")) {
			model.addAttribute("msg","회원가입이 정상적으로 처리되었습니다. \\n로그인 후 사용해 주세요.");
			model.addAttribute("url","member/mLogin");
		}
		else if(msgFlag.equals("mInputNo")) {
			model.addAttribute("msg","회원가입 실패");
			model.addAttribute("url","member/mInput");
		}
		else if(msgFlag.equals("mLoginOk")) {
			model.addAttribute("msg", nickname+"님("+strLevel+") 로그인 하셨습니다.");
			model.addAttribute("url","h");
		}
		else if(msgFlag.equals("mLoginNo")) {
			model.addAttribute("msg","로그인 실패");
			model.addAttribute("url","member/mLogin");
		}
		else if(msgFlag.equals("mLogoutOk")) {
			session.invalidate(); //모든 세션 종료
			model.addAttribute("msg",nickname + "님 로그아웃 되었습니다.");
			model.addAttribute("url","h");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg","메일이 정상적으로 발송되었습니다.");
			model.addAttribute("url","mail/mailForm");
		}
		else if(msgFlag.equals("pwdConfirmNo")) {
			model.addAttribute("msg","가입내역이 없습니다.");
			model.addAttribute("url","member/mPwdSearch");
		}
		else if(msgFlag.equals("pwdConfirmOk")) {
			model.addAttribute("msg","임시비밀번호를 발급하여 메일로 전송하였습니다.");
			model.addAttribute("url","member/mLogin");
		}
		else if(msgFlag.equals("idConfirmOk")) {
			model.addAttribute("msg","아이디 정보를 입력한 메일로 전송하였습니다.");
			model.addAttribute("url","member/mLogin");
		}
		else if(msgFlag.equals("idConfirmNo")) {
			model.addAttribute("msg","입력한 이메일의 가입내역이 없습니다.");
			model.addAttribute("url","member/mIdSearch");
		}
		else if(msgFlag.equals("PwdforUpdateNo")) {
			model.addAttribute("msg","비밀번호를 확인하세요.");
			model.addAttribute("url","member/mUpdateCheck");
		}
		else if(msgFlag.equals("mUpdateOk")) {
			model.addAttribute("msg","정보수정이 완료되었습니다.");
			model.addAttribute("url","member/mUpdateCheck");
		}
		else if(msgFlag.equals("mUpdateNo")) {
			model.addAttribute("msg","정보수정 실패");
			model.addAttribute("url","member/mUpdateCheck");
		}
		else if(msgFlag.equals("updateLevelOK")) {
			model.addAttribute("msg","등급 변경 완료");
			model.addAttribute("url","admin/member/aMList");
		}
		else if(msgFlag.equals("restricted")) {
			model.addAttribute("msg","접근 권한이 없습니다.");
			model.addAttribute("url","h");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg","관리자 구역입니다");
			model.addAttribute("url","h");
		}
		else if(msgFlag.equals("nInputOk")) {
			model.addAttribute("msg","공지사항이 등록되었습니다.");
			model.addAttribute("url","notify/nList");
		}
		else if(msgFlag.equals("nUpdateOk")) {
			model.addAttribute("msg","공지사항이 수정되었습니다.");
			model.addAttribute("url","notify/nList");
		}
		else if(msgFlag.equals("bInputOk")) {
			model.addAttribute("msg","게시판 글 작성 완료");
			model.addAttribute("url","board/bList");
		}
		else if(msgFlag.equals("imgDeleteOk")) {
			model.addAttribute("msg","게시판의 임시 그림 파일이 모두 삭제되었습니다.");
			model.addAttribute("url","admin/admin");
		}
		
		
		
		//예) msgFlag = "imgDeleteOk$fileCnt="+fileCnt;
		//앞의 예에서 특정 매개변수에 추가로 매개값이 넘어왔을 때는 아래와 같이 처리한다.
		else if(msgFlag.substring(0,11).equals("imgDeleteOk")) {
			model.addAttribute("msg","게시판의 임시그림파일("+msgFlag.substring(12)+")이 모두 삭제되었습니다.");
			model.addAttribute("url","admin/file/tempDelete");
		}
		else if(msgFlag.substring(0,10).equals("boardUpdNo")) {
			model.addAttribute("msg","게시글의 비밀번호가 틀립니다.");
			model.addAttribute("url","board/bContent?"+msgFlag.substring(11));
		}
		else if(msgFlag.substring(0,10).equals("boardDelNo")) {
			model.addAttribute("msg","게시글의 비밀번호가 틀립니다.");
			model.addAttribute("url","board/bContent?"+msgFlag.substring(11));
		}
		else if(msgFlag.substring(0,9).equals("bUpdateOk")) {
			model.addAttribute("msg","게시글 수정이 완료되었습니다.");
			model.addAttribute("url","board/bContent?"+msgFlag.substring(10));
		}
		else if(msgFlag.substring(0,9).equals("bDeleteOk")) {
			model.addAttribute("msg","게시글 삭제가 완료되었습니다.");
			model.addAttribute("url","board/bList?"+msgFlag.substring(10));
		}
		
		return "include/msg";
	}
}
