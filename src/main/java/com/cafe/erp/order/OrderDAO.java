package com.cafe.erp.order;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.cafe.erp.item.ItemDTO;

@Mapper
public interface OrderDAO {
	
	public String selectMaxOrderId(String prefix, String orderDate);
	
	public void insertOrder(OrderDTO orderDTO);
	
	public void insertOrderDetail(OrderDetailDTO orderDetailDTO);
	
	public List<OrderDTO> listHq();
	
	public List<OrderDTO> listStore();

	public List<OrderDetailDTO> getOrderItems(@Param("orderNo") String orderNo);
	
	public void approveOrder(@Param("orderNo") String orderNo);
	
}
