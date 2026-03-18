<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Chi tiết phòng" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<nav aria-label="breadcrumb" class="mb-3">
  <ol class="breadcrumb mb-0">
    <li class="breadcrumb-item"><a class="text-decoration-none" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
    <li class="breadcrumb-item"><a class="text-decoration-none" href="${pageContext.request.contextPath}/rooms">Danh sách phòng</a></li>
    <li class="breadcrumb-item active" aria-current="page"><c:out value="${room.code}" /></li>
  </ol>
</nav>

<div class="row g-3">
  <div class="col-12 col-lg-7">
    <div class="card">
      <div class="card-body">
        <div class="d-flex align-items-start justify-content-between gap-2">
          <div>
            <h1 class="h4 fw-bold mb-1"><c:out value="${room.code}" /></h1>
            <div class="text-secondary"><c:out value="${room.area}" /></div>
          </div>
          <c:choose>
            <c:when test="${room.status == 'AVAILABLE'}">
              <span class="badge text-bg-success align-self-start">Còn trống</span>
            </c:when>
            <c:when test="${room.status == 'RENTED'}">
              <span class="badge text-bg-secondary align-self-start">Đã thuê</span>
            </c:when>
            <c:otherwise>
              <span class="badge text-bg-warning align-self-start">Bảo trì</span>
            </c:otherwise>
          </c:choose>
        </div>
        <hr />
        <div class="row g-2">
          <div class="col-6">
            <div class="small text-secondary">Giá/tháng</div>
            <div class="fw-bold text-primary">
              <fmt:formatNumber value="${room.priceMonth}" type="number" groupingUsed="true" />đ
            </div>
          </div>
        </div>
        <c:if test="${not empty room.description}">
          <hr />
          <div class="text-secondary"><c:out value="${room.description}" /></div>
        </c:if>
      </div>
    </div>
  </div>

  <div class="col-12 col-lg-5">
    <div class="card app-card">
      <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center">
          <div class="fw-semibold">Thuê phòng</div>
          <span class="badge text-bg-light">Bước 1</span>
        </div>
        <hr />
        <p class="text-secondary mb-3">
          Nhấn “Thuê ngay” để điền form đăng ký thuê. Nếu chưa đăng nhập, hệ thống sẽ chuyển về trang đăng nhập.
        </p>
        <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/webapp/views/student/room-booking.jsp?roomId=${room.id}">
          Thuê ngay
        </a>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

