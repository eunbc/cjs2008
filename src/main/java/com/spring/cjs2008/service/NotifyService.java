package com.spring.cjs2008.service;

import java.util.List;

import com.spring.cjs2008.vo.NotifyVo;

public interface NotifyService {

	public void nInput(NotifyVo vo);

	public List<NotifyVo> getnList();

	public void nDelete(int idx);

	public NotifyVo getNUpdate(int idx);

	public void getNUpdateOk(NotifyVo vo);

	public int setpopupCheckUpdate(int idx, String popupSw);



}
