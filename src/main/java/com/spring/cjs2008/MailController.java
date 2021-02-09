package com.spring.cjs2008;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs2008.service.MemberService;
import com.spring.cjs2008.vo.MailVo;
import com.spring.cjs2008.vo.MemberVo;

@Controller
@RequestMapping("/mail")
public class MailController {
	String msgFlag = "";
	
	@Autowired
	MemberService memberService;	
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value="/mailForm", method=RequestMethod.GET)
	public String mailFormGet() {
		return "mail/mailForm";
	}

	//일반 메일발송시의 설정
	@RequestMapping(value="/mailForm", method=RequestMethod.POST)
	public String mailFormPost(MailVo vo){
		//String fromMail = "joeunbi0514@gmail.com";
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");

			//메일 보관함에 저장
			//messageHelper.setFrom(fromMail);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			//메세지 내용과 함께 사진을 전송한다
			content = content.replace("\n", "<br/>");
			content += "<br><hr><h3>CJ GREEN입니다.<h3><hr><br>";
			content += "<p><img src=\"cid:dog3.jpg\" width='250px'></p><hr>";
			content += "<p>오늘도 행복한 시간되세요!! </p>";
			content += "<p><a href='http://218.236.203.76:9090/cjs2008/'>CJ Green</a></p>";
			messageHelper.setText(content, true);
			FileSystemResource file = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog3.jpg"));
			messageHelper.addInline("dog3.jpg", file);
			
			//메일과 함께 첨부파일 전송하기
			FileSystemResource mfile = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog2.jpg"));
			messageHelper.addAttachment("1.jpg", mfile);
			
			//메세지 내용과 함께 사진을 전송한다
			mailSender.send(message); //실제 메일 전송
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		msgFlag = "mailSendOk";
		return "redirect:/msg/"+msgFlag;
	}
	
	/*
	 * //비밀번호 분실시에 임시 비밀번호를 반송하기 위한 메일설정 , GET방식이어야 함
	 * 
	 * @RequestMapping(value="/pwdConfirmMailForm/{toMail}/{content}/",
	 * method=RequestMethod.GET) public String PwdConfirmMailFormGet(@PathVariable
	 * String toMail, @PathVariable String content){ String fromMail =
	 * "joeunbi0514@gmail.com"; String title = "비밀번호 확인 메일입니다."; String pwd =
	 * content; content =
	 * "그린나라에 발송된 메일입니다.\n아래 임시 비밀번호를 보내오니 사이트에 접속하셔서 비밀번호를 변경하세요.\n"; try {
	 * 
	 * MimeMessage message = mailSender.createMimeMessage(); MimeMessageHelper
	 * messageHelper = new MimeMessageHelper(message,true,"UTF-8");
	 * 
	 * //메일 보관함에 저장 messageHelper.setFrom(fromMail); messageHelper.setTo(toMail);
	 * messageHelper.setSubject(title); //messageHelper.setText(content);
	 * 
	 * //메세지 내용과 함께 사진을 전송한다 content = content.replace("\n", "<br/>"); content +=
	 * "<font color=red>"+ pwd + "</font><br>"; content +=
	 * "<br><hr><h3>CJ GREEN입니다.<h3><hr><br>"; content +=
	 * "<p><img src=\"cid:dog3.jpg\" width='250px'></p><hr>"; content +=
	 * "<p>오늘도 행복한 시간되세요!! </p>"; content +=
	 * "<p><a href='http://218.236.203.76:9090/cjs2008/'>CJ Green</a></p>";
	 * messageHelper.setText(content, true); FileSystemResource file = new
	 * FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog3.jpg"));
	 * messageHelper.addInline("dog3.jpg", file);
	 * 
	 * //메일과 함께 첨부파일 전송하기 // FileSystemResource mfile = new FileSystemResource(new
	 * File("C:/Users/Eunbi/Downloads/images/dog2.jpg")); //
	 * messageHelper.addAttachment("1.jpg", mfile);
	 * 
	 * //메세지 내용과 함께 사진을 전송한다 mailSender.send(message); //실제 메일 전송 } catch
	 * (MessagingException e) { e.printStackTrace(); } msgFlag = "pwdConfirmOk";
	 * return "redirect:/msg/"+msgFlag; }
	 */
	
	//비밀번호 분실시에 임시 비밀번호를 반송하기 위한 메일설정 , GET방식이어야 함
	@RequestMapping(value="/pwdConfirmMailForm", method=RequestMethod.GET)
	public String PwdConfirmMailFormGet(MailVo mailVo){
		String fromMail = "joeunbi0514@gmail.com";
		String title = "비밀번호 확인 메일입니다.";
		String pwd = mailVo.getPwd();
		String content = "그린나라에 발송된 메일입니다.\n아래 임시 비밀번호를 보내오니 사이트에 접속하셔서 비밀번호를 변경하세요.\n";
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");

			//메일 보관함에 저장
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(mailVo.getToMail());
			messageHelper.setSubject(title);
			//messageHelper.setText(content);
			
			//메세지 내용과 함께 사진을 전송한다
			content = content.replace("\n", "<br/>");
			content += "<font color=red>"+ pwd + "</font><br>";
			content += "<br><hr><h3>CJ GREEN입니다.<h3><hr><br>";
			content += "<p><img src=\"cid:btn_info.png\" width='250px'></p><hr>";
			content += "<p>오늘도 행복한 시간되세요!! </p>";
			content += "<p><a href='http://218.236.203.76:9090/cjs2008/'>CJ Green</a></p>";
			messageHelper.setText(content, true);
			FileSystemResource file = new FileSystemResource(new File("D:/Dev/images/btn_info.png"));
			messageHelper.addInline("btn_info.png", file);
			
			//메일과 함께 첨부파일 전송하기
//			FileSystemResource mfile = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog2.jpg"));
//			messageHelper.addAttachment("1.jpg", mfile);
			
			//메세지 내용과 함께 사진을 전송한다
			mailSender.send(message); //실제 메일 전송
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		msgFlag = "pwdConfirmOk";
		return "redirect:/msg/"+msgFlag;
	}
	
	//아이디 분실시에 아이디를 알려주기 위한 메일설정 , GET방식이어야 함
	@RequestMapping(value="/idConfirmMailForm/{toMail}/", method=RequestMethod.GET)
	public String idConfirmMailFormGet(@PathVariable String toMail){
		String fromMail = "joeunbi0514@gmail.com";
		String title = "아이디 확인 메일입니다.";
		String content = "그린나라에 발송된 메일입니다.\n아래 아이디를 확인한 후 로그인하세요.\n";
	  	
		//이메일 검색 후 해당하는 vo가져옴
		MemberVo vo = memberService.getIdSearch(toMail);
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");

			//메일 보관함에 저장
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			//아이디 뒤 세자리는 * 처리
			String mid = vo.getMid();
			String hiddenMid = mid.substring(0, mid.length()-3)+"***";
			
			//메세지 내용과 함께 사진을 전송한다
			content = content.replace("\n", "<br/>");
			content += "<h3>아이디 : <font color=red>"+ hiddenMid + "</font> (가입일 : "+vo.getJoinday().substring(0, 10)+")<h3><br>";
			content += "<p><img src=\"cid:btn_info.png\" width='250px'></p><hr>";
			content += "<p>오늘도 행복한 시간되세요!! </p>";
			content += "<p><a href='http://localhost:9090/cjs2008/member/mLogin'>CJ Green</a></p>";
			messageHelper.setText(content, true);
			FileSystemResource file = new FileSystemResource(new File("D:/Dev/images/btn_info.png"));
			messageHelper.addInline("btn_info.png", file);
			
			mailSender.send(message); //실제 메일 전송
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		msgFlag = "idConfirmOk";
		return "redirect:/msg/"+msgFlag;
	}
}
