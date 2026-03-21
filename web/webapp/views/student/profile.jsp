<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Hồ sơ cá nhân" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="row justify-content-center">
  <div class="col-12 col-lg-9">
    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
      <div>
        <h1 class="h4 fw-bold mb-1">Hồ sơ cá nhân</h1>
        <div class="text-secondary">Cập nhật thông tin liên hệ và giấy tờ.</div>
      </div>
      <span class="badge text-bg-primary">Student</span>
    </div>

    <div class="card app-card">
      <div class="card-body p-4">
        <form action="${pageContext.request.contextPath}/student/profile" method="post" class="row g-3 needs-validation" novalidate>
          <div class="col-12 col-md-6">
            <label class="form-label" for="fullName">Họ và tên</label>
            <input class="form-control" id="fullName" name="fullName" value="<c:out value='${sessionScope.user.fullName}' />" readonly />
            <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="email">Email</label>
            <input class="form-control" id="email" name="email" value="<c:out value='${sessionScope.user.email}' />" readonly />
            <div class="invalid-feedback">Vui lòng nhập email.</div>
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label" for="phone">Số điện thoại</label>
            <input class="form-control" id="phone" name="phone" value="<c:out value='${profile.phone}' />" />
            <div class="invalid-feedback">Vui lòng nhập số điện thoại.</div>
          </div>
          <div class="col-12">
            <label class="form-label" for="cccd">CCCD</label>
            <input class="form-control" id="cccd" name="cccd" value="<c:out value='${profile.cccd}' />" />
          </div>
          <div class="col-12">
            <label class="form-label" for="avatarUrl">Ảnh cá nhân (URL)</label>
            <input class="form-control" id="avatarUrl" name="avatarUrl" value="<c:out value='${profile.avatarUrl}' />" />
          </div>

          <div class="col-12 d-grid d-md-flex justify-content-md-end gap-2">
            <button class="btn btn-outline-secondary" type="reset">Hoàn tác</button>
            <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  (function () {
    "use strict";
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

