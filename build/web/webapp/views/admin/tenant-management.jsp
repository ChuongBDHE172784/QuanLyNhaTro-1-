<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Quản lý người thuê" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Quản lý người thuê</h1>
    <div class="text-secondary">Danh sách sinh viên đang thuê.</div>
  </div>
  <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/requests">
    Duyệt yêu cầu thuê
  </a>
</div>

<div class="card">
  <div class="card-body">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center app-table-toolbar mb-3">
      <div class="small text-secondary">Danh sách lấy từ bảng Contracts + User + Room.</div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Contract ID</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Phòng</th>
            <th>Ngày bắt đầu</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty tenants}">
              <tr>
                <td colspan="6" class="text-center text-secondary py-4">Chưa có dữ liệu người thuê.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="t" items="${tenants}">
                <tr>
                  <td>#CT-<c:out value="${t.contractId}" /></td>
                  <td class="fw-semibold"><c:out value="${t.fullName}" /></td>
                  <td><c:out value="${t.email}" /></td>
                  <td><c:out value="${t.roomCode}" /></td>
                  <td><c:out value="${t.startDate}" /></td>
                  <td>
                    <span class="badge ${t.status == 'ACTIVE' ? 'text-bg-success' : 'text-bg-secondary'}">
                      <c:out value="${t.status}" />
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
      <div class="small text-secondary">Tổng: <strong><c:out value="${fn:length(tenants)}" /></strong> bản ghi</div>
      <ui:pagination page="1" totalPages="1" baseUrl="${pageContext.request.contextPath}/admin/tenants" />
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

