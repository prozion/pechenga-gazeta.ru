<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>


<!--<c:set var="table_name" value="nikel_pages" />-->

<jsp:useBean id="valueDate" class="java.util.Date" /> 
<c:set var="_created"> 
	<fmt:formatDate value="${valueDate}" type="both" pattern="yyyyMMddHHmmss" />
</c:set>

<c:set var="date" value="${param.input_date}" scope="page" />
<c:set var="number" value="${param.input_number}" scope="page" />

<sql:update dataSource="${datasrc}">
	insert into pna_issues(date, number)
	values (?, ?)
	<sql:param value="${date}" />
	<sql:param value="${number}" />
</sql:update>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
	<jsp:param name="cat" value="issues" />	
	<jsp:param name="mode" value="active" />	
</jsp:forward>
