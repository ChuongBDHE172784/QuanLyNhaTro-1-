<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Đăng nhập" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="row justify-content-center">
  <div class="col-12 col-md-8 col-lg-5">
    <div class="card app-card">
      <div class="card-body p-4">
        <h1 class="h4 fw-bold mb-1">Đăng nhập</h1>
        <p class="text-secondary mb-4">Đăng nhập để thuê phòng và quản lý hóa đơn.</p>

        <c:if test="${not empty requestScope.error}">
          <div class="alert alert-danger" role="alert">
            <c:out value="${requestScope.error}" />
          </div>
        </c:if>

        <c:if test="${param.registered == '1'}">
          <div class="alert alert-success" role="alert">
            Đăng ký thành công. Vui lòng đăng nhập.
          </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="post" class="needs-validation" novalidate>
          <div class="mb-3">
            <label class="form-label" for="email">Email</label>
            <input class="form-control" type="email" id="email" name="email" placeholder="sv@example.com" required />
            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
          </div>

          <div class="mb-3">
            <label class="form-label" for="password">Mật khẩu</label>
            <input class="form-control" type="password" id="password" name="password" placeholder="••••••••" required />
            <div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
          </div>

          <button class="btn btn-primary w-100" type="submit">Đăng nhập</button>
        </form>

        <hr class="my-4" />
        <div class="small text-secondary">
          Chưa có tài khoản?
          <a class="text-decoration-none" href="${pageContext.request.contextPath}/auth/register">Đăng ký</a>
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

