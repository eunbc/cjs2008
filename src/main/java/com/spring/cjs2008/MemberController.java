package com.spring.cjs2008;

import java.util.List;

import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.cjs2008.service.MemberService;
import com.spring.cjs2008.vo.MailVo;
import com.spring.cjs2008.vo.MemberVo;

@Controller
@RequestMapping("/member")
public class MemberController {
  String msgFlag = "";
  
  @Autowired
  MemberService memberService;
  
  @Autowired
  BCryptPasswordEncoder passwordEncoder;
	
    //로그인폼 호출
    @RequestMapping(value="/mLogin", method=RequestMethod.GET)
    public String mLoginGet(HttpServletRequest request, Model model) {
    	
/*    	Cookie[] getCookie = request.getCookies(); // 모든 쿠키 가져오기

    	if(getCookie != null){ // 만약 쿠키가 없으면 쿠키 생성

	    	for(int i=0; i<getCookie.length; i++){
		    	Cookie c = getCookie[i]; // 객체 생성
		    	String name = c.getName(); // 쿠키 이름 가져오기
		    	String value = c.getValue(); // 쿠키 값 가져오기
		    	System.out.println("쿠키네임=" +name);
		    	System.out.println("쿠키밸류=" +value);
		    	
	        }
    	}	
*/
    	//아이디 기억하기
	    Cookie[] cookies = request.getCookies(); //모든 쿠키 가져오기
    	for(int i=0; i<cookies.length; i++) {
    		String str = cookies[i].getName();
    		if(str.equals("cmid")) {
    			model.addAttribute("cmid",cookies[i].getValue());
    			break;
    		}
    	} 
    	return "member/mLogin";
    }

    //로그인 인증하기
    @RequestMapping(value="/mLogin", method=RequestMethod.POST)
    public String mLoginPost(String mid, String pwd, HttpSession session,
    		HttpServletResponse response, String rememberId) {
    	MemberVo vo = memberService.getIdCheck(mid);
  	
	  	//로그인시 세션생성
	  	if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
	  		String strLevel = "";
	  		if(vo.getLevel()==0) strLevel = "관리자";
	  		else if(vo.getLevel()==1) strLevel = "특별회원";
	  		else if(vo.getLevel()==2) strLevel = "우수회원";
	  		else if(vo.getLevel()==3) strLevel = "정회원";
	  		else if(vo.getLevel()==4) strLevel = "준회원";
	  		else strLevel = "비회원";
	  		
	  		session.setAttribute("smid" , mid);
	  		session.setAttribute("snickname", vo.getNickname());
	  		session.setAttribute("slevel", vo.getLevel());
	  		session.setAttribute("sStrLevel", strLevel);
	  		
	  		//아이디 기억하기 체크시 쿠키생성
	  		if(rememberId.equals("YES")) {
	  			Cookie cookie = new Cookie("cmid",mid);
	  			cookie.setMaxAge(60*60*24);
	  			response.addCookie(cookie);
	  		}
	  		else if(rememberId.equals("NO")) {
	  			System.out.println("나는 아이디 기억 안하겠다");
	  		}
	  		msgFlag = "mLoginOk";
	  	}
	  	else {
	  		msgFlag = "mLoginNo";
	  	}
	  	return "redirect:/msg/" + msgFlag;
    }
  
  @RequestMapping(value="/mLogout", method=RequestMethod.GET)
  public String mLogoutGet() {
	  msgFlag = "mLogoutOk";
	  return "redirect:/msg/"+msgFlag;
  }

  @RequestMapping(value="/mInput", method=RequestMethod.GET)
  public String mInputGet() {
  	return "member/mInput";
  }
  
  //회원가입 처리
  @RequestMapping(value="/mInput", method=RequestMethod.POST)
  public String mInputPost(MultipartFile file, MemberVo vo) {
  	// 아이디 중복체크
  	if(memberService.getIdCheck(vo.getMid()) != null) {
  		msgFlag = "mInputNo";
  		return "redirect:/msg/" + msgFlag;
  	}
  	//닉네임 중복체크
  	if(memberService.getNickCheck(vo.getNickname()) != null) {
  		msgFlag = "mInputNo";
  		return "redirect:/msg/" + msgFlag;
  	}
  	
  	// 비밀번호 암호화 처리
  	vo.setPwd(passwordEncoder.encode(vo.getPwd()));
  	
  	int res = memberService.mInput(file, vo);
  	if(res == 1) {
			msgFlag = "mInputOk";
		}
		else {
			msgFlag = "mInputNo";
		}
		
		return "redirect:/msg/" + msgFlag;
  }
  
  //아이디 중복확인(ajax)
  @ResponseBody
  @RequestMapping(value="/idCheck", method=RequestMethod.GET)
  public String idCheckGet(String mid) {
  	String res = "0";
  	MemberVo vo = memberService.getIdCheck(mid);
  	if(vo != null) res = "1";
  	
  	return res;
  }

  //닉네임 중복확인(ajax)
  @ResponseBody
  @RequestMapping(value="/nickCheck", method=RequestMethod.GET)
  public String nickCheckGet(String nickname) {
  	String res = "0";
  	MemberVo vo = memberService.getNickCheck(nickname);
  	if(vo != null) res = "1";
  	
  	return res;
  }

  @RequestMapping(value="/mPwdSearch", method=RequestMethod.GET)
  public String mPwdSearchGet() {
  	return "member/mPwdSearch";
  }

	/*
	 * @RequestMapping(value="/mPwdSearch", method=RequestMethod.POST) public String
	 * mPwdSearchPost(String mid, String email) { String pwd = "";
	 * 
	 * //기존 db에 아이디와 이메일이 일치하는지 확인하기 MemberVo vo =
	 * memberService.getPwdSearch(mid,email);
	 * 
	 * if(vo != null) { //임시비밀번호를 발급한다 UUID uid = UUID.randomUUID(); pwd =
	 * uid.toString().substring(0,6); memberService.setPwdChange(mid,
	 * passwordEncoder.encode(pwd)); //암호화 시킨 비밀번호를 저장 String toMail = email; String
	 * content = pwd; return
	 * "redirect:/mail/pwdConfirmMailForm/"+toMail+"/"+content+"/"; } else { msgFlag
	 * = "pwdConfirmNo"; return "redirect:/msg/"+msgFlag; } }
	 * 
	 */ 
  
  //RedirectAttributes객체를 이용한 값의 전달
  @RequestMapping(value="/mPwdSearch", method=RequestMethod.POST)
  public String mPwdSearchPost(MailVo mailVo, RedirectAttributes attributes) {
	
	//기존 db에 아이디와 이메일이 일치하는지 확인하기
	MemberVo vo = memberService.getPwdSearch(mailVo.getMid(),mailVo.getToMail());
	
	if(vo != null) {
		//임시비밀번호를 발급한다
		UUID uid = UUID.randomUUID();
		mailVo.setPwd(uid.toString().substring(0,6)); //새롭게 생성한 비밀번호
		memberService.setPwdChange(mailVo.getMid(), passwordEncoder.encode(mailVo.getPwd())); //암호화 시킨 비밀번호를 저장
		attributes.addFlashAttribute("mailVo", mailVo);
		return "redirect:/mail/pwdConfirmMailForm"; 
	}
	else {
		msgFlag = "pwdConfirmNo";
		return "redirect:/msg/"+msgFlag;
	}
  }
  
    @RequestMapping(value="/mIdSearch", method=RequestMethod.GET)
    public String mIdSearchGet() {
    	return "member/mIdSearch";
    }
    
    @RequestMapping(value="/mIdSearch", method=RequestMethod.POST)
    public String mIdSearchPost(String email) {
	  	MemberVo vo = memberService.getIdSearch(email);
	 	 
	  	if(vo!=null) {
	  		String toMail = email;
	  		return "redirect:/mail/idConfirmMailForm/"+toMail+"/";
	  	} 
	  	else {
	  		msgFlag = "idConfirmNo";
	  		return "redirect:/msg/"+msgFlag;
	  	}
    }
    
    //아이디 찾기(화면에서 바로 나타나도록 처리)
	@RequestMapping(value="/mMidSearch", method=RequestMethod.GET)
	public String mMidSearchGET() {
		return "member/mMidSearch";
	}
	
	@RequestMapping(value="/mMidSearch", method=RequestMethod.POST)
	public String mMidSearchPOST(Model model, String name, String email) {
		List<MemberVo> mvos = memberService.getMidSearch(name,email);
		String foundMid[] = new String[mvos.size()];	//검색해온 mid를 담아주기 위한 배열(같은 메일주소로 여러개의 아이디가 존재)
		MemberVo mvo = new MemberVo();
		for(int i=0; i<mvos.size(); i++) {
			mvo = mvos.get(i);
			foundMid[i] = mvo.getMid().substring(0,mvo.getMid().length()-2)+"**";
		}
		model.addAttribute("foundMid",foundMid);
		model.addAttribute("name",name);
		return "member/mSearchedMid";
	}    
    
    //정보 수정 비밀번호 체크
	@RequestMapping(value="/mUpdateCheck", method=RequestMethod.GET)
	public String mUpdateCheckGET() {
		return "member/mUpdateCheck";
	}
	
	@RequestMapping(value="/mUpdateCheck", method=RequestMethod.POST)
	public String mUpdateCheckPOST(String pwd, HttpSession session, RedirectAttributes attributes) {
		//비밀번호 확인 후 수정폼을 가져온다
		MemberVo vo = memberService.getIdCheck((session.getAttribute("smid")).toString());
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			attributes.addFlashAttribute("pwd",pwd);
			attributes.addFlashAttribute("vo",vo);
			return "redirect:/member/mUpdate/";
		}
		else {
			msgFlag = "PwdforUpdateNo";
			return "redirect:/msg/"+msgFlag;
		}
	}

    //정보 수정폼
	@RequestMapping(value="/mUpdate", method=RequestMethod.GET)
	public String mUpdateGET(String pwd, MemberVo vo) {
		return "member/mUpdate";
	}

    //정보 수정 제출
	@RequestMapping(value="/mUpdate", method=RequestMethod.POST)
	public String mUpdatePOST(MultipartFile file, MemberVo vo) {
		
		/*
		 * //닉네임 중복체크 if(memberService.getNickCheck(vo.getNickname()) != null) { msgFlag
		 * = "mUpdateNo"; return "redirect:/msg/" + msgFlag; }
		 */
	  	
	  	// 비밀번호 암호화 처리
	  	vo.setPwd(passwordEncoder.encode(vo.getPwd()));
	  	int res = memberService.mUpdate(file, vo);
	  	if(res == 1) {
				msgFlag = "mUpdateOk";
			}
			else {
				msgFlag = "mUpdateNo";
			}
			return "redirect:/msg/" + msgFlag;
	}

  
}
