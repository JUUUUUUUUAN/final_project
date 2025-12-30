package com.cafe.erp.store.contract;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContractDAO {
	
	public List<ContractDTO> list() throws Exception;

}
