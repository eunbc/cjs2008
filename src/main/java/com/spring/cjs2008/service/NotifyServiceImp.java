package com.spring.cjs2008.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2008.dao.NotifyDao;
import com.spring.cjs2008.vo.NotifyVo;

@Service
public class NotifyServiceImp implements NotifyService{
	@Autowired
	NotifyDao notifyDao;

	@Override
	public void nInput(NotifyVo vo) {
		notifyDao.nInput(vo);
	}

	@Override
	public List<NotifyVo> getnList() {
		return notifyDao.getnList();
	}

	@Override
	public void nDelete(int idx) {
		notifyDao.nDelete(idx);
	}

	@Override
	public NotifyVo getNUpdate(int idx) {
		return notifyDao.getNUpdate(idx);
	}

	@Override
	public void getNUpdateOk(NotifyVo vo) {
		notifyDao.getNUpdateOk(vo);
	}

	@Override
	public int setpopupCheckUpdate(int idx, String popupSw) {
		notifyDao.setpopupCheckUpdate(idx, popupSw);
		return 1;
	}


}
