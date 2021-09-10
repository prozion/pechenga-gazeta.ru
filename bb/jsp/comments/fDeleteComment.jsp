<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<!-- <spoilsql:update dataSource="${datasource_var}">
	delete from pna_comments where id = ?
	<spoilsql:param value="${param.id}" />
</spoilsql:update>-->

<sql:update dataSource="${datasrc}">
	update pna_comments
	set _status = ? where id = ?
	<sql:param value="binned" />
	<sql:param value="${param.id}" />
</sql:update>

<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
	<jsp:param name="mode" value="active" />	
	<jsp:param name="id" value="" />		
</jsp:forward>

