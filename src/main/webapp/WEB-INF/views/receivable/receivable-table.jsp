<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${not empty errorMessage}">
  <div id="searchError" class="alert alert-danger mb-3">
    ${errorMessage}
  </div>
</c:if>

<table class="table table-hover align-middle mb-0">
  <thead class="table-light">
    <tr>
      <th class="ps-4" style="width: 40%;">가맹점</th> <th class="text-center" style="width: 20%;">기준월</th> <th class="text-end" style="width: 30%;">남은 미수금</th> <th class="text-center" style="width: 10%;">관리</th>
    </tr>
  </thead>

  <tbody class="table-border-bottom-0">
    <c:forEach var="row" items="${receivables}">
      <tr>
        <td class="ps-4">
          <span class="fw-bold text-dark" style="font-size: 0.95rem;">${row.storeName}</span>
        </td>
        <td class="text-center">
          <span class="badge bg-label-secondary px-2 py-1" style="font-size: 0.8rem;">
            ${row.baseMonth}
          </span>
        </td>
        <td class="text-end">
          <span class="fw-bold text-primary fs-6">
            <fmt:formatNumber value="${row.totalAmount}" />
          </span>
          <small class="text-muted ms-1">원</small>
        </td>
        <td class="text-center">
          <a href="/receivable/receivableDetail?storeId=${row.storeId}&storeName=${row.storeName}&baseMonth=${row.baseMonth}"
             class="btn btn-icon btn-sm btn-outline-primary rounded-pill">
            <i class="bx bx-chevron-right"></i>
          </a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
</table>
<div class="px-4 py-3 border-top">
  <jsp:include page="/WEB-INF/views/common/pagination.jsp" />
</div>