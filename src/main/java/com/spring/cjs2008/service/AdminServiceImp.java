package com.spring.cjs2008.service;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2008.dao.AdminDao;

@Service
public class AdminServiceImp implements AdminService {
	@Autowired
	AdminDao adminDao;

	@Override
	public int imgDelete(String uploadPath) {
		File path = new File(uploadPath);
		//파일객체를 통해서 uploadPath경로안의 모든 파일의 정보를 담아와서 배열로 저장한다
		File[] fileList = path.listFiles();
		
		int fileCnt = fileList.length - 1;
		
		for(int i=0; i<fileList.length; i++) {
			fileList[i].delete();
		}
		
		return fileCnt;
	}
}
