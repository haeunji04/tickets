package com.kh.tickets.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	
	@GetMapping("/admin/memberList.do")
	public void memberList() {
		// viewName설정이 없다면, 요청url에서 가져온다.
		// /WEB-INF/views/admin/adminList.jsp
	}
}


//현재 안쓰임 앞으로 안쓰일듯 지우기 전 그냥 보류 @#$@%%$%$%