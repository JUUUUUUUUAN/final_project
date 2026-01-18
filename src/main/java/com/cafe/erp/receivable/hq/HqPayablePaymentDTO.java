package com.cafe.erp.receivable.hq;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HqPayablePaymentDTO {
    private String receivableId;
    private Integer payAmount;
    private String memo;
    
}
