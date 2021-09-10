<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../../inc/taglibs.inc" %>
<%@ include file="../../inc/sql.inc" %>


<c:set var="name" value="${param.name}" />
<c:set var="number" value="${param.number}" />


<% int n = Integer.decode((String)pageContext.findAttribute("number")); %>

<sql:query var="latest_articles" dataSource="${datasrc}">
	select a.id, a.title, d.date, d.number as nn 
	from pna_articles as a, pna_authors as b, pna_articles_authors as c, pna_issues as d 
	where
		b.alias = ?
		and c.article_id = a.id
		and c.author_id = b.id
		and a.issue = d.id
		and year(d.date) = ? order by d.date desc
		limit <%= n %>
	<sql:param value="${name}" />
	<sql:param value="${year}" />	
</sql:query>

<% int c=0; %>
<c:forEach var="r" items="${latest_articles.rows}">
<% pageContext.setAttribute("c", ++c); %>
	<div>
		<c:url var="url" value="">	
			<c:param name="view" value="article" />
			<c:param name="id" value="${r.id}" />
		</c:url>
			<span class="title"><a href="<c:out value='${url}' />"><c:if test="${c==1}"><b></c:if><c:out value="${r.title}" /><c:if test="${c==1}"></b></c:if></a></span>
			<span class="date">[<fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />]</span>			
					<sql:query var="cn" dataSource="${datasrc}">
						select count(*) as num
						from pna_comments
						where article_id = ? and _status = ?
						<sql:param value="${r.id}" />
						<sql:param value="active" />
					</sql:query>
			<c:forEach var="rrr" items="${cn.rows}">
			<c:if test="${rrr.num > 0}">
				<img src="ff/img/pointers/mini_pen.gif" />&nbsp;<span class="comments_number">(<b><c:out value="${rrr.num}" /></b>)</span>
			</c:if>
			</c:forEach>
	</div>
</c:forEach>
