<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Quản lý người thuê" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Quản lý người thuê</h1>
    <div class="text-secondary">Danh sách sinh viên đang thuê.</div>
  </div>
  <button class="btn btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#tenantModal">
    Thêm người thuê
  </button>
</div>

<div class="card">
  <div class="card-body">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center app-table-toolbar mb-3">
      <div class="input-group" style="max-width: 460px;">
        <span class="input-group-text">Tìm</span>
        <input class="form-control" placeholder="Tên/MSSV/Phòng..." />
        <button class="btn btn-outline-secondary" type="button">Lọc</button>
      </div>
      <div class="d-flex gap-2">
        <select class="form-select" style="max-width: 220px;">
          <option selected>Trạng thái: Tất cả</option>
          <option>Đang thuê</option>
          <option>Hết hạn</option>
        </select>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>MSSV</th>
            <th>Họ tên</th>
            <th>Phòng</th>
            <th>Ngày vào</th>
            <th>Trạng thái</th>
            <th class="text-end"></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="i" begin="1" end="10">
            <tr>
              <td>SE0<c:out value="${1000 + i}" /></td>
              <td class="fw-semibold">Sinh viên <c:out value="${i}" /></td>
              <td>P<c:out value="${(i % 12) + 1}" /></td>
              <td>0<c:out value="${(i % 9) + 1}" />/03/2026</td>
              <td><span class="badge text-bg-success">Đang thuê</span></td>
              <td class="text-end">
                <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#tenantModal">Sửa</button>
                <button class="btn btn-sm btn-outline-danger" type="button">Kết thúc</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-3">
      <div class="small text-secondary">Hiển thị 1–10 / 41</div>
      <ui:pagination page="1" totalPages="5" baseUrl="${pageContext.request.contextPath}/webapp/views/admin/tenant-management.jsp" />
    </div>
  </div>
</div>

<!-- Modal: add/edit tenant -->
<div class="modal fade" id="tenantModal" tabindex="-1" aria-labelledby="tenantModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5" id="tenantModalLabel">Thêm/Sửa người thuê</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form class="row g-3">
          <div class="col-12 col-md-6">
            <label class="form-label">Họ tên</label>
            <input class="form-control" placeholder="Nguyễn Văn A" />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">MSSV</label>
            <input class="form-control" placeholder="SE000001" />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Phòng</label>
            <select class="form-select">
              <option selected>P12</option>
              <option>P08</option>
              <option>P03</option>
            </select>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Ngày vào</label>
            <input class="form-control" type="date" />
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        <button type="button" class="btn btn-primary">Lưu</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

