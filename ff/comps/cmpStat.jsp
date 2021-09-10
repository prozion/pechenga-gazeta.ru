<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<sql:query var="art" dataSource="${datasrc}">
	select count(*) as articles 
	from pna_articles
	where _status='active'
</sql:query>

<c:forEach var="r" items="${art.rows}">
	<c:set var="narticles" value="${r.articles}" scope="page" />
</c:forEach>

<sql:query var="iss" dataSource="${datasrc}">
	select count(*) as issues 
	from pna_issues
</sql:query>

<c:forEach var="r" items="${iss.rows}">
	<c:set var="nissues" value="${r.issues}" scope="page" />
</c:forEach>

<div class="statbar">
	<span>Выпусков: </span><span><b><c:out value="${nissues}" /></b> | </span> 
	<span>Cтатей: </span><span><b><c:out value="${narticles}" /></b></span>
</div>
