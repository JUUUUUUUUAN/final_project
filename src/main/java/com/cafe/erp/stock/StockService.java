package com.cafe.erp.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.erp.order.OrderDetailDTO;
import com.cafe.erp.order.OrderService;

@Service
public class StockService {
	
	@Autowired
	private StockDAO stockDAO;

	public StockDTO insertStockHistory(StockDTO stockDTO, OrderDetailDTO orderDetailDTO) {
		stockDTO.setStockInoutType("IN");
		stockDTO.setItemId(orderDetailDTO.getItemId());
		stockDTO.setStockQuantity(orderDetailDTO.getHqOrderQty());
		stockDAO.insertStockHistory(stockDTO);
		return stockDTO;
	}
	
	public int  existsStock(StockDTO stockDTO) {
		return stockDAO.existsStock(stockDTO);
	}
	public void updateStockQuantity(StockDTO stockDTO) {
		stockDAO.updateStockQuantity(stockDTO);
	}
	public void insertStock(StockDTO stockDTO) {
		stockDAO.insertStock(stockDTO);
	}
	
	// 재고 정보 가져오기
	public List<StockDTO> getStockByMember(Integer memberId){
		int storeId = 0;
		int warehouseId = 0;
		if(String.valueOf(memberId).charAt(0) == '1') {
			warehouseId = 11;
		} else {
			storeId = stockDAO.getStoreIdBymemberId(memberId);
			warehouseId = stockDAO.getWarehouseIdByStoreId(storeId);
		}
		
		return stockDAO.getStockByWarehouseId(warehouseId);
	}
	
}
