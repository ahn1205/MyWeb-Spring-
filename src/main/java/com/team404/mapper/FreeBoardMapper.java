package com.team404.mapper;

import java.util.List;

import com.team404.command.FreeBoardVO;
import com.team404.utill.Criteria;

public interface FreeBoardMapper {
	public void Regist(FreeBoardVO vo);//글 등록 
	public List<FreeBoardVO> getList(Criteria cri);//글 목록 
	public int getTotal (Criteria cri);//총 게시글수 
	public FreeBoardVO getContent(int bno);
	public int getUpdate(FreeBoardVO vo);
	public int getDelete(int bno);

}
