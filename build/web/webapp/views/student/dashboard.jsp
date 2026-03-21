<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Student Dashboard" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Dashboard</h1>
    <div class="text-secondary">Tổng quan nhanh: phòng đang thuê, hóa đơn, hỗ trợ.</div>
  </div>
  <div class="d-flex gap-2">
    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/rooms">Xem phòng</a>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/student/reports">Gửi hỗ trợ</a>
  </div>
</div>

<div class="row g-3">
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Phòng đang thuê</div>
        <div class="h5 mb-0 fw-bold">
          <c:choose>
            <c:when test="${not empty activeContract}">
              <c:out value="${activeContract.roomCode}" /> (<c:out value="${activeContract.area}" />)
            </c:when>
            <c:otherwise>Chưa có</c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Tiền phòng / tháng</div>
        <div class="h5 mb-0 fw-bold text-primary">
          <c:choose>
            <c:when test="${not empty activeContract}">
              <fmt:formatNumber value="${activeContract.priceMonth}" type="number" groupingUsed="true" />đ
            </c:when>
            <c:otherwise>0đ</c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4">
    <div class="card">
      <div class="card-body">
        <div class="text-secondary small">Yêu cầu hỗ trợ</div>
        <div class="h5 mb-0 fw-bold"><c:out value="${empty openSupportCount ? 0 : openSupportCount}" /> đang xử lý</div>
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
          <a class="small text-decoration-none" href="${pageContext.request.contextPath}/student/invoices">Xem tất cả</a>
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
              <c:choose>
                <c:when test="${empty contracts}">
                  <tr>
                    <td colspan="4" class="text-center text-secondary">Chưa có dữ liệu hợp đồng.</td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="c" items="${contracts}" varStatus="st">
                    <c:if test="${st.index < 2}">
                      <tr>
                        <td>#CT-<c:out value="${c.contractId}" /></td>
                        <td><c:out value="${c.startDate}" /></td>
                        <td class="text-end fw-semibold"><fmt:formatNumber value="${c.priceMonth}" type="number" groupingUsed="true" />đ</td>
                        <td>
                          <span class="badge ${c.status == 'ACTIVE' ? 'text-bg-warning' : 'text-bg-success'}">
                            <c:out value="${c.status == 'ACTIVE' ? 'Chưa thanh toán' : 'Đã thanh toán'}" />
                          </span>
                        </td>
                      </tr>
                    </c:if>
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
        <div class="fw-semibold mb-2">Thông tin hợp đồng</div>
        <c:choose>
          <c:when test="${not empty activeContract}">
            <div class="small text-secondary">Mã hợp đồng: #CT-<c:out value="${activeContract.contractId}" /></div>
            <div class="small text-secondary">Ngày bắt đầu: <c:out value="${activeContract.startDate}" /></div>
            <div class="small text-secondary">Trạng thái: <c:out value="${activeContract.contractStatus}" /></div>
          </c:when>
          <c:otherwise>
            <div class="small text-secondary">Chưa có hợp đồng đang hiệu lực.</div>
          </c:otherwise>
        </c:choose>
        <hr />
        <a class="btn btn-outline-primary w-100" href="${pageContext.request.contextPath}/student/profile">Cập nhật hồ sơ</a>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

