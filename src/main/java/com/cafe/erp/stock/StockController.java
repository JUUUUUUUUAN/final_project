package com.cafe.erp.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.erp.member.MemberDTO;
import com.cafe.erp.order.OrderDetailDTO;
import com.cafe.erp.security.UserDTO;

@Controller
@RequestMapping("/stock/*")
public class StockController {
	
	@Autowired
	private StockService stockService;
	
	@GetMapping("stock")
	public String stock(@AuthenticationPrincipal UserDTO userDTO, Model model){
		MemberDTO member = userDTO.getMember();
		List<StockDTO> stockList = stockService.getStockByMember(member.getMemberId());
		model.addAttribute("stockList", stockList);
		return "stock/stock";
	}
	
	// 재고 기록 삽입
	public void insertStockHistory(StockDTO stockDTO, OrderDetailDTO orderDetailDTO) {
		stockService.insertStockHistory(stockDTO, orderDetailDTO);
	}
	// 재고 여부
	public int existsStock(StockDTO stockDTO){
	 	return stockService.existsStock(stockDTO);
	}
	// 재고 수량 변경
	public void updateStockQuantity(StockDTO stockDTO) {
		stockService.updateStockQuantity(stockDTO);
	}
	// 입출고 기록
	public void insertStock(StockDTO stockDTO) {
		stockService.insertStock(stockDTO);
	}
	
}
