package com.cafe.erp.receivable.hq;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HqPayableSummaryDTO {
	
	
    private Integer vendorCode;
    private String vendorName;
    private String baseMonth;

    private Long totalUnpaidAmount;    // 기준월 발주 총액 (고정)
    private Long remainUnpaidAmount;   // 지급 후 남은 금액
    private String payStatus;      
	
}
