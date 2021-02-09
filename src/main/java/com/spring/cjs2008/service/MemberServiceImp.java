package com.spring.cjs2008.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2008.dao.MemberDao;
import com.spring.cjs2008.vo.MemberVo;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDao memberDao;

	@Override
	public int mInput(MultipartFile file, MemberVo vo) {
		int res = 0;
		try {
			//if(vo.getPhoto() != null) {
			String oFileName = file.getOriginalFilename();
			System.out.println("file명 : " + oFileName);
			if(oFileName != "") {
				
				UUID uid = UUID.randomUUID(); // UUID객체를 통한 고유번호를 생성
				
				String saveFileName = uid + "_" + oFileName;
				
				writeFile(file, saveFileName);
				vo.setPhoto(saveFileName);
			}
			else {
				if(vo.getGender().equals("남자")) {
					vo.setPhoto("male.jpg");
				}
				else {
					vo.setPhoto("female.jpg");
				}
			}
			memberDao.mInput(vo); // 파일이 업로드 성공시에 DB에 정보를 저장한다.
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	private void writeFile(MultipartFile mFile, String saveFileName) throws IOException {
		byte[] data = mFile.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		
		fos.close();
	}

	@Override
	public MemberVo getIdCheck(String mid) {
		return memberDao.getIdCheck(mid);
	}

	@Override
	public MemberVo getNickCheck(String nickname) {
		return memberDao.getNickCheck(nickname);
	}

	@Override
	public MemberVo getPwdSearch(String mid, String email) {
		return memberDao.getPwdSearch(mid,email);
	}

	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDao.setPwdChange(mid,pwd);
	}

	@Override
	public MemberVo getIdSearch(String email) {
		return memberDao.getIdSearch(email);
	}

	@Override
	public List<MemberVo> getMidSearch(String name, String email) {
		return memberDao.getMidSearch(name,email);
	}

	@Override
	public int mUpdate(MultipartFile file, MemberVo vo) {
		int res = 0;
		try {
			String oFileName = file.getOriginalFilename();
			System.out.println("file명 : " + oFileName);
			if(oFileName != "") {
				
				// 새로운 파일 업로드 처리
				UUID uid = UUID.randomUUID(); // UUID객체를 통한 고유번호를 생성
				String saveFileName = uid + "_" + oFileName;
				
				writeFile(file, saveFileName);
				vo.setPhoto(saveFileName);
			}
			memberDao.mUpdate(vo); // 파일이 업로드 성공시에 DB에 정보를 저장한다.
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;		
	}

	@Override
	public int totRecCnt() {
		return memberDao.totRecCnt();
	}

	@Override
	public List<MemberVo> getMemberList(int startNo, int pageSize) {
		return memberDao.getMemberList(startNo,pageSize);
	}

	@Override
	public void updateLevel(int idx, int level) {
		memberDao.updateLevel(idx,level);
	}

}
