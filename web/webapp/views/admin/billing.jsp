<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="pageTitle" value="Quản lý hóa đơn & dịch vụ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Hóa đơn &amp; Dịch vụ</h1>
    <div class="text-secondary">Nhập chỉ số điện/nước, xuất hóa đơn.</div>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#meterModal">Nhập số điện/nước</button>
    <button class="btn btn-primary" type="button">Xuất hóa đơn</button>
  </div>
</div>

<div class="card mb-3">
  <div class="card-body">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center app-table-toolbar">
      <div class="input-group" style="max-width: 520px;">
        <span class="input-group-text">Tìm</span>
        <input class="form-control" placeholder="Mã hóa đơn / phòng / tháng..." />
        <button class="btn btn-outline-secondary" type="button">Lọc</button>
      </div>
      <div class="d-flex gap-2">
        <select class="form-select" style="max-width: 220px;">
          <option selected>Tháng: 03/2026</option>
          <option>02/2026</option>
          <option>01/2026</option>
        </select>
      </div>
    </div>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Phòng</th>
            <th>Tháng</th>
            <th class="text-end">Tiền phòng</th>
            <th class="text-end">Điện</th>
            <th class="text-end">Nước</th>
            <th class="text-end">Tổng</th>
            <th>Trạng thái</th>
            <th class="text-end"></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="i" begin="1" end="10">
            <tr>
              <td>#INV-240<c:out value="${i}" /></td>
              <td>P<c:out value="${(i % 12) + 1}" /></td>
              <td>03/2026</td>
              <td class="text-end">2,500,000đ</td>
              <td class="text-end">450,000đ</td>
              <td class="text-end">200,000đ</td>
              <td class="text-end fw-semibold text-primary">3,150,000đ</td>
              <td>
                <span class="badge ${i % 3 == 0 ? 'text-bg-success' : 'text-bg-warning'}">
                  <c:out value="${i % 3 == 0 ? 'Đã thanh toán' : 'Chưa thanh toán'}" />
                </span>
              </td>
              <td class="text-end">
                <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#meterModal">Nhập chỉ số</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-3">
      <div class="small text-secondary">Hiển thị 1–10 / 60</div>
      <ui:pagination page="1" totalPages="6" baseUrl="${pageContext.request.contextPath}/webapp/views/admin/billing.jsp" />
    </div>
  </div>
</div>

<!-- Modal: enter meter indexes -->
<div class="modal fade" id="meterModal" tabindex="-1" aria-labelledby="meterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5" id="meterModalLabel">Nhập chỉ số điện/nước</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form class="row g-3">
          <div class="col-12 col-md-6">
            <label class="form-label">Phòng</label>
            <select class="form-select">
              <option selected>P12</option>
              <option>P08</option>
              <option>P03</option>
            </select>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Tháng</label>
            <input class="form-control" placeholder="03/2026" />
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label">Điện - Chỉ số đầu</label>
            <input class="form-control" type="number" min="0" placeholder="1200" />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Điện - Chỉ số cuối</label>
            <input class="form-control" type="number" min="0" placeholder="1385" />
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label">Nước - Chỉ số đầu</label>
            <input class="form-control" type="number" min="0" placeholder="305" />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label">Nước - Chỉ số cuối</label>
            <input class="form-control" type="number" min="0" placeholder="325" />
          </div>
        </form>

        <div class="alert alert-info mt-3 mb-0">
          (Demo) Khi làm backend: lưu meter → tính tiền điện/nước → xuất hóa đơn.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        <button type="button" class="btn btn-primary">Lưu chỉ số</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

