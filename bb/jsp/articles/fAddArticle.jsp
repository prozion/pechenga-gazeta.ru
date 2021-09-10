<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>


<!--<c:set var="table_name" value="nikel_pages" />-->

<jsp:useBean id="valueDate" class="java.util.Date" /> 
<c:set var="_created"> 
	<fmt:formatDate value="${valueDate}" type="both" pattern="yyyyMMddHHmmss" />
</c:set>

<c:set var="title" value="${param.input_title}" scope="page" />
<c:set var="text" value="${param.input_text}" scope="page" />
<c:set var="authors" value="${paramValues.input_authors}" scope="page" />
<c:set var="rubric" value="${param.input_rubric}" scope="page" />
<c:set var="date" value="${param.input_date}" scope="page" />
<c:set var="places" value="${paramValues.input_places}" scope="page" />
<c:set var="type" value="${param.input_type}" scope="page" />

<%
System.out.println("" + pageContext.findAttribute("type"));
%>

<c:choose>
	<c:when test="${issue == null}"> 	
		<!-- check if article is from issue, or is an additional material -->
		<c:if test="${_type == 'is_in_issue'}">
			<!-- issue is undefined - we have to define issue by inputed date -->
			<!-- define issue corresponded to the selected date: -->
			<sql:query var="issues" dataSource="${datasrc}">
				select id from pna_issues where date = ?
				<sql:param value="${date}" />
			</sql:query>
		
			<c:set var="issue_id" value="0" />
			<!-- if inputed date is different from any issue date, choose the latest issue date: -->
			<c:choose>
				<c:when test="${issues.rowCount < 1}">
					<sql:query var="nearest_issue" dataSource="${datasrc}">
						select id from (select max(date) as var from (select * from pna_issues where ? > date) as a) as b, pna_issues where date=var
						<sql:param value="${date}" />
					</sql:query>
					<c:forEach var="row" items="${nearest_issue.rows}">
						<c:set var="issue_id" value="${row.id}" />
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="row" items="${issues.rows}">
						<c:set var="issue_id" value="${row.id}" />
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${type == 'out_of_issue'}">
			<c:set var="issue_id" value="-1" />	
		</c:if>
	</c:when>
	<c:when test="${issue != null}">
	<!-- issue is defined, so we use it directly -->
		<c:set var="issue_id" value="${issue}" />
	</c:when>
</c:choose>

<c:if test="${rubric == null || rubric == 'null'}">
	<sql:query var="norubric" dataSource="${datasrc}">
		select id from pna_rubrics
		where alias = 'none'
	</sql:query>	
	<c:forEach var="r" items="${norubric.rows}">
		<c:set var="rubric" value="${r.id}" />
	</c:forEach>
</c:if>

<!-- define record in editors table corresponded to the current user -->
<sql:query var="editors" dataSource="${datasrc}">
	select id from pna_editors where login = ?
	<sql:param value="${current_user}" />
</sql:query>

<c:set var="contributor_id" value="0" />
<c:forEach var="row" items="${editors.rows}">
	<c:set var="contributor_id" value="${row.id}" />
</c:forEach>


<sql:transaction dataSource="${datasrc}">
	<sql:update>
		insert into pna_articles(_created, title, text, contributor, issue, rubric, _type) values(?, ?, ?, ?, ?, ?, ?)
		<sql:param value="${_created}" />
		<sql:param value="${title}" />
		<sql:param value="${text}" />		
		<sql:param value="${contributor_id}" />
		<sql:param value="${issue_id}" />		
		<sql:param value="${rubric}" />
		<sql:param value="${type}" />
	</sql:update>
	
	<sql:query var="find_id">
		select id from pna_articles where _created = ?
		<sql:param value="${_created}" />
	</sql:query>
	
	<c:set var="cur_id" value="0" />
	<c:forEach var="r" items="${find_id.rows}">
		<c:set var="cur_id" value="${r.id}" />
	</c:forEach>
	
	<c:forEach var="req_author_id" items="${authors}">
		<sql:query var="check_author">
			select id from pna_authors where id = ?
			<sql:param value="${req_author_id}" />
		</sql:query>
		
		<c:set var="author_id" value="0" />
		<c:forEach var="checked_author_id" items="${check_author.rows}">
			<c:set var="author_id" value="${checked_author_id.id}" />
		</c:forEach>
		
		<sql:update>	
			insert into pna_articles_authors(article_id, author_id) values(?, ?)
			<sql:param value="${cur_id}" />
			<sql:param value="${author_id}" />
		</sql:update>
	</c:forEach>
	
	<c:forEach var="i" items="${places}">
		<sql:update>	
			insert into pna_articles_places(article_id, place_id) values(?, ?)
			<sql:param value="${cur_id}" />
			<sql:param value="${i}" />
		</sql:update>		
	</c:forEach>	
</sql:transaction>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
	<jsp:param name="cat" value="articles" />	
	<jsp:param name="mode" value="active" />	
</jsp:forward>
