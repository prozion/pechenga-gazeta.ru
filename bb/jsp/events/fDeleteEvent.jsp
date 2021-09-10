<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<sql:update dataSource="${datasource_var}">
	delete from pna_events where id = ?
	<sql:param value="${param.id}" />
</sql:update>

<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
	<jsp:param name="mode" value="active" />	
	<jsp:param name="id" value="" />		
</jsp:forward>

