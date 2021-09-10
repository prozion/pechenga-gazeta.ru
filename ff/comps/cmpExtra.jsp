<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<div class="calendar" style="color: #aaa; text-align: center;">
		<sql:query var="articles" dataSource="${datasrc}">
						select a.id, a._created, a.title, a.issue, a.picture, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						and a._type="out_of_issue"
						order by a._created desc
		</sql:query>
		
	<c:forEach var="r" items="${articles.rows}">
												
		<div class="title">
			<c:url value="" var="full_text" scope="page">
				<c:param name="view" value="article" />
				<c:param name="id" value="${r.id}" />									 
			</c:url>
			<span class="date">
				<fmt:formatDate value="${r._created}" pattern="dd.MM.yyyy" />:&nbsp;
			</span>
			<a href="<c:out value='${full_text}' />"><c:out value="${r.title}" /></a>
			<sql:query var="cn" dataSource="${datasrc}">
				select count(*) as num
				from pna_comments
				where article_id = ?
				<sql:param value="${r.id}" />
			</sql:query>
			<c:forEach var="rrr" items="${cn.rows}">
				<c:if test="${rrr.num > 0}">
					<span class="comments_number">(комментариев-<c:out value="${rrr.num}" />)</span>
				</c:if>
			</c:forEach>			
		</div>					
	</c:forEach>
</div>