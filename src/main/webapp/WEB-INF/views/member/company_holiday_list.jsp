<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html
  lang="ko"
  class="light-style layout-menu-fixed"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../assets/"
  data-template="vertical-menu-template-free"
>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회사 휴무 관리</title>

  <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

  <link rel="stylesheet" href="/vendor/fonts/boxicons.css" />
  <link rel="stylesheet" href="/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="/css/demo.css" />
  <link rel="stylesheet" href="/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <script src="/vendor/js/helpers.js"></script>
  <script src="/js/config.js"></script>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
  <div class="layout-container">

    <c:import url="/WEB-INF/views/template/aside.jsp"></c:import>

    <div class="layout-page">
      <c:import url="/WEB-INF/views/template/header.jsp"></c:import>

      <div class="content-wrapper">
        <div class="container-xxl flex-grow-1 container-p-y">

          <h4 class="fw-bold py-3 mb-4">
            <span class="text-muted fw-light">회사 관리 /</span> 회사 휴무일 관리
          </h4>

          <!-- 검색/필터 카드 -->
          <div class="card mb-4">
            <div class="card-body">
              <form id="searchForm" class="row gx-3 gy-2 align-items-end" onsubmit="return false;">
                <div class="col-md-4">
                  <label class="form-label">기간</label>
                  <div class="input-group">
                    <input type="date" id="startDate" class="form-control" />
                    <span class="input-group-text">~</span>
                    <input type="date" id="endDate" class="form-control" />
                  </div>
                </div>

                <div class="col-md-3">
                  <label class="form-label">유형</label>
                  <select id="typeFilter" class="form-select">
                    <option value="">전체</option>
                    <option value="법정공휴일">법정공휴일</option>
                    <option value="회사휴일">회사휴일</option>
                  </select>
                </div>

                <div class="col-md-3">
                  <label class="form-label">검색어 (휴무명)</label>
                  <input type="text" id="keyword" class="form-control" placeholder="예: 창립기념일" />
                </div>

                <div class="col-md-2 d-flex gap-2">
                  <button type="button" class="btn btn-primary w-100" onclick="applyFilter()">
                    <i class="bx bx-search"></i> 검색
                  </button>

                  <!-- 추가 버튼: MASTER/DEPT_HR만 -->
                  <sec:authorize access="hasAnyRole('MASTER','DEPT_HR')">
                    <button type="button" class="btn btn-outline-primary w-100" onclick="openAddModal()">
                      <i class="bx bx-plus"></i> 추가
                    </button>
                  </sec:authorize>
                </div>
              </form>
            </div>
          </div>

          <!-- 목록 카드 -->
          <div class="card">
            <div class="card-header">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h5 class="mb-1">휴무 목록</h5>
                  <div class="text-muted small">
                    법정공휴일 + 회사휴일을 함께 관리합니다.
                  </div>
                </div>

                <!-- API 동기화 버튼(선택): MASTER/DEPT_HR만 -->
                <sec:authorize access="hasAnyRole('MASTER','DEPT_HR')">
                  <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-success" onclick="syncHolidayApi()">
                      <i class='bx bx-cloud-download me-1'></i> 법정공휴일 동기화
                    </button>
                  </div>
                </sec:authorize>
              </div>
            </div>

            <div class="table-responsive text-nowrap">
              <table class="table table-hover" id="holidayTable">
                <thead>
                  <tr class="table-light">
                    <th style="width: 160px;">날짜</th>
                    <th style="width: 140px;">유형</th>
                    <th>휴무명</th>
                    <th style="width: 160px;">등록자</th>
                    <th class="text-center" style="width: 120px;">관리</th>
                  </tr>
                </thead>
                <tbody class="table-border-bottom-0" id="holidayTbody">

                  <c:forEach items="${list}" var="h">
                    <tr
                      class="holiday-row"
                      data-date="${h.comHolidayDate}"
                      data-type="${h.comHolidayType}"
                      data-name="${fn:escapeXml(h.comHolidayName)}"
                    >
                      <td>
                        <fmt:formatDate value="${h.comHolidayDate}" pattern="yyyy-MM-dd" />
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${h.comHolidayType eq '회사휴일'}">
                            <span class="badge bg-label-primary">회사휴일</span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge bg-label-secondary">법정공휴일</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td class="fw-semibold text-dark">
                        ${h.comHolidayName}
                      </td>
                      <td class="text-muted">
                        ${h.memberId}
                      </td>
                      <td class="text-center">

                        <!-- 회사휴일만 삭제 가능 + MASTER/DEPT_HR만 -->
                        <sec:authorize access="hasAnyRole('MASTER','DEPT_HR')">
                          <c:if test="${h.comHolidayType eq '회사휴일'}">
                            <button type="button"
                                    class="btn btn-sm btn-icon btn-outline-danger"
                                    title="삭제"
                                    onclick="deleteHoliday(${h.companyHolidayId})">
                              <i class="bx bx-trash"></i>
                            </button>
                          </c:if>
                        </sec:authorize>

                        <c:if test="${h.comHolidayType ne '회사휴일'}">
                          <span class="text-muted small">-</span>
                        </c:if>

                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty list}">
                    <tr>
                      <td colspan="5" class="text-center py-4">등록된 휴무일이 없습니다.</td>
                    </tr>
                  </c:if>

                </tbody>
              </table>
            </div>

            <div class="card-footer text-muted small">
              * 회사휴일은 관리자/인사만 추가/삭제 가능합니다. (법정공휴일은 동기화로 관리)
            </div>
          </div>

        </div>

        <c:import url="/WEB-INF/views/template/footer.jsp"></c:import>
        <div class="content-backdrop fade"></div>
      </div>
    </div>
  </div>

  <div class="layout-overlay layout-menu-toggle"></div>
</div>


<!-- 회사휴일 추가 모달 -->
<sec:authorize access="hasAnyRole('MASTER','DEPT_HR')">
  <div class="modal fade" id="holidayAddModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title fw-bold">회사 휴무일 추가</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">날짜</label>
            <input type="date" id="addDate" class="form-control" />
          </div>

          <div class="mb-2">
            <label class="form-label">휴무명</label>
            <input type="text" id="addName" class="form-control" placeholder="예: 창립기념일" maxlength="50" />
            <div class="text-danger small mt-2" id="addError" style="display:none;"></div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" onclick="submitAddHoliday()">저장</button>
        </div>
      </div>
    </div>
  </div>
</sec:authorize>


<script src="/vendor/libs/jquery/jquery.js"></script>
<script src="/vendor/libs/popper/popper.js"></script>
<script src="/vendor/js/bootstrap.js"></script>
<script src="/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="/vendor/js/menu.js"></script>
<script src="/js/main.js"></script>

<script>
  function openAddModal() {
    $('#addError').hide().text('');
    $('#addDate').val('');
    $('#addName').val('');
    const modalEl = document.getElementById('holidayAddModal');

    if (window.bootstrap) {
      new bootstrap.Modal(modalEl).show();
    } else {
      $('#holidayAddModal').modal('show');
    }
  }

  function submitAddHoliday() {
    const date = $('#addDate').val();
    const name = $('#addName').val().trim();
    const $err = $('#addError');

    if (!date) {
      $err.text('날짜를 선택하세요.').show();
      return;
    }
    if (!name) {
      $err.text('휴무명을 입력하세요.').show();
      return;
    }

    $.ajax({
      url: '/member/admin_holiday_add',
      type: 'POST',
      data: {
        comHolidayDate: date,
        comHolidayName: name
      },
      success: function() {
        alert('추가되었습니다.');
        location.reload();
      },
      error: function(xhr) {
        // 서버에서 400/500 등 내려오면 여기로
        alert('추가 실패: 서버 오류');
        console.log(xhr);
      }
    });
  }

  function deleteHoliday(companyHolidayId) {
    if (!confirm('정말 삭제하시겠습니까?')) return;

    $.ajax({
      url: '/member/admin_holiday_delete',
      type: 'POST',
      data: { companyHolidayId: companyHolidayId },
      success: function(res) {
        if (res === 'success') {
          alert('삭제되었습니다.');
          location.reload();
        } else {
          alert('삭제 실패');
        }
      },
      error: function() {
        alert('서버 통신 오류');
      }
    });
  }

  function applyFilter() {
    const start = $('#startDate').val();
    const end = $('#endDate').val();
    const type = $('#typeFilter').val();
    const keyword = $('#keyword').val().trim().toLowerCase();

    const rows = document.querySelectorAll('.holiday-row');
    let shown = 0;

    rows.forEach(r => {
      const d = r.dataset.date;     // yyyy-mm-dd
      const t = r.dataset.type || '';
      const n = (r.dataset.name || '').toLowerCase();

      let ok = true;

      if (start && d < start) ok = false;
      if (end && d > end) ok = false;
      if (type && t !== type) ok = false;
      if (keyword && !n.includes(keyword)) ok = false;

      r.style.display = ok ? '' : 'none';
      if (ok) shown++;
    });

    // empty 상태 표시(간단)
    // (원하면 "검색 결과 없음" row 따로 만들 수도 있음)
  }

  // 법정공휴일 API 동기화 (옵션)
  function syncHolidayApi() {
    const year = new Date().getFullYear();
    if (!confirm(year + '년 법정공휴일을 동기화할까요? (중복은 서버에서 방지해야 함)')) return;

    $.ajax({
      url: '/member/admin_holiday_api_sync',
      type: 'POST',
      data: { year: year },
      success: function(res) {
        alert('동기화 요청 완료');
        location.reload();
      },
      error: function() {
        alert('동기화 실패(서버 확인)');
      }
    });
  }
</script>

</body>
</html>
