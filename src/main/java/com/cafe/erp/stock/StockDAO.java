package com.cafe.erp.stock;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cafe.erp.order.OrderDetailDTO;

@Mapper
public interface StockDAO {
	
	
	public void insertStockHistory(StockDTO stockDTO);
	
	public int existsStock(StockDTO stockDTO);
	
	public void updateStockQuantity(StockDTO stockDTO);
	
	public void insertStock(StockDTO stockDTO);
	
	public int getStoreIdBymemberId(@Param("memberId") Integer memberId);
	public int getWarehouseIdByStoreId(@Param("storeId") Integer storeId);
	public List<StockDTO> getStockByWarehouseId(@Param("warehouseId") Integer warehouseId);

	
}

