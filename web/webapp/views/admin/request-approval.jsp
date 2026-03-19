<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Duyệt yêu cầu thuê" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Duyệt yêu cầu thuê phòng</h1>
    <div class="text-secondary">Xác nhận hoặc từ chối yêu cầu thuê (từ DB).</div>
  </div>
  <span class="badge text-bg-danger">Admin</span>
</div>

<div class="card app-card">
  <div class="card-body">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center app-table-toolbar mb-3">
      <div class="input-group" style="max-width: 520px;">
        <span class="input-group-text">Tìm</span>
        <input class="form-control" placeholder="Mã yêu cầu / phòng / tên SV..." />
        <button class="btn btn-outline-secondary" type="button">Lọc</button>
      </div>
      <div class="d-flex gap-2">
        <select class="form-select" style="max-width: 220px;">
          <option selected>Trạng thái: Chờ duyệt</option>
          <option>Đã duyệt</option>
          <option>Đã từ chối</option>
        </select>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Phòng</th>
            <th>Sinh viên</th>
            <th>Ngày gửi</th>
            <th>Ghi chú</th>
            <th class="text-end"></th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty requests}">
              <tr>
                <td colspan="6" class="text-center text-secondary py-4">Không có yêu cầu chờ duyệt.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="r" items="${requests}">
                <tr>
                  <td>#REQ-<c:out value="${r.id}" /></td>
                  <td class="fw-semibold"><c:out value="${r.roomCode}" /></td>
                  <td><c:out value="${r.studentName}" /></td>
                  <td><c:out value="${r.startDate}" /></td>
                  <td class="text-secondary"><c:out value="${r.note}" /></td>
                  <td class="text-end">
                    <form class="d-inline" action="${pageContext.request.contextPath}/admin/requests/approve" method="post">
                      <input type="hidden" name="requestId" value="${r.id}" />
                      <button class="btn btn-sm btn-success" type="submit">Duyệt</button>
                    </form>
                    <form class="d-inline ms-2" action="${pageContext.request.contextPath}/admin/requests/reject" method="post">
                      <input type="hidden" name="requestId" value="${r.id}" />
                      <button class="btn btn-sm btn-outline-danger" type="submit">Từ chối</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-3">
      <div class="small text-secondary">
        Tổng: <strong><c:out value="${fn:length(requests)}" /></strong> yêu cầu chờ duyệt
      </div>
      <ui:pagination page="1" totalPages="1" baseUrl="${pageContext.request.contextPath}/admin/requests" />
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

