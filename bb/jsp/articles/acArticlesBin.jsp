<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%
		String basepath = "../upload/articles/h/"; 
		pageContext.setAttribute("basepath", basepath);
%>


<div id="header1">
	<span id="title">Статьи - Корзина</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<div id="header2">

	<div class="button">
		<c:url value="" var="url" scope="page">
			<c:param name="op" value="view" />
			<c:param name="cat" value="articles" />			 
			<c:param name="mode" value="active" />
		</c:url>
		<a href="<c:out value='${url}' />">Статьи</a>
	</div>

</div>

<br />

<div id="body">
	<sql:query var="articles" dataSource="${datasrc}">
		select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login
		from pna_articles as a, pna_issues as b, pna_editors as c
		where 
		a.issue = b.id
		and a.contributor = c.id
		and a._status = 'binned'
		order by a._updated desc
	</sql:query>

	<div id="dataTable" style="width: 900px">
		<div class="th" style="width: 80px">Дата</div>	
		<div class="th" style="width: 80px">№ выпуска</div>		
		<div class="th" style="width: 110px">Фото</div>
		<div class="th" style="width: 150px">Заголовок</div>
		<div class="th" style="width: 100px">Авторы</div>
		<div class="th-last" style="width: 80px">Редактор</div>		
		<br />
		<c:forEach var="r" items="${articles.rows}">
			<div class="tdfh" style="width: 80px">
				<fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />
			</div>			
			<div class="tdfh" style="width: 80px">
				<c:out value="${r.number}" />
			</div>			
			<div class="tdfh" style="width: 110px">
					<c:choose>
						<c:when test="${r.picture == '' || r.picture == 'null' || r.picture == null}">
							<img src="img/stub_picture.gif" />
						</c:when>
						<c:otherwise>
							<a target="_blank" href="<c:out value='${basepath}'/><c:out value='${r.picture}'/>/m.jpg"><img src='<c:out value="${basepath}"/><c:out value="${r.picture}"/>/s.jpg' /></a>							
						</c:otherwise>
					</c:choose>
			</div>
			<div class="tdfh" style="width: 150px">
					<c:url value="" var="demo" scope="page">
						<c:param name="op" value="view" />
						<c:param name="mode" value="w_demo" />
						<c:param name="id" value="${r.id}" />									 
					</c:url>
					<a href="<c:out value='${demo}' />" target="_blank"><c:out value="${r.title}" /></a>
			</div>			
			<div class="tdfh" style="width: 100px;">
				<sql:query var="authors" dataSource="${datasrc}">
					select a.penname from pna_authors as a, pna_articles_authors as b 
where b.author_id=a.id  and b.article_id=?
					<sql:param value="${r.id}" /> 
				</sql:query>
				<c:forEach var="rr" items="${authors.rows}">
					<c:out value="${rr.penname}" /><br />
				</c:forEach>	
			</div>
			<div class="tdfh-last" style="width: 80px;">
				<c:out value="${r.login}" />
			</div>			
			<div class="toolbar">
				<c:url value="" var="restore" scope="page">
					<c:param name="op" value="restore" />
					<c:param name="cat" value="articles" />
					<c:param name="id" value="${r.id}" />									 
				</c:url>			
				<c:url value="" var="delete" scope="page">
					<c:param name="op" value="delete" />
					<c:param name="cat" value="articles" />
					<c:param name="id" value="${r.id}" />									 
				</c:url>
				<a href="<c:out value='${restore}' />" class="button"><img src="img/restore.gif"></a>			
				<a href="<c:out value='${delete}' />" class="button"><img src="img/drop.gif"></a>			
			</div>
			<br />
		</c:forEach>
	</div>	
</div>


<div id="footer">	
	<c:if test="${articles.rowCount > 20}">
		<% int c=0; %>
		<c:forEach items="${articles.rows}" step="20">
		<% c++; %>
		<span style="margin: 0px 5px 0px 0px; display: inline; float: left" ><a href=""><span style="width: 20px;"><%= ""+c %></span></a></span>
		</c:forEach>
	</c:if>
</div>
</table>
