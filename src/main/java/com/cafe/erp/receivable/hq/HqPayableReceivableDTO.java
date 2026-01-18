package com.cafe.erp.receivable.hq;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HqPayableReceivableDTO {
	
	
    private String receivableId;        // 채권 ID (지급 기준 키)
    private Integer vendorId;            // 거래처 ID
    private String receivableDate;       // 채권 발생일
    private Integer totalAmount;         // 채권 총액
    private Integer remainAmount;        // 남은 미지급 금액
}
