<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Đăng ký thuê phòng" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<c:set var="roomId" value="${empty param.roomId ? '' : param.roomId}" />

<div class="row justify-content-center">
  <div class="col-12 col-lg-8">
    <div class="card app-card">
      <div class="card-body p-4">
        <h1 class="h4 fw-bold mb-1">Đăng ký thuê phòng</h1>
        <p class="text-secondary mb-4">
          Phòng: <strong>P<c:out value="${roomId}" /></strong>
        </p>

        <form action="${pageContext.request.contextPath}/student/requests/create" method="post" class="row g-3 needs-validation" novalidate>
          <input type="hidden" name="roomId" value="${roomId}" />
          <div class="col-12 col-md-6">
            <label class="form-label" for="moveInDate">Ngày dự kiến chuyển đến</label>
            <input class="form-control" type="date" id="moveInDate" name="moveInDate" required />
            <div class="invalid-feedback">Vui lòng chọn ngày vào ở.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="duration">Thời hạn (tháng)</label>
            <select class="form-select" id="duration" name="duration" required>
              <option value="" selected disabled>Chọn...</option>
              <option>3</option>
              <option>6</option>
              <option>12</option>
            </select>
            <div class="invalid-feedback">Vui lòng chọn thời hạn.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="peopleCount">Số người ở</label>
            <input class="form-control" type="number" min="1" max="20" id="peopleCount" name="peopleCount" required />
            <div class="invalid-feedback">Vui lòng nhập số người ở.</div>
          </div>

          <div class="col-12">
            <label class="form-label" for="note">Ghi chú</label>
            <textarea class="form-control" id="note" name="note" maxlength="1000" rows="3" placeholder="Ví dụ: muốn xem phòng cuối tuần..."></textarea>
          </div>

          <div class="col-12 d-grid">
            <button class="btn btn-primary" type="submit">Gửi yêu cầu thuê</button>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>

<script>
  (function () {
    "use strict";
    const dateInput = document.getElementById("moveInDate");
    if (dateInput) {
      const today = new Date().toISOString().split("T")[0];
      dateInput.min = today;
    }
    const forms = document.querySelectorAll(".needs-validation");
    Array.from(forms).forEach((form) => {
      form.addEventListener(
        "submit",
        (event) => {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add("was-validated");
        },
        false
      );
    });
  })();
</script>

<jsp:include page="/webapp/views/common/footer.jsp" />

