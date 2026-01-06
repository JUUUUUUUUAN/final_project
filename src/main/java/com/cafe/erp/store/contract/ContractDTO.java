package com.cafe.erp.store.contract;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContractDTO {

	private String contractId;
	private Integer storeId;
	private Integer contractRoyalti;
	private Integer contractDeposit;
	private LocalDate contractStartDate;
	private LocalDate contractEndDate;
	private Integer contractStatus;
	private LocalDateTime contractCreatedAt;
	private LocalDateTime contractUpdatedAt;
	
	// store table column
	private String storeName;
	private String storeAddress;
	
	// member table column
	private Integer memberId;
	private String memName;
	
	// store_contract_file table
	private List<ContractFileDTO> fileDTOs;
	
	public String getContractStatusStr() {
        if (this.contractStatus == null) return "";

        switch (this.contractStatus) {
            case 0: return "PENDING";
            case 1: return "ACTIVE";
            case 2: return "EXPIRED";
            default: return String.valueOf(this.contractStatus);
        }
    }
	
	public String getContractStartDateStr() {
        if (this.contractStartDate == null) return "";
        
        return this.contractStartDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
	
	public String getContractEndDateStr() {
        if (this.contractEndDate == null) return "";
        
        return this.contractEndDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
	
	public String getContractCreatedAtStr() {
        if (this.contractCreatedAt == null) return "";
        
        return this.contractCreatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
	
	public String getContractUpdatedAtStr() {
        if (this.contractUpdatedAt == null) return "";
        
        return this.contractUpdatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}
