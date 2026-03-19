<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Quản lý phòng" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Quản lý phòng trọ</h1>
    <div class="text-secondary">CRUD phòng (từ DB).</div>
  </div>
  <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#roomModal">
    Thêm mới
  </button>
</div>

<div class="card">
  <div class="card-body">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center app-table-toolbar mb-3">
      <form class="input-group" style="max-width: 420px;" action="${pageContext.request.contextPath}/admin/rooms" method="get">
        <span class="input-group-text">Tìm</span>
        <input class="form-control" name="q" value="${empty requestScope.q ? '' : requestScope.q}" placeholder="Mã phòng/khu..." />
        <button class="btn btn-outline-secondary" type="submit">Lọc</button>
      </form>
      <div class="d-flex gap-2">
        <select class="form-select" style="max-width: 180px;">
          <option selected>Sắp xếp: Mới nhất</option>
          <option>Giá tăng dần</option>
          <option>Giá giảm dần</option>
        </select>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Tên phòng</th>
            <th>Khu</th>
            <th class="text-end">Giá</th>
            <th>Trạng thái</th>
            <th class="text-end"></th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty requestScope.rooms}">
              <tr>
                <td colspan="6" class="text-center text-secondary py-4">
                  Chưa có phòng nào trong database.
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="r" items="${requestScope.rooms}">
                <tr>
                  <td><c:out value="${r.id}" /></td>
                  <td class="fw-semibold"><c:out value="${r.code}" /></td>
                  <td><c:out value="${r.area}" /></td>
                  <td class="text-end">
                    <fmt:formatNumber value="${r.priceMonth}" type="number" groupingUsed="true" />đ
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${r.status == 'MAINTENANCE'}">
                        <span class="badge text-bg-secondary app-status-badge">Bảo trì</span>
                      </c:when>
                      <c:when test="${r.status == 'RENTED'}">
                        <span class="badge text-bg-warning app-status-badge">Đã thuê</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge text-bg-success app-status-badge">Còn trống</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-end">
                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/rooms/edit?id=${r.id}">Sửa</a>
                    <form class="d-inline" action="${pageContext.request.contextPath}/admin/rooms/delete" method="post" onsubmit="return confirm('Xóa phòng này?');">
                      <input type="hidden" name="id" value="${r.id}" />
                      <button class="btn btn-sm btn-outline-danger" type="submit">Xóa</button>
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
        Tổng: <strong><c:out value="${fn:length(requestScope.rooms)}" /></strong> phòng
      </div>
      <ui:pagination page="1" totalPages="1" baseUrl="${pageContext.request.contextPath}/admin/rooms" query="${requestScope.q}" />
    </div>
  </div>
</div>

<!-- Modal: add/edit room -->
<div class="modal fade" id="roomModal" tabindex="-1" aria-labelledby="roomModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5" id="roomModalLabel">Thêm/Sửa phòng</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <c:set var="editing" value="${not empty requestScope.room}" />
        <form class="row g-3" action="${pageContext.request.contextPath}${editing ? '/admin/rooms/update' : '/admin/rooms/create'}" method="post">
          <c:if test="${editing}">
            <input type="hidden" name="id" value="${room.id}" />
          </c:if>
          <div class="col-12 col-md-6">
            <label class="form-label">Tên phòng</label>
            <input class="form-control" name="code" maxlength="50" value="${editing ? room.code : ''}" placeholder="P12" required />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Khu</label>
            <input class="form-control" name="area" maxlength="255" value="${editing ? room.area : ''}" placeholder="Khu A" required />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Giá/tháng</label>
            <input class="form-control" name="priceMonth" value="${editing ? room.priceMonth : ''}" type="number" min="0" step="10000" placeholder="2500000" required />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Trạng thái</label>
            <select class="form-select" name="status" required>
              <option value="AVAILABLE" ${editing && room.status == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
              <option value="RENTED" ${editing && room.status == 'RENTED' ? 'selected' : ''}>RENTED</option>
              <option value="MAINTENANCE" ${editing && room.status == 'MAINTENANCE' ? 'selected' : ''}>MAINTENANCE</option>
            </select>
          </div>
          <div class="col-12">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" maxlength="1000" rows="3" placeholder="Mô tả phòng...">${editing ? room.description : ''}</textarea>
          </div>
          <div class="col-12 d-grid">
            <button class="btn btn-primary" type="submit">Lưu</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<c:if test="${not empty requestScope.room}">
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const modal = new bootstrap.Modal(document.getElementById("roomModal"));
      modal.show();
    });
  </script>
</c:if>

<jsp:include page="/webapp/views/common/footer.jsp" />

