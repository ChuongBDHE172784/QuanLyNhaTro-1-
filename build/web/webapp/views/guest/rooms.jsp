<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Danh sách phòng trọ" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-3">
  <div>
    <h1 class="h4 fw-bold mb-1">Danh sách phòng trọ</h1>
    <div class="text-secondary">Chọn phòng phù hợp và xem chi tiết.</div>
  </div>
  <form class="d-flex gap-2" action="${pageContext.request.contextPath}/rooms" method="get" role="search">
    <input class="form-control" name="q" placeholder="Tìm theo tên/khu vực..." value="<c:out value='${q}' />" />
    <button class="btn btn-outline-primary" type="submit">Tìm</button>
  </form>
</div>

<c:choose>
  <c:when test="${empty rooms}">
    <div class="alert alert-secondary mb-0">Không tìm thấy phòng phù hợp.</div>
  </c:when>
  <c:otherwise>
    <div class="row g-3">
      <c:forEach var="r" items="${rooms}">
        <div class="col-12 col-md-6 col-lg-4">
          <div class="card h-100 app-room-card">
            <div class="card-body p-4">
              <div class="d-flex justify-content-between align-items-start gap-2">
                <div>
                  <div class="fw-semibold"><c:out value="${r.code}" /></div>
                  <div class="small text-secondary"><c:out value="${r.area}" /></div>
                </div>
                <c:choose>
                  <c:when test="${r.status == 'AVAILABLE'}">
                    <span class="badge text-bg-success app-status-badge">Còn trống</span>
                  </c:when>
                  <c:when test="${r.status == 'RENTED'}">
                    <span class="badge text-bg-secondary app-status-badge">Đã thuê</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge text-bg-warning app-status-badge">Bảo trì</span>
                  </c:otherwise>
                </c:choose>
              </div>
              <hr />
              <div class="d-flex justify-content-between">
                <div class="text-secondary small">Giá/tháng</div>
                <div class="fw-bold text-primary">
                  <fmt:formatNumber value="${r.priceMonth}" type="number" groupingUsed="true" />đ
                </div>
              </div>
            </div>
            <div class="card-footer bg-white border-0 pt-0 pb-4">
              <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/rooms/detail?id=${r.id}">
                Xem chi tiết
              </a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:otherwise>
</c:choose>

<jsp:include page="/webapp/views/common/footer.jsp" />

