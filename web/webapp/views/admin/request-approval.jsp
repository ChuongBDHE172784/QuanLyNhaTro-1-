<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Duyệt yêu cầu thuê" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Duyệt yêu cầu thuê phòng</h1>
    <div class="text-secondary">Xác nhận hoặc từ chối yêu cầu thuê (UI demo).</div>
  </div>
  <span class="badge text-bg-danger">Admin</span>
</div>

<div class="card">
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
          <c:forEach var="i" begin="1" end="8">
            <tr>
              <td>#REQ-20<c:out value="${200 + i}" /></td>
              <td>P<c:out value="${(i % 12) + 1}" /></td>
              <td class="fw-semibold">Sinh viên <c:out value="${i}" /></td>
              <td>18/03/2026</td>
              <td class="text-secondary">Muốn vào ở từ 01/04</td>
              <td class="text-end">
                <button class="btn btn-sm btn-success" type="button">Duyệt</button>
                <button class="btn btn-sm btn-outline-danger" type="button">Từ chối</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-3">
      <div class="small text-secondary">Hiển thị 1–8 / 22</div>
      <ui:pagination page="1" totalPages="3" baseUrl="${pageContext.request.contextPath}/webapp/views/admin/request-approval.jsp" />
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

