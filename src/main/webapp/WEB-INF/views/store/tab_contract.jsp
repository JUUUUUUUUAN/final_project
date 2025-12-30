<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
    <div class="card shadow-none border bg-white mb-4">
        <div class="card-body py-3 px-3">
            <form id="contractSearchForm" onsubmit="return false;">
                <div class="row g-3">
                    <div class="col-md-2">
                        <label class="form-label small text-muted">계약 상태</label>
                        <select class="form-select" id="searchContractStatus">
                            <option value="">전체</option>
                            <option value="ACTIVE">유효 (Active)</option>
                            <option value="EXPIRED">만료 (Expired)</option>
                            <option value="TERMINATED">해지 (Terminated)</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted">계약 시작일 구간</label>
                        <div class="input-group">
                            <input type="date" class="form-control" id="searchStartDateFrom" />
                            <span class="input-group-text">~</span>
                            <input type="date" class="form-control" id="searchStartDateTo" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">가맹점 주소</label>
                        <input type="text" class="form-control" placeholder="시/군/구 입력" id="searchStoreAddress" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label small text-muted">로얄티 / 여신(보증금)</label>
                        <div class="input-group">
                            <select class="form-select" style="flex: 0 0 40%;">
                                <option value="royalti">로얄티</option>
                                <option value="deposit">여신</option>
                            </select>
                            <input type="number" class="form-control" placeholder="최소 금액" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small text-muted">가맹점명 검색</label>
                        <div class="input-group input-group-merge">
                            <span class="input-group-text"><i class="bx bx-search"></i></span>
                            <input type="text" class="form-control" placeholder="가맹점 이름" id="searchStoreName" />
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-end justify-content-end gap-2">
                        <button class="btn btn-outline-secondary" type="reset"><i class="bx bx-refresh"></i> 초기화</button>
                        <button class="btn btn-primary px-5" onclick="searchContracts()"><i class="bx bx-search"></i> 조회</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
	

	        
	<div class="card shadow-none border bg-white">
	     	
		<div class="card-header d-flex justify-content-between align-items-center">
	    	<h5 class="mb-0">가맹점 계약 목록</h5>
	        <div>
	       		<button type="button" class="btn btn-outline-success me-2">
	            	<i class='bx bx-download me-1'></i> 엑셀 다운로드
	            </button>
	          	<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerContractModal">
	                <i class="bx bx-plus me-1"></i> 계약 등록
	          	</button>
	     	</div>
		</div>
	  
	    <div class="table-responsive">
	    	<table class="table table-hover table-striped">
	          
	        	<thead>
	            	<tr>
	              		<th width="5%">
	              			계약번호 <i class="bx bx-sort-alt-2 sort-icon"></i>
	              		</th>
	              		<th>
	                		가맹점명 <i class="bx bx-sort-alt-2 sort-icon"></i>
	              		</th>
		                <th class="text-end">
		                	로얄티 <i class="bx bx-sort-alt-2 sort-icon"></i>
		              	</th>
		              	<th class="text-end"> 
		                	여신(보증금) <i class="bx bx-sort-alt-2 sort-icon"></i>
		              	</th>
		              	<th>
		                	계약 시작일 <i class="bx bx-sort-alt-2 sort-icon"></i>
		              	</th>
		                <th>
		                	계약 종료일 <i class="bx bx-sort-alt-2 sort-icon"></i>
		                </th>
		                <th>상태</th>
		              	<th></th>
		            </tr>
	          	</thead>
	            
	          	<tbody>
	            	<c:forEach items="${list}" var="dto">
	       				<tr>
	         				<td>${dto.contractId}</td>
				            <td><span class="fw-bold text-primary">${dto.storeName}</span></td>
				            <td class="text-end">
				            	<fmt:formatNumber value="${dto.contractRoyalti}" pattern="#,###" />
				            </td>
				            <td class="text-end">
				            	<fmt:formatNumber value="${dto.contractDeposit}" pattern="#,###" />
				            </td>
				            <td>${dto.contractStartDate}</td>
				            <td>${dto.contractEndDate}</td>
				            <td>
				            	<c:if test="${dto.contractStatus eq 1}"><span class="badge bg-label-info">ACTIVE</span></c:if>
				            	<c:if test="${dto.contractStatus eq 2}"><span class="badge bg-label-warning">EXPIRED</span></c:if>
				            </td>
	                        <td>
	                        	<button class="btn btn-sm btn-icon btn-outline-secondary"><i class="bx bx-edit"></i></button>
	                     	</td>
	                    </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	    </div>
	            
	    <div class="card-footer d-flex justify-content-center">
	        <nav aria-label="Page navigation">
	            <ul class="pagination">
	                <li class="page-item prev"><a class="page-link" href="#"><i class="bx bx-chevron-left"></i></a></li>
	                <li class="page-item active"><a class="page-link" href="#">1</a></li>
	                <li class="page-item"><a class="page-link" href="#">2</a></li>
	                <li class="page-item next"><a class="page-link" href="#"><i class="bx bx-chevron-right"></i></a></li>
	            </ul>
	        </nav>
	    </div>
	</div>
	
    <div class="modal fade" id="registerContractModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">가맹점 계약 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="registerContractForm">
                        <div class="row g-3">
                        
                        	<div class="col-md-12">
                                <label class="form-label" for="storeNameInput">가맹점명 검색 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="text" id="storeNameInput" class="form-control" placeholder="가맹점명 입력" onkeyup="if(window.event.keyCode==13){searcStore()}" required />
                                    <input type="hidden" id="storeId" name="storeId" />
                                    <button class="btn btn-primary" type="button" onclick="searcStore()">
                                        <i class="bx bx-search"></i>
                                    </button>
                                </div>
                                
                                <ul id="storeResultList" class="list-group position-absolute overflow-auto" 
						        	style="max-height: 200px; width: 90%; z-index: 1050; display: none; margin-top: 5px; box-shadow: 0 0.25rem 1rem rgba(0,0,0,0.15); background-color: rgba(255, 255, 255, 0.9);">
						        </ul>
                            </div>
                            
                            <div class="col-12"><hr class="my-2"></div>
                            <div class="col-md-6">
                                <label class="form-label" for="royalti">로얄티</label>
                                <div class="input-group">
                                    <span class="input-group-text">₩</span>
                                    <input type="number" id="royalti" class="form-control" placeholder="500000" />
                                    <span class="input-group-text">원</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="deposit">여신 (보증금)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₩</span>
                                    <input type="number" id="deposit" class="form-control" placeholder="50000000" />
                                    <span class="input-group-text">원</span>
                                </div>
                            </div>
                            <div class="col-12"><hr class="my-2"></div>
                            
							<div class="col-md-6">
								<label class="form-label" for="startDate">계약 시작일</label>
								<input type="date" id="startDate" class="form-control" required />
							</div>
							
							<div class="col-md-6">
								<label class="form-label" for="endDate">계약 종료일</label>
								<input type="date" id="endDate" class="form-control" required />
							</div>
                            
                            <div class="col-md-12">
                                <label class="form-label" for="contractStatus">계약 상태</label>
                                <select id="contractStatus" class="form-select">
                                	<option value="0">PENDING (대기)</option>
                                    <option value="1">ACTIVE (유효)</option>
                                </select>
                            </div>

                            <div class="col-12 mt-3">
                                <label class="form-label">첨부파일</label>
                                <div id="fileContainer">
                                    <div class="input-group mb-2">
                                        <input type="file" class="form-control" name="contractFiles">
                                        <button type="button" class="btn btn-outline-primary" onclick="addFileField()">
                                            <i class="bx bx-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="form-text small text-muted">
                                    ※  + 버튼을 누르면 첨부파일 칸이 추가됩니다.
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="submitContractRegistration()">계약 저장</button>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="/js/store/tab_contract.js"></script>
    
</html>