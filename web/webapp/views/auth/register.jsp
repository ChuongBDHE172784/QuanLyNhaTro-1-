<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Đăng ký" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="row justify-content-center">
  <div class="col-12 col-md-10 col-lg-7">
    <div class="card app-card">
      <div class="card-body p-4">
        <h1 class="h4 fw-bold mb-1">Đăng ký tài khoản</h1>
        <p class="text-secondary mb-4">Tạo tài khoản để thuê phòng và theo dõi hóa đơn.</p>

        <c:if test="${not empty requestScope.error}">
          <div class="alert alert-danger" role="alert">
            <c:out value="${requestScope.error}" />
          </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="post" class="row g-3 needs-validation" novalidate>
          <div class="col-12 col-md-6">
            <label class="form-label" for="fullName">Họ và tên</label>
            <input class="form-control" id="fullName" name="fullName" value="<c:out value='${requestScope.fullName}' />" required />
            <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="phone">Số điện thoại</label>
            <input class="form-control" id="phone" name="phone" value="<c:out value='${requestScope.phone}' />" inputmode="tel" placeholder="09xxxxxxxx" required />
            <div class="invalid-feedback">Vui lòng nhập số điện thoại.</div>
          </div>

          <div class="col-12">
            <label class="form-label" for="email">Email</label>
            <input class="form-control" type="email" id="email" name="email" value="<c:out value='${requestScope.email}' />" placeholder="sv@example.com" required />
            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
          </div>

          <div class="col-12 col-md-6">
            <label class="form-label" for="password">Mật khẩu</label>
            <input class="form-control" type="password" id="password" name="password" required minlength="6" />
            <div class="invalid-feedback">Mật khẩu tối thiểu 6 ký tự.</div>
          </div>
          <div class="col-12 col-md-6">
            <label class="form-label" for="confirm">Nhập lại mật khẩu</label>
            <input class="form-control" type="password" id="confirm" name="confirm" required minlength="6" />
            <div class="invalid-feedback">Vui lòng nhập lại mật khẩu.</div>
          </div>

          <div class="col-12">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="agree" required />
              <label class="form-check-label" for="agree">
                Tôi đồng ý với <a class="text-decoration-none" href="#">điều khoản</a>.
              </label>
              <div class="invalid-feedback">Bạn cần đồng ý điều khoản.</div>
            </div>
          </div>

          <div class="col-12 d-grid">
            <button class="btn btn-primary" type="submit">Tạo tài khoản</button>
          </div>
        </form>

        <hr class="my-4" />
        <div class="small text-secondary">
          Đã có tài khoản?
          <a class="text-decoration-none" href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a>
        </div>
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

