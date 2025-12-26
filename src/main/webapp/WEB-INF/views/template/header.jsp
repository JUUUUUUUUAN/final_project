<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav
  class="layout-navbar  navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
  id="layout-navbar"
>
  <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">

   <!-- ⏰ 날짜 / 시간 -->
    <div class="navbar-nav align-items-center header-datetime">
      <span class="date">9월 24일</span>
      <span class="time">15:03</span>
    </div>

    <!-- 🟣 출근 / 퇴근 -->
    <div class="navbar-nav align-items-center header-actions">
      <button class="btn btn-sm btn-outline-success">출근</button>
      <button class="btn btn-sm btn-outline-secondary">퇴근</button>
    </div>
    
    <!-- 오른쪽 영역 -->
    <ul class="navbar-nav flex-row align-items-center">
      <!-- 🔔 알림 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle hide-arrow" href="#" data-bs-toggle="dropdown">
          <i class="bx bx-bell bx-sm"></i>
          <c:if test="${notificationCount > 0}">
            <span class="badge bg-danger rounded-pill badge-notifications">
              ${notificationCount}
            </span>
          </c:if>
        </a>
        <ul class="dropdown-menu dropdown-menu-end">
          <li class="dropdown-item">미지급 결재 요청</li>
          <li class="dropdown-item">발주 승인 대기</li>
        </ul>
      </li>

      <!-- 👤 사용자 -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle hide-arrow" href="#" data-bs-toggle="dropdown">
          <span class="fw-semibold">
            <c:out value="${loginUserName != null ? loginUserName : '홍길동'}"/>
          </span>
        </a>
        <ul class="dropdown-menu dropdown-menu-end">
          <li>
            <a class="dropdown-item" href="/logout">로그아웃</a>
          </li>
        </ul>
      </li>

    </ul>
  </div>
</nav>
