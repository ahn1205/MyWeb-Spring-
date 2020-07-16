package com.team404.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team404.command.FreeBoardVO;
import com.team404.service.FreeBoardService;
import com.team404.utill.Criteria;
import com.team404.utill.PageVO;

@Controller
@RequestMapping("freeBoard")
public class FreeBoardController {

	/*
	 *  화면처리 -> 테이블 생성 -> 등록 처리
	 */
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	@RequestMapping("/freeList")
	public String freeList(Criteria cri,Model model) {
		
		//List<FreeBoardVO> list = freeBoardService.getList();		
		//model.addAttribute("boardList", list);

		//페이징 
		List<FreeBoardVO> list = freeBoardService.getList(cri);
		int total = freeBoardService.getTotal(cri);
		PageVO pageVO = new PageVO(cri, total);
		
//		int total = freeBoardService.getTotal();		
//		PageVO pageVO = new PageVO(cri,total);

		System.out.println(list.toString());
		System.out.println(total);
		
		model.addAttribute("boardList", list);
		model.addAttribute("pageVO", pageVO);
		
		return "freeBoard/freeList";
	}

	@RequestMapping("/freeRegist")
	public String freeRegist() {
		
		return "freeBoard/freeRegist";
	}
	
	@RequestMapping(value="/registForm",method = RequestMethod.POST)
	public String registForm(FreeBoardVO vo,RedirectAttributes RA) {
		
		freeBoardService.regist(vo);
		
		// 등록 여부 반환 1회성 사용가능
		RA.addFlashAttribute("msg", "정상등록 처리 되었습니다.");
		
		return "redirect:/freeBoard/freeList";
	}
	
	@RequestMapping("/freeDetail")
	public String freeDetail(@RequestParam("bno") int bno, Model model) {
		FreeBoardVO vo = freeBoardService.getContent(bno);
		model.addAttribute("boardVO", vo);
		return "freeBoard/freeDetail";
	}
	
	
	@RequestMapping("/freeModify")
	public String freeModify(FreeBoardVO vo,Model model) {
		
		model.addAttribute("boardVO", vo);
		
		return "freeBoard/freeModify";
	}
	
	//메서드가 같으면 묶어서 사용도 가능하다
//	@RequestMapping({"/freeModify","/freeDetail"})
//	public void getContent(@RequestParam("bno") int bno, Model model) {
//		
//		FreeBoardVO vo = freeBoardService.getContent(bno);
//		model.addAttribute("boardVO", vo);
//	}
	
	@RequestMapping("/updateForm")
	public String updateForm(FreeBoardVO vo,RedirectAttributes RA) {
		
		//성공시 1 실패시 0
		int result = freeBoardService.getUpdate(vo);
		
		if(result == 0) {
			RA.addFlashAttribute("msg", "게시글 수정이 실패했습니다");
		}else {
			RA.addFlashAttribute("msg", "게시글 수정이 정상 처리되었습니다");
		}		
		return "redirect:/freeBoard/freeList";
	}	
	
	@RequestMapping("/freeDelete")
	public String freeDelete(FreeBoardVO vo,RedirectAttributes RA) {
		
		int result = freeBoardService.getDelete(vo.getBno());
		
		if(result==0) {
			RA.addFlashAttribute("msg", "게시글 삭제가 실패했습니다");			
		}else {
			RA.addFlashAttribute("msg", "게시글 삭제가 성공했습니다");
		}
		return "redirect:/freeBoard/freeList";
	}		
}
