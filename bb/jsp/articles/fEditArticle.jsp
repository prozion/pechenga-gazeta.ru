<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>


<!--<c:set var="table_name" value="nikel_pages" />-->

<jsp:useBean id="valueDate" class="java.util.Date" /> 

<c:set var="title" value="${param.input_title}" scope="page" />
<c:set var="text" value="${param.input_text}" scope="page" />
<c:set var="authors" value="${paramValues.input_authors}" scope="page" />
<c:set var="rubric" value="${param.input_rubric}" scope="page" />
<c:set var="date" value="${param.input_date}" scope="page" />
<c:set var="places" value="${paramValues.input_places}" scope="page" />
<c:set var="type" value="${param.input_type}" scope="page" />

<!-- define issue corresponded to the selected date -->
<sql:query var="issues" dataSource="${datasrc}">
	select id from pna_issues where date = ? and _status='active'
	<sql:param value="${date}" /> 
</sql:query>

<c:set var="issue_id" value="-1" />
<!-- if inputed date is different from any issue date, choose the latest issue date -->
<c:choose>
	<c:when test="${issues.rowCount < 1}">
		<sql:query var="nearest_issue" dataSource="${datasrc}">
			select id from (select max(date) as var from (select * from pna_issues where ? > date and _status='active') as a) as b, pna_issues where date=var and _status='active'
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

<sql:transaction dataSource="${datasrc}">
	<sql:update>
		update pna_articles set title = ?, text = ?, issue = ?, rubric = ?, _type = ? where id = ?
		<sql:param value="${title}" />
		<sql:param value="${text}" />		
		<sql:param value="${issue_id}" />
		<sql:param value="${rubric}" />
		<sql:param value="${type}" />	
		<sql:param value="${param.id}" />					
	</sql:update>
	
	<!-- refresh link table articles-authors -->
	<sql:update>	
		delete from pna_articles_authors where article_id = ?
		<sql:param value="${param.id}" />
	</sql:update>
			
	<c:forEach var="i" items="${authors}">
		<sql:update>	
			insert into pna_articles_authors(article_id, author_id) values(?, ?)
			<sql:param value="${param.id}" />
			<sql:param value="${i}" />
		</sql:update>		
	</c:forEach>
	
	<!-- refresh link table articles-places -->
	<sql:update>	
		delete from pna_articles_places where article_id = ?
		<sql:param value="${param.id}" />
	</sql:update>
			
	<c:forEach var="i" items="${places}">
		<sql:update>	
			insert into pna_articles_places(article_id, place_id) values(?, ?)
			<sql:param value="${param.id}" />
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
