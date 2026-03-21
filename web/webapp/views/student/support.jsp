<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Gửi yêu cầu hỗ trợ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="row justify-content-center">
  <div class="col-12 col-lg-9">
    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
      <div>
        <h1 class="h4 fw-bold mb-1">Yêu cầu hỗ trợ</h1>
        <div class="text-secondary">Báo sự cố, yêu cầu sửa chữa, góp ý.</div>
      </div>
      <span class="badge text-bg-primary">Student</span>
    </div>

    <div class="card app-card">
      <div class="card-body p-4">
        <form action="${pageContext.request.contextPath}/student/reports" method="post" class="row g-3 needs-validation" novalidate>
          <div class="col-12 col-md-6">
            <label class="form-label" for="priority">Mức độ</label>
            <select class="form-select" id="priority" name="priority" required>
              <option value="" selected disabled>Chọn...</option>
              <option value="LOW">Thấp</option>
              <option value="MEDIUM">Trung bình</option>
              <option value="HIGH">Cao</option>
            </select>
            <div class="invalid-feedback">Vui lòng chọn mức độ.</div>
          </div>

          <div class="col-12">
            <label class="form-label" for="title">Tiêu đề</label>
            <input class="form-control" id="title" name="title" maxlength="255" placeholder="Ví dụ: Rò rỉ nước nhà vệ sinh" required />
            <div class="invalid-feedback">Vui lòng nhập tiêu đề.</div>
          </div>

          <div class="col-12">
            <label class="form-label" for="desc">Mô tả</label>
            <textarea class="form-control" id="desc" name="desc" maxlength="1000" rows="4" placeholder="Mô tả chi tiết tình trạng..." required></textarea>
            <div class="invalid-feedback">Vui lòng nhập mô tả.</div>
          </div>

          <div class="col-12 d-grid">
            <button class="btn btn-primary" type="submit">Gửi yêu cầu</button>
          </div>
        </form>

        <hr class="my-4" />
        <div class="fw-semibold mb-2">Lịch sử báo cáo</div>
        <div class="table-responsive">
          <table class="table align-middle mb-0">
            <thead>
              <tr>
                <th>Mã</th>
                <th>Tiêu đề</th>
                <th>Mức độ</th>
                <th>Trạng thái</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${reports}">
                <tr>
                  <td>#RPT-<c:out value="${r.id}" /></td>
                  <td><c:out value="${r.title}" /></td>
                  <td><c:out value="${r.priority}" /></td>
                  <td><span class="badge text-bg-secondary"><c:out value="${r.status}" /></span></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
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

