<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../../inc/taglibs.inc" %>
<%@ include file="../../inc/sql.inc" %>


<c:set var="name" value="${param.name}" />

<sql:query var="count_of_articles" dataSource="${datasrc}">
	select count(*) as nn 
	from pna_articles as a, pna_authors as b, pna_articles_authors as c, pna_issues as d 
	where
		b.alias = ?
		and c.article_id = a.id
		and c.author_id = b.id
		and a.issue = d.id
		and year(d.date) = ? order by d.date asc
	<sql:param value="${name}" />
	<sql:param value="${year}" />	
</sql:query>

<c:forEach var="r" items="${count_of_articles.rows}">
	<c:out value="${r.nn}" />
</c:forEach>
