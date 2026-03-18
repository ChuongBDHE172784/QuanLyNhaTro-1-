<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      </div>
    </main>

    <footer class="border-top bg-white">
      <div class="container py-3 d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 app-footer">
        <div class="small">
          © <%= java.time.Year.now() %> Nhà trọ SV — PRJ301 (Servlet/JSP)
        </div>
        <div class="small">
          <a class="text-decoration-none" href="${pageContext.request.contextPath}/home">Trang chủ</a>
          <span class="mx-2">•</span>
          <a class="text-decoration-none" href="${pageContext.request.contextPath}/rooms">Xem phòng</a>
        </div>
      </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
  </body>
</html>

