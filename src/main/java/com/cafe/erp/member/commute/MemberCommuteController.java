package com.cafe.erp.member.commute;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.erp.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/commute/*")
public class MemberCommuteController {
	
	@Autowired
	private MemberCommuteService commuteService;
	
	@PostMapping("checkIn")
	@ResponseBody
	public String checkIn(HttpSession session) throws Exception{
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		
		if(login == null) {
			return "fail";
		}
		
		
		int result = commuteService.checkIn(login.getMemberId());
		
		if(result > 0) {
			return "success";
		}
		
		return "already";
	}
	
	@PostMapping("checkOut")
	@ResponseBody
	public String checkOut(HttpSession session) throws Exception{
		MemberDTO login = (MemberDTO)session.getAttribute("login");
		
		if(login == null) {
			return "fail";
		}
		
		
		int result = commuteService.checkOut(login.getMemberId());
		
		if(result > 0) {
			return "success";
		}
		
		return "already";
	}

}
