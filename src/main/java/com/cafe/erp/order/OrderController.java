package com.cafe.erp.order;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.erp.item.ItemDTO;
import com.cafe.erp.item.ItemService;
import com.cafe.erp.store.StoreService;
import com.cafe.erp.vendor.VendorService;

@Controller
@RequestMapping("/order/*")
public class OrderController {

    private final StoreService storeService;
	
	private final ItemService itemService;
	private final VendorService vendorService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
    public OrderController(ItemService itemService, VendorService vendorService, StoreService storeService) {
        this.itemService = itemService;
        this.vendorService = vendorService;
        this.storeService = storeService;
    }
	
	// 본사 발주 등록 페이지 요청
	@GetMapping("request")
	public String request(Model model) {
		model.addAttribute("showVendorSelect", true);
		model.addAttribute("vendorList", vendorService.findAll());
		return "order/hqOrder";
	}
	
	// 발주 등록 상품 검색 목록 요청
	@GetMapping("/order/itemSearch")
	@ResponseBody
	public List<ItemDTO> searchForOrder(
	        @RequestParam(required = false) Long vendorCode,
	        @RequestParam(required = false) String keyword) {
		
	    return itemService.searchForOrder(vendorCode, keyword);
	}
	
	// 본사 발주 등록
	@PostMapping("request")
	public String request(OrderDTO orderDTO) {
		orderService.requestOrder(orderDTO);
		return "redirect:./approval";
	}
	
	// 발주 목록 요청
	@GetMapping("approval")
	public void approval(Model model) {
		List<OrderDTO> orderHqList = orderService.listHq();
		model.addAttribute("orderHqList", orderHqList);
		List<OrderDTO> orderStoreList = orderService.listStore();
		model.addAttribute("orderStoreList", orderStoreList);
	}
	
	@GetMapping("detail")
	public String orderDetail(@RequestParam String orderNo, Model model) {
		System.out.println("🔥 orderNo = " + orderNo);
	    List<OrderDetailDTO> items = orderService.getOrderItems(orderNo);
	    System.out.println("🔥 items size = " + items.size());
	    System.out.println(items.iterator().next().getHqOrderItemName());
	    System.out.println(items.iterator().next().getHqOrderQty());
	    System.out.println(items.iterator().next().getHqOrderPrice());
	    System.out.println(items.iterator().next().getHqOrderAmount());
	    model.addAttribute("items", items);

	  return "order/orderDetailFragment"; // tbody용 fragment
	}
	
	@PostMapping("approve")
	@ResponseBody
	public String approveOrder(@RequestBody List<String> orderNos) {
		orderService.approveOrder(orderNos);
		return null;
	}

}