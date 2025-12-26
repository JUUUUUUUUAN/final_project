package com.cafe.erp.store;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/store/*")
public class StoreController {
	
	@Autowired
	private StoreService storeService;

	@GetMapping("list")
	public void list(Model model) throws Exception {
		List<StoreDTO> storeList = storeService.list();
		model.addAttribute("list", storeList);
	}
	
}
