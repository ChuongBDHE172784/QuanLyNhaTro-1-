<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Trang chủ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="row g-4 align-items-center">
  <div class="col-12 col-lg-6">
    <div class="mb-2">
      <span class="badge text-bg-primary">Nhà trọ sinh viên</span>
    </div>
    <h1 class="display-6 fw-bold mb-3">Tìm phòng trọ phù hợp trong vài phút</h1>
    <p class="lead text-secondary mb-4">
      Xem phòng trống, giá thuê, tiện ích và gửi yêu cầu thuê trực tuyến.
    </p>

    <form class="row g-2" action="${pageContext.request.contextPath}/webapp/views/guest/rooms.jsp" method="get">
      <div class="col-12 col-md-7">
        <input class="form-control form-control-lg" name="q" placeholder="Tìm theo khu vực, tên phòng..." />
      </div>
      <div class="col-12 col-md-5 d-grid">
        <button class="btn btn-primary btn-lg" type="submit">Tìm phòng</button>
      </div>
    </form>

    <div class="d-flex flex-wrap gap-2 mt-3">
      <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/webapp/views/guest/rooms.jsp">Xem tất cả phòng</a>
      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/webapp/views/auth/login.jsp">Đăng nhập</a>
    </div>
  </div>

  <div class="col-12 col-lg-6">
    <div class="card app-card">
      <div class="card-body p-4">
        <div class="d-flex align-items-center justify-content-between">
          <div>
            <div class="h5 mb-1 fw-bold">Thông tin nổi bật</div>
            <div class="small text-secondary">Dữ liệu demo cho mục đích trình bày UI.</div>
          </div>
          <span class="badge text-bg-light">Cập nhật hôm nay</span>
        </div>
        <hr />

        <div class="row g-3">
          <div class="col-12 col-md-4">
            <div class="border rounded-3 p-3 h-100">
              <div class="small text-secondary">Phòng trống</div>
              <div class="h4 mb-0 fw-bold text-success">12</div>
            </div>
          </div>
          <div class="col-12 col-md-4">
            <div class="border rounded-3 p-3 h-100">
              <div class="small text-secondary">Giá từ</div>
              <div class="h4 mb-0 fw-bold">2.3tr</div>
            </div>
          </div>
          <div class="col-12 col-md-4">
            <div class="border rounded-3 p-3 h-100">
              <div class="small text-secondary">Khu nhà</div>
              <div class="h4 mb-0 fw-bold">A–C</div>
            </div>
          </div>
        </div>

        <div class="alert alert-primary mt-3 mb-0">
          Mẹo: Bấm “Xem tất cả phòng” để xem danh sách &amp; chi tiết từng phòng.
        </div>
      </div>
    </div>
  </div>
</div>

<div class="mt-4">
  <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
    <h2 class="h5 fw-bold mb-0">Phòng nổi bật</h2>
    <a class="small text-decoration-none" href="${pageContext.request.contextPath}/webapp/views/guest/rooms.jsp">Xem thêm</a>
  </div>

  <div class="row g-3">
    <c:forEach var="i" begin="1" end="3">
      <div class="col-12 col-md-6 col-lg-4">
        <div class="card h-100">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-start gap-2">
              <div>
                <div class="fw-semibold">Phòng P<c:out value="${i}" /></div>
                <div class="small text-secondary">Khu A • 18m² • Gần trường</div>
              </div>
              <span class="badge text-bg-success">Còn trống</span>
            </div>
            <hr />
            <div class="d-flex justify-content-between">
              <div class="text-secondary small">Giá/tháng</div>
              <div class="fw-bold text-primary">2,500,000đ</div>
            </div>
          </div>
          <div class="card-footer bg-white border-0 pt-0 pb-3">
            <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/webapp/views/guest/room-details.jsp?id=${i}">
              Xem chi tiết
            </a>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

