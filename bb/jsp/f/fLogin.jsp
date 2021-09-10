<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<sql:query var="user" dataSource="${datasource_var}">
	select * from pna_editors where login = ? and password = ?
	<sql:param value="${param.usr}" />
	<sql:param value="${param.pwd}" />
</sql:query>

<c:choose>
	<c:when test="${user.rowCount == 1}">		
		<c:set var="r" value="true" scope="page" />
	</c:when>
	<c:when test="${user.rowCount > 1}">		
		<c:set var="r" value="false" scope="page" />
	</c:when>	
	<c:when test="${user.rowCount < 1}">		
		<c:set var="r" value="false" scope="page" />
	</c:when>	
	<c:otherwise>
		<c:set var="r" value="false" scope="page" />
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${r == true}">
		<c:set var="current_user" value="${param.usr}" scope="session" />
	</c:when>
	<c:otherwise />	
</c:choose>

<!-- backend/f/fLogin.jsp -> backend/index.jsp -->
<!-- cancel op = 'login' to avoid loop  -->
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="" />
</jsp:forward>
