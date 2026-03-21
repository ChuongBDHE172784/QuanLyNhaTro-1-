<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Quản lý sự cố" scope="request" />
<jsp:include page="/webapp/views/common/header.jsp" />

<h1 class="h4 fw-bold mb-3">Báo cáo sự cố từ sinh viên</h1>

<div class="card app-card">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
          <tr>
            <th>Mã</th>
            <th>Sinh viên</th>
            <th>Tiêu đề</th>
            <th>Mức độ</th>
            <th>Trạng thái</th>
            <th class="text-end">Cập nhật</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${reports}">
            <tr>
              <td>#RPT-<c:out value="${r.id}" /></td>
              <td><c:out value="${r.studentName}" /></td>
              <td><c:out value="${r.title}" /></td>
              <td><span class="badge text-bg-warning"><c:out value="${r.priority}" /></span></td>
              <td><span class="badge text-bg-secondary"><c:out value="${r.status}" /></span></td>
              <td class="text-end">
                <form class="d-inline" method="post" action="${pageContext.request.contextPath}/admin/reports">
                  <input type="hidden" name="reportId" value="${r.id}" />
                  <input type="hidden" name="status" value="IN_PROGRESS" />
                  <button class="btn btn-sm btn-outline-primary">Đang xử lý</button>
                </form>
                <form class="d-inline ms-1" method="post" action="${pageContext.request.contextPath}/admin/reports">
                  <input type="hidden" name="reportId" value="${r.id}" />
                  <input type="hidden" name="status" value="RESOLVED" />
                  <button class="btn btn-sm btn-success">Hoàn tất</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<jsp:include page="/webapp/views/common/footer.jsp" />
