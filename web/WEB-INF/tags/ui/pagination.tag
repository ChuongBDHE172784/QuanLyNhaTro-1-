<%@ tag description="Pagination UI (Bootstrap 5)" pageEncoding="UTF-8"%>
<%@ attribute name="page" required="false" type="java.lang.Integer" %>
<%@ attribute name="totalPages" required="false" type="java.lang.Integer" %>
<%@ attribute name="baseUrl" required="false" type="java.lang.String" %>
<%@ attribute name="query" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="p" value="${empty page ? 1 : page}" />
<c:set var="tp" value="${empty totalPages ? 1 : totalPages}" />
<c:set var="url" value="${empty baseUrl ? '#' : baseUrl}" />

<c:if test="${tp > 1}">
  <nav aria-label="Pagination">
    <ul class="pagination mb-0">
      <c:set var="q" value="${empty query ? '' : query}" />
      <c:set var="qPrefix" value="${empty q ? '' : '&q='}${fn:escapeXml(q)}" />

      <li class="page-item ${p <= 1 ? 'disabled' : ''}">
        <a class="page-link" href="${url}?page=${p-1}${qPrefix}" tabindex="-1" aria-disabled="${p <= 1}">
          Prev
        </a>
      </li>

      <c:set var="start" value="${p-2 < 1 ? 1 : p-2}" />
      <c:set var="end" value="${p+2 > tp ? tp : p+2}" />

      <c:forEach var="i" begin="${start}" end="${end}">
        <li class="page-item ${i == p ? 'active' : ''}">
          <a class="page-link" href="${url}?page=${i}${qPrefix}">${i}</a>
        </li>
      </c:forEach>

      <li class="page-item ${p >= tp ? 'disabled' : ''}">
        <a class="page-link" href="${url}?page=${p+1}${qPrefix}" aria-disabled="${p >= tp}">
          Next
        </a>
      </li>
    </ul>
  </nav>
</c:if>

