<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Chi tiết phòng" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<c:set var="roomId" value="${empty param.id ? 1 : param.id}" />

<nav aria-label="breadcrumb" class="mb-3">
  <ol class="breadcrumb mb-0">
    <li class="breadcrumb-item"><a class="text-decoration-none" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
    <li class="breadcrumb-item"><a class="text-decoration-none" href="${pageContext.request.contextPath}/webapp/views/guest/rooms.jsp">Danh sách phòng</a></li>
    <li class="breadcrumb-item active" aria-current="page">Phòng P<c:out value="${roomId}" /></li>
  </ol>
</nav>

<div class="row g-3">
  <div class="col-12 col-lg-7">
    <div class="card">
      <div class="card-body">
        <div class="d-flex align-items-start justify-content-between gap-2">
          <div>
            <h1 class="h4 fw-bold mb-1">Phòng P<c:out value="${roomId}" /></h1>
            <div class="text-secondary">Khu A • 18m² • Full nội thất cơ bản</div>
          </div>
          <span class="badge text-bg-success align-self-start">Còn trống</span>
        </div>
        <hr />
        <div class="row g-2">
          <div class="col-6">
            <div class="small text-secondary">Giá/tháng</div>
            <div class="fw-bold text-primary">2,500,000đ</div>
          </div>
          <div class="col-6">
            <div class="small text-secondary">Đặt cọc</div>
            <div class="fw-semibold">1 tháng</div>
          </div>
          <div class="col-6">
            <div class="small text-secondary">Điện</div>
            <div class="fw-semibold">3,500đ/kWh</div>
          </div>
          <div class="col-6">
            <div class="small text-secondary">Nước</div>
            <div class="fw-semibold">15,000đ/m³</div>
          </div>
        </div>
        <hr />
        <div class="small text-secondary">
          Ghi chú: Nội dung demo UI. Khi làm backend, dữ liệu sẽ lấy từ DB (SQL Server) và render bằng JSTL.
        </div>
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
        <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/webapp/views/student/room-booking.jsp?roomId=${roomId}">
          Thuê ngay
        </a>
        <div class="small text-secondary mt-3">
          (Demo) Luồng thật: Student chưa login → redirect `/auth/login`.
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

