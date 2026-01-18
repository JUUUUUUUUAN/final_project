package com.cafe.erp.order;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderHqVendorDTO {

    private String hqOrderId;
    private int vendorId;

    private int orderSupplyAmount;
    private int orderTaxAmount;
    private int orderTotalAmount;
}
