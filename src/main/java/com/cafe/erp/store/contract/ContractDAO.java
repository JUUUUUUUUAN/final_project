package com.cafe.erp.store.contract;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContractDAO {
	
	public List<ContractDTO> list(ContractSearchDTO searchDTO) throws Exception;

	public String maxContractId(String id) throws Exception;

	public int add(ContractDTO contractDTO) throws Exception;

	public int addFile(ContractFileDTO contractFileDTO) throws Exception;

	public ContractDTO getDetail(String contractId) throws Exception;

	public int updateStatusToActive(LocalDate today) throws Exception;

	public int updateStatusToExpired(LocalDate yesterday) throws Exception;

	public int update(ContractDTO contractDTO) throws Exception;

	public ContractFileDTO selectFile(Integer fileId) throws Exception;

	public int deleteFile(Integer fileId) throws Exception;

	public Long count(ContractSearchDTO searchDTO) throws Exception;

	public List<ContractDTO> excelList(ContractSearchDTO searchDTO) throws Exception;

}
