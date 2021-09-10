<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<c:set var="date" value="${param.input_issue}" scope="page" />
<c:set var="title" value="${param.input_title}" scope="page" />
<c:set var="ref" value="${param.input_url}" scope="page" />

<sql:update dataSource="${datasrc}">
		insert into pna_videos(issue, title, url, _status) values(?, ?, ?, ?)
		<sql:param value="${date}" />
		<sql:param value="${title}" />
		<sql:param value="${ref}" />
		<sql:param value="active" />
</sql:update>


<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
</jsp:forward>
