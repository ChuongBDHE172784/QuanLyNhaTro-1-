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
        <div class="h4 mb-0 fw-bold"><c:out value="${empty roomCount ? 0 : roomCount}" /></div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Đang thuê</div>
        <div class="h4 mb-0 fw-bold"><c:out value="${empty rentedCount ? 0 : rentedCount}" /></div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Yêu cầu thuê</div>
        <div class="h4 mb-0 fw-bold text-warning"><c:out value="${empty pendingRequestCount ? 0 : pendingRequestCount}" /></div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-3">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Sự cố chưa xử lý</div>
        <div class="h4 mb-0 fw-bold text-primary"><c:out value="${empty unresolvedReportCount ? 0 : unresolvedReportCount}" /></div>
      </div>
    </div>
  </div>
</div>

<div class="row g-3 mt-1">
  <div class="col-12 col-lg-7">
    <div class="card">
      <div class="card-body">
        <div class="fw-semibold mb-2">Yêu cầu thuê gần đây</div>
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
              <c:choose>
                <c:when test="${empty recentRequests}">
                  <tr>
                    <td colspan="5" class="text-center text-secondary">Chưa có yêu cầu nào.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="r" items="${recentRequests}">
                    <tr>
                      <td>#REQ-<c:out value="${r.id}" /></td>
                      <td><c:out value="${r.roomCode}" /></td>
                      <td><c:out value="${r.studentName}" /></td>
                      <td><c:out value="${r.moveInDate}" /></td>
                      <td class="text-end">
                        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/requests">Duyệt</a>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
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
          <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/billing">Nhập điện/nước</a>
          <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/tenants">Quản lý người thuê</a>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

