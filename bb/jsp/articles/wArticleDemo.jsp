<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>
<%@ include file="../inc/constants.inc" %>

<%
		String basepath = "../upload/articles/h/"; 
		pageContext.setAttribute("basepath", basepath);
%>


<html>
<head> 
	<link href="styles/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>

<sql:query var="article" dataSource="${datasrc}">
	select a.id, a.title, a.issue, a.picture, a.text, b.number, b.date, c.login
	from pna_articles as a, pna_issues as b, pna_editors as c
	where 
	a.issue = b.id
	and a.contributor = c.id
	and a.issue = b.id
	and a.id = ?
	limit 1
	<sql:param value="${param.id}" />
</sql:query>

<c:forEach var="r" items="${article.rows}">
<div class="demo">
	<c:out value="${r.text}" escapeXml="false" />
</div>
</c:forEach>
</body>
</html>
