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
      <div class="d-flex align-items-center gap-2">
        <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/student/dashboard">Back</a>
        <span class="badge text-bg-primary">Student</span>
      </div>
    </div>

    <c:if test="${param.updated == '1'}">
      <div class="alert alert-success" role="alert">Cập nhật hồ sơ thành công.</div>
    </c:if>
    <c:if test="${param.error == 'phone'}">
      <div class="alert alert-danger" role="alert">Số điện thoại không hợp lệ (9-11 chữ số).</div>
    </c:if>
    <c:if test="${param.error == 'cccd'}">
      <div class="alert alert-danger" role="alert">CCCD không hợp lệ (9-12 chữ số).</div>
    </c:if>
    <c:if test="${param.error == 'avatar'}">
      <div class="alert alert-danger" role="alert">Ảnh cá nhân (URL) tối đa 500 ký tự.</div>
    </c:if>

    <div class="card app-card">
      <div class="card-body p-4">
        <div class="row g-3">
          <div class="col-12 col-md-6">
            <label class="form-label" for="fullName">Họ và tên</label>
            <input class="form-control" id="fullName" value="<c:out value='${sessionScope.user.fullName}' />" readonly />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="email">Email</label>
            <input class="form-control" id="email" value="<c:out value='${sessionScope.user.email}' />" readonly />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="phoneView">Số điện thoại</label>
            <input class="form-control" id="phoneView" value="<c:out value='${profile.phone}' />" readonly />
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="cccdView">CCCD</label>
            <input class="form-control" id="cccdView" value="<c:out value='${profile.cccd}' />" readonly />
          </div>
          <div class="col-12">
            <label class="form-label" for="avatarView">Ảnh cá nhân (URL)</label>
            <input class="form-control" id="avatarView" value="<c:out value='${profile.avatarUrl}' />" readonly />
          </div>
          <div class="col-12 d-grid d-md-flex justify-content-md-end">
            <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#profileUpdateModal">Cập nhật</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="profileUpdateModal" tabindex="-1" aria-labelledby="profileUpdateModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5" id="profileUpdateModalLabel">Cập nhật hồ sơ</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/student/profile" method="post" class="needs-validation" novalidate>
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label" for="phone">Số điện thoại</label>
            <input class="form-control" id="phone" name="phone" value="<c:out value='${profile.phone}' />" pattern="[0-9]{9,11}" maxlength="11" />
            <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (9-11 chữ số).</div>
          </div>
          <div class="mb-3">
            <label class="form-label" for="cccd">CCCD</label>
            <input class="form-control" id="cccd" name="cccd" value="<c:out value='${profile.cccd}' />" pattern="[0-9]{9,12}" maxlength="12" />
            <div class="invalid-feedback">Vui lòng nhập CCCD hợp lệ (9-12 chữ số).</div>
          </div>
          <div>
            <label class="form-label" for="avatarUrl">Ảnh cá nhân (URL)</label>
            <input class="form-control" id="avatarUrl" name="avatarUrl" value="<c:out value='${profile.avatarUrl}' />" maxlength="500" />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Đóng</button>
          <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
        </div>
      </form>
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

    const hasError =
      "${param.error}" === "phone" ||
      "${param.error}" === "cccd" ||
      "${param.error}" === "avatar";
    if (hasError) {
      const modalEl = document.getElementById("profileUpdateModal");
      if (modalEl) {
        const modal = new bootstrap.Modal(modalEl);
        modal.show();
      }
    }
  })();
</script>

<jsp:include page="/webapp/views/common/footer.jsp" />

