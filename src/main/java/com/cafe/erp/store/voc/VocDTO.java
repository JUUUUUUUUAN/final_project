package com.cafe.erp.store.voc;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VocDTO {
	
	private Integer vocId;
	private Integer memberId;
	private Integer storeId;
	private String vocTitle;
	private String vocType;
	private String vocContact;
	private String vocContents;
	private Integer vocStatus;
	private LocalDateTime vocCreatedAt;
	private LocalDateTime vocUpdatedAt;
	
	// member table column
	private String memName; // 작성자 이름
	private String ownerName; // 점주 이름
	
	// store table column 
	private String storeName;
	private Integer ownerId;
	private String storeAddress;
	
	public String getVocStatusStr() {
        if (this.vocStatus == null) return "";

        switch (this.vocStatus) {
            case 0: return "처리 대기";
            case 1: return "처리 중";
            case 2: return "처리 완료";
            default: return String.valueOf(this.vocStatus);
        }
    }
	
	public String getVocCreatedAtStr() {
        if (this.vocCreatedAt == null) return "";
        
        return this.vocCreatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
	
	public String getVocUpdatedAtStr() {
        if (this.vocUpdatedAt == null) return "";
        
        return this.vocUpdatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

}
