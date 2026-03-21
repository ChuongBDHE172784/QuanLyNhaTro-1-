<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Hóa đơn" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Hóa đơn</h1>
    <div class="text-secondary">Xem danh sách tiền phòng theo hợp đồng thực tế.</div>
  </div>
  <div class="d-flex gap-2">
    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/student/dashboard">Về Dashboard</a>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table align-middle mb-0">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Phòng</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th class="text-end">Tiền phòng / tháng</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty contracts}">
              <tr>
                <td colspan="6" class="text-center text-secondary py-4">Chưa có dữ liệu hợp đồng.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="c" items="${contracts}">
                <tr>
                  <td>#CT-<c:out value="${c.contractId}" /></td>
                  <td><c:out value="${c.roomCode}" /></td>
                  <td><c:out value="${c.startDate}" /></td>
                  <td><c:out value="${c.endDate}" /></td>
                  <td class="text-end"><fmt:formatNumber value="${c.priceMonth}" type="number" groupingUsed="true" />đ</td>
                  <td>
                    <span class="badge ${c.status == 'ACTIVE' ? 'text-bg-warning' : 'text-bg-success'}">
                      <c:out value="${c.status}" />
                    </span>
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

<jsp:include page="/webapp/views/common/footer.jsp" />

