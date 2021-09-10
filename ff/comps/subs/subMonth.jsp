<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../../inc/taglibs.inc" %>
<%@ include file="../../inc/sql.inc" %>

<%
	String [] months_gen = {"", "января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"};
%>	

<c:set var="month" value="${param.month}" />
<% 
	int index = Integer.decode((String)pageContext.findAttribute("month"));
%>

<sql:query var="months" dataSource="${datasrc}">
	select date, number from pna_issues where month(date)=? and year(date) = ? and _status='active' order by date asc
	<sql:param value="${month}" />
	<sql:param value="${year}" />
</sql:query>

<c:forEach var="r" items="${months.rows}">
	<div>
		<c:url value="" var="url">
			<c:param name="i" value="${r.number}" />
		</c:url>
		<a href="<c:out value='${url}' />"><fmt:formatDate value="${r.date}" pattern="dd" /> <%= months_gen[index] %> (№<c:out value="${r.number}" />)</a>
	</div>
</c:forEach>
