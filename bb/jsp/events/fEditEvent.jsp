<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<c:set var="date" value="${param.input_date}" scope="page" />
<c:set var="title" value="${param.input_title}" scope="page" />
<c:set var="ref" value="${param.input_ref}" scope="page" />

<sql:update dataSource="${datasrc}">
	update pna_events
	set date = ?, title = ?, ref = ? where id = ?
	<sql:param value="${date}" />
	<sql:param value="${title}" />
	<sql:param value="${ref}" />
	<sql:param value="${param.id}" />
</sql:update>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
</jsp:forward>
