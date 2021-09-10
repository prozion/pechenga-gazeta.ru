<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<!--<c:set var="table_name" value="nikel_pages" />-->

<c:set var="text" value="${param.input_text}" scope="page" />

<sql:update dataSource="${datasrc}">
	update pna_comments
	set text = ? where id = ?
	<sql:param value="${text}" />
	<sql:param value="${param.id}" />
</sql:update>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
</jsp:forward>
