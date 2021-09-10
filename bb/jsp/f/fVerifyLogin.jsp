<%@ page contentType="text/html;charset=utf-8" %>

<%@ taglib uri='jstl/c' prefix='c' %>
<%@ taglib uri='jstl/sql' prefix='sql' %>


<sql:setDataSource url="jdbc:mysql://localhost:3306/20081501_1" user="b20081501_1" password="iKJhrnMJ" driver="org.gjt.mm.mysql.Driver" var="datasource_var" />

<sql:query var="user" dataSource="${datasource_var}">
	select * from pna_editors where login = ?
	<sql:param value="${current_user}" /> 
</sql:query>

<c:choose> 
	<c:when test="${user.rowCount == 1}">		
		<c:set var="res" value="true" scope="request" />
	</c:when>
	<c:when test="${user.rowCount > 1}">		
		<c:set var="res" value="false" scope="request" />
	</c:when>	
	<c:when test="${user.rowCount < 1}">		
		<c:set var="res" value="false" scope="request" />
	</c:when>	
	<c:otherwise>
		<c:set var="res" value="false" scope="request" />
	</c:otherwise>
</c:choose>
