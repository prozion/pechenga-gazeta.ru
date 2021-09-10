<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<!--<c:set var="table_name" value="nikel_pages" />-->

<c:set var="date" value="${param.input_date}" scope="page" />
<c:set var="number" value="${param.input_number}" scope="page" />

<sql:update dataSource="${datasrc}">
	update pna_issues
	set date = ?, number = ? where id = ?
	<sql:param value="${date}" />
	<sql:param value="${number}" />
	<sql:param value="${param.id}" />
</sql:update> 

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
</jsp:forward>
