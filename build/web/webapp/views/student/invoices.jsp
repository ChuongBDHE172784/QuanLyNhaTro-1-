<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Hóa đơn" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Hóa đơn</h1>
    <div class="text-secondary">Xem danh sách hóa đơn và chi tiết điện/nước.</div>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#meterModal">
      Xem chi tiết điện/nước
    </button>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table align-middle mb-0">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Tháng</th>
            <th class="text-end">Tiền phòng</th>
            <th class="text-end">Điện + Nước</th>
            <th class="text-end">Tổng</th>
            <th>Trạng thái</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="i" begin="1" end="6">
            <tr>
              <td>#INV-24<c:out value="${10 + i}" /></td>
              <td>0<c:out value="${i}" />/2026</td>
              <td class="text-end">2,500,000đ</td>
              <td class="text-end">650,000đ</td>
              <td class="text-end fw-semibold text-primary">3,150,000đ</td>
              <td>
                <span class="badge ${i == 1 ? 'text-bg-warning' : 'text-bg-success'}">
                  <c:out value="${i == 1 ? 'Chưa thanh toán' : 'Đã thanh toán'}" />
                </span>
              </td>
              <td class="text-end">
                <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#meterModal">
                  Xem chi tiết
                </button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Modal: meter details -->
<div class="modal fade" id="meterModal" tabindex="-1" aria-labelledby="meterModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5" id="meterModalLabel">Chỉ số điện/nước</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row g-3">
          <div class="col-12 col-md-6">
            <div class="card">
              <div class="card-body">
                <div class="fw-semibold mb-2">Điện</div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Chỉ số đầu</span><span>1200</span>
                </div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Chỉ số cuối</span><span>1385</span>
                </div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Tiêu thụ</span><span class="fw-semibold">185 kWh</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-12 col-md-6">
            <div class="card">
              <div class="card-body">
                <div class="fw-semibold mb-2">Nước</div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Chỉ số đầu</span><span>305</span>
                </div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Chỉ số cuối</span><span>325</span>
                </div>
                <div class="d-flex justify-content-between">
                  <span class="text-secondary">Tiêu thụ</span><span class="fw-semibold">20 m³</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="alert alert-info mt-3 mb-0">
          (Demo) Khi làm backend: dữ liệu modal lấy theo hóa đơn được chọn.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />

