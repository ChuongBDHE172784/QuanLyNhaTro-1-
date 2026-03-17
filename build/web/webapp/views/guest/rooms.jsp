<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Danh sách phòng trọ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Danh sách phòng trọ</h1>
    <div class="text-secondary">Chọn phòng phù hợp và xem chi tiết.</div>
  </div>
  <form class="d-flex gap-2" action="#" method="get" role="search">
    <input class="form-control" name="q" placeholder="Tìm theo tên/khu vực..." />
    <button class="btn btn-outline-primary" type="submit">Tìm</button>
  </form>
</div>

<div class="row g-3">
  <c:forEach var="i" begin="1" end="8">
    <div class="col-12 col-md-6 col-lg-4">
      <div class="card h-100">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-start gap-2">
            <div>
              <div class="fw-semibold">Phòng P<c:out value="${i}" /></div>
              <div class="small text-secondary">Khu A • 18m² • Tầng <c:out value="${(i % 3) + 1}" /></div>
            </div>
            <span class="badge text-bg-success">Còn trống</span>
          </div>
          <hr />
          <div class="d-flex justify-content-between">
            <div class="text-secondary small">Giá/tháng</div>
            <div class="fw-bold text-primary">2,500,000đ</div>
          </div>
        </div>
        <div class="card-footer bg-white border-0 pt-0 pb-3">
          <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/webapp/views/guest/room-details.jsp?id=${i}">
            Xem chi tiết
          </a>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

<nav class="mt-4" aria-label="Room pagination">
  <ul class="pagination justify-content-center">
    <li class="page-item disabled"><a class="page-link" href="#">Prev</a></li>
    <li class="page-item active"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">Next</a></li>
  </ul>
</nav>

<jsp:include page="/webapp/views/common/footer.jsp" />

