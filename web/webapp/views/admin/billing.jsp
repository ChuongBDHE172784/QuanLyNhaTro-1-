<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Quản lý hóa đơn & dịch vụ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Hóa đơn &amp; Dịch vụ</h1>
    <div class="text-secondary">Danh sách chi phí theo hợp đồng hiện có.</div>
  </div>
</div>

<div class="card mb-3">
  <div class="card-body">
    <div class="small text-secondary">Dữ liệu lấy từ Contracts + Room (tiền điện/nước chưa có bảng riêng nên mặc định 0).</div>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Contract ID</th>
            <th>Phòng</th>
            <th>Sinh viên</th>
            <th class="text-end">Tiền phòng</th>
            <th class="text-end">Điện</th>
            <th class="text-end">Nước</th>
            <th class="text-end">Tổng</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty billingRows}">
              <tr>
                <td colspan="8" class="text-center text-secondary py-4">Chưa có dữ liệu hợp đồng để tính tiền.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="b" items="${billingRows}">
                <tr>
                  <td>#CT-<c:out value="${b.contractId}" /></td>
                  <td><c:out value="${b.roomCode}" /></td>
                  <td><c:out value="${b.studentName}" /></td>
                  <td class="text-end"><fmt:formatNumber value="${b.roomRent}" type="number" groupingUsed="true" />đ</td>
                  <td class="text-end">0đ</td>
                  <td class="text-end">0đ</td>
                  <td class="text-end fw-semibold text-primary"><fmt:formatNumber value="${b.totalAmount}" type="number" groupingUsed="true" />đ</td>
                  <td>
                    <span class="badge ${b.status == 'PAID' ? 'text-bg-success' : 'text-bg-warning'}">
                      <c:out value="${b.status == 'PAID' ? 'Đã thanh toán' : 'Chưa thanh toán'}" />
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-3">
      <div class="small text-secondary">Tổng: <strong><c:out value="${fn:length(billingRows)}" /></strong> bản ghi</div>
      <ui:pagination page="1" totalPages="1" baseUrl="${pageContext.request.contextPath}/admin/billing" />
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

