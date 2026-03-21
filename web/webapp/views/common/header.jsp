<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="role" value="${empty sessionScope.user ? 'GUEST' : sessionScope.user.role}" />

<!doctype html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>
      <c:out value="${empty requestScope.pageTitle ? 'Quản lý nhà trọ' : requestScope.pageTitle}" />
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css" />
  </head>
  <body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
      <div class="container">
        <a class="navbar-brand app-navbar-brand fw-semibold" href="${pageContext.request.contextPath}/home">
          Nhà trọ Sinh Viên
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#appNav" aria-controls="appNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="appNav">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/rooms">Xem phòng</a>
            </li>

            <c:if test="${role == 'STUDENT'}">
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/webapp/views/student/dashboard.jsp">Dashboard</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/webapp/views/student/invoices.jsp">Hóa đơn</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/reports">Hỗ trợ</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/profile">Thông tin</a>
              </li>
            </c:if>

            <c:if test="${role == 'ADMIN'}">
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/webapp/views/admin/dashboard.jsp">Admin</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/rooms">Phòng trọ</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/webapp/views/admin/tenant-management.jsp">Người thuê</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/webapp/views/admin/billing.jsp">Hóa đơn &amp; Dịch vụ</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/requests">Yêu cầu</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">Sự cố</a>
              </li>
            </c:if>
          </ul>

          <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">
            <c:if test="${role == 'GUEST'}">
              <li class="nav-item">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/auth/login">
                  Đăng nhập
                </a>
              </li>
              <li class="nav-item">
                <a class="btn btn-light btn-sm ms-lg-2 mt-2 mt-lg-0" href="${pageContext.request.contextPath}/webapp/views/auth/register.jsp">
                  Đăng ký
                </a>
              </li>
            </c:if>

            <c:if test="${role != 'GUEST'}">
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <c:out value="${empty sessionScope.user.fullName ? 'Tài khoản' : sessionScope.user.fullName}" />
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li>
                    <span class="dropdown-item-text small text-muted">
                      Vai trò: <strong><c:out value="${role}" /></strong>
                    </span>
                  </li>
                  <li><hr class="dropdown-divider" /></li>
                  <c:if test="${role == 'STUDENT'}">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/profile">Hồ sơ</a></li>
                  </c:if>
                  <c:if test="${role == 'ADMIN'}">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/webapp/views/admin/dashboard.jsp">Admin Dashboard</a></li>
                  </c:if>
                  <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                </ul>
              </li>
            </c:if>
          </ul>
        </div>
      </div>
    </nav>

    <main class="flex-grow-1 py-4">
      <div class="container">

