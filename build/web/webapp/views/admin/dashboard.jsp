<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Admin Dashboard" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Admin Dashboard</h1>
    <div class="text-secondary">Thống kê nhanh &amp; điều hướng nghiệp vụ.</div>
  </div>
  <span class="badge text-bg-danger">Admin</span>
</div>

<div class="row g-3">
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Phòng</div>
        <div class="h4 mb-0 fw-bold">48</div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Đang thuê</div>
        <div class="h4 mb-0 fw-bold">41</div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Yêu cầu thuê</div>
        <div class="h4 mb-0 fw-bold text-warning">3</div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Hóa đơn chưa TT</div>
        <div class="h4 mb-0 fw-bold text-primary">6</div>
      </div>
    </div>
  </div>
</div>

<div class="row g-3 mt-1">
  <div class="col-12 col-lg-7">
    <div class="card">
      <div class="card-body">
        <div class="fw-semibold mb-2">Yêu cầu thuê gần đây (demo)</div>
        <div class="table-responsive">
          <table class="table align-middle mb-0">
            <thead>
              <tr>
                <th>Mã</th>
                <th>Phòng</th>
                <th>Sinh viên</th>
                <th>Ngày</th>
                <th class="text-end"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>#REQ-203</td>
                <td>P12</td>
                <td>Nguyễn Văn A</td>
                <td>18/03/2026</td>
                <td class="text-end">
                  <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/webapp/views/admin/request-approval.jsp">Duyệt</a>
                </td>
              </tr>
              <tr>
                <td>#REQ-202</td>
                <td>P08</td>
                <td>Trần Thị B</td>
                <td>17/03/2026</td>
                <td class="text-end">
                  <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/webapp/views/admin/request-approval.jsp">Duyệt</a>
                </td>
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
        <div class="fw-semibold mb-2">Tác vụ nhanh</div>
        <div class="d-grid gap-2">
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/rooms">Quản lý phòng</a>
          <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/webapp/views/admin/billing.jsp">Nhập điện/nước</a>
          <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/webapp/views/admin/tenant-management.jsp">Quản lý người thuê</a>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

