<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<c:set var="issue" value="${param.input_issue}" scope="page" />
<c:set var="title" value="${param.input_title}" scope="page" />
<c:set var="url" value="${param.input_url}" scope="page" />

<sql:update dataSource="${datasrc}">
	update pna_videos
	set issue = ?, title = ?, url = ? where id = ?
	<sql:param value="${issue}" />
	<sql:param value="${title}" />
	<sql:param value="${url}" />
	<sql:param value="${param.id}" />
</sql:update>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
</jsp:forward>
