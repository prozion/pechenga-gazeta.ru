<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<sql:update dataSource="${datasource_var}">
	update pna_articles set _status = 'binned' where id = ?
	<sql:param value="${param.id}" />
</sql:update>

<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />	
	<jsp:param name="id" value="" />		
</jsp:forward>

