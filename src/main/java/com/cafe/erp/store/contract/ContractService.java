package com.cafe.erp.store.contract;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ContractService {
	
	@Autowired
	private ContractDAO contractDAO;
	
	public List<ContractDTO> list() throws Exception {
		return contractDAO.list();
	}

	public int add(ContractDTO contractDTO, List<MultipartFile> files) {
		return 0;
	}

}
