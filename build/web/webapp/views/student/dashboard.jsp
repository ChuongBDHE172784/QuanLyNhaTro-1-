<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Student Dashboard" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Dashboard (Sinh viên)</h1>
    <div class="text-secondary">Tổng quan nhanh: phòng đang thuê, hóa đơn, hỗ trợ.</div>
  </div>
  <div class="d-flex gap-2">
    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/webapp/views/guest/rooms.jsp">Xem phòng</a>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/webapp/views/student/support.jsp">Gửi hỗ trợ</a>
  </div>
</div>

<div class="row g-3">
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Phòng đang thuê</div>
        <div class="h5 mb-0 fw-bold">P12 (Khu A)</div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Hóa đơn tháng này</div>
        <div class="h5 mb-0 fw-bold text-primary">3,150,000đ</div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Yêu cầu hỗ trợ</div>
        <div class="h5 mb-0 fw-bold">1 đang xử lý</div>
      </div>
    </div>
  </div>
</div>

<div class="row g-3 mt-1">
  <div class="col-12 col-lg-7">
    <div class="card">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-2">
          <div class="fw-semibold">Hóa đơn gần đây</div>
          <a class="small text-decoration-none" href="${pageContext.request.contextPath}/webapp/views/student/invoices.jsp">Xem tất cả</a>
        </div>
        <div class="table-responsive">
          <table class="table align-middle mb-0">
            <thead>
              <tr>
                <th>Mã</th>
                <th>Tháng</th>
                <th class="text-end">Tổng</th>
                <th>Trạng thái</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>#INV-2403</td>
                <td>03/2026</td>
                <td class="text-end fw-semibold">3,150,000đ</td>
                <td><span class="badge text-bg-warning">Chưa thanh toán</span></td>
              </tr>
              <tr>
                <td>#INV-2402</td>
                <td>02/2026</td>
                <td class="text-end fw-semibold">2,980,000đ</td>
                <td><span class="badge text-bg-success">Đã thanh toán</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-lg-5">
    <div class="card app-card">
      <div class="card-body">
        <div class="fw-semibold mb-2">Thông tin hợp đồng (demo)</div>
        <div class="small text-secondary">Ngày bắt đầu: 01/01/2026</div>
        <div class="small text-secondary">Chu kỳ thanh toán: hàng tháng</div>
        <hr />
        <a class="btn btn-outline-primary w-100" href="${pageContext.request.contextPath}/webapp/views/student/profile.jsp">Cập nhật hồ sơ</a>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

