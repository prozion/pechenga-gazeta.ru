<%@ page contentType="text/html;charset=utf-8"%>

<%@ include file="../inc/header.inc"%>
<%@ include file="../inc/sql.inc"%>

<%@ page import="ru.ds.pac.common.Constants,ru.ds.common.Functions"%>

<%
	String basepath = "../upload/articles/h/";
	pageContext.setAttribute("basepath", basepath);
%>


<c:if test="${param.issue != null}">
	<c:set var="issue" value="${param.issue}" scope="session" />
	<c:set var="list_type" value="selective" />
	<c:if test="${issue == 'allprinted'}">
		<c:set var="list_type" value="allprinted" />
		<c:set var="issue" value="0" scope="session" />	
	</c:if>
	<c:if test="${issue == 'nonprinted'}">
		<c:set var="list_type" value="nonprinted" />
		<c:set var="issue" value="-1" scope="session" />	
	</c:if>	
</c:if> 

<c:if test="${issue == null}">
	<c:set var="list_type" value="allprinted" />
</c:if>

<c:if test="${issue != null && issue != -1}">
	<c:set var="list_type" value="selective" />
</c:if>

<c:if test="${param.p != null}">
	<c:set var="p" value="${param.p}" scope="session" />
</c:if>
<c:if test="${p == null}">
	<c:set var="p" value="1" scope="session" />
</c:if>

<c:if test="${sort_field == null}">
	<c:set var="sort_field" value="a._updated" scope="session" />
	<c:set var="order" value="desc" scope="session" />
</c:if>

<c:if test="${param.sort == 'updated'}">
	<c:set var="sort_field" value="a.updated" scope="session" />
	<c:set var="order" value="desc" scope="session" />
</c:if>
<c:if test="${param.sort == 'title'}">
	<c:set var="sort_field" value="a.title" scope="session" />
	<c:set var="order" value="asc" scope="session" />
</c:if>
<c:if test="${param.sort == 'date'}">
	<c:set var="sort_field" value="b.date" scope="session" />
	<c:set var="order" value="asc" scope="session" />
</c:if>
<c:if test="${param.sort == 'editor'}">
	<c:set var="sort_field" value="c.login" scope="session" />
	<c:set var="order" value="asc" scope="session" />
</c:if>

<div id="header1"><span id="title">Статьи</span>

<div id="userdata">Редактор: <strong><c:out
	value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]</div>
</div>

<br />

<div id="header2">

<div class="button"><c:url value="" var="url_add_article"
	scope="page">
	<c:param name="op" value="view" />
	<c:param name="mode" value="ew_add" />
</c:url> <a href="<c:out value='${url_add_article}' />">Добавить статью</a></div>

<div class="form" style="margin: 0px 20px 0px 10px">
<form action="" id="sf_issues" method="get"><input type="hidden"
	name="p" value="1" /> <span class="label">Выпуск:</span> <select
	name="issue" onChange="activateForm('sf_issues')">
	<option value='allprinted'>Все напечатанные</option>
	<option value="nonprinted"
		<c:if test="${list_type=='nonprinted'}" >selected</c:if>>Не
	вошедшие в номер</option>
	<sql:query var="issues" dataSource="${datasrc}">
					select id, number from pna_issues where _status='active' order by date
				</sql:query>
	<c:forEach var="r" items="${issues.rows}">
		<c:choose>
			<c:when test="${r.id == issue}">
				<option value='<c:out value="${r.id}" />' selected><c:out
					value="${r.number}" /></option>
			</c:when>
			<c:otherwise>
				<option value='<c:out value="${r.id}" />'><c:out
					value="${r.number}" /></option>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</select></form>
</div>


<div class="button"><c:url value="" var="url" scope="page">
	<c:param name="op" value="view" />
	<c:param name="cat" value="articles" />
	<c:param name="mode" value="bin" />
</c:url> <a href="<c:out value='${url}' />">Корзина</a></div>

</div>

<br />

<div id="body"><c:choose>
	<c:when test="${list_type == 'selective'}">
		<sql:query var="articles" dataSource="${datasrc}">
				select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name
				from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
				where 
				a.issue = b.id
				and a.rubric = d.id				
				and a.contributor = c.id
				and a._status = 'active'
				and a.issue = ?
				order by <%=(String) pageContext.findAttribute("sort_field")%>
			<%=(String) pageContext.findAttribute("order")%>
			<sql:param value="${issue}" />
		</sql:query>
	</c:when>
	<c:when test="${list_type == 'allprinted'}">
		<sql:query var="articles" dataSource="${datasrc}">
				select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name
				from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
				where 
				a.issue = b.id
				and a.rubric = d.id				
				and a.contributor = c.id
				and a._status = 'active'
				order by <%=(String) pageContext.findAttribute("sort_field")%>
			<%=(String) pageContext.findAttribute("order")%>
		</sql:query>
	</c:when>	
		<c:when test="${list_type == 'nonprinted'}">
		<sql:query var="articles" dataSource="${datasrc}">
				select a.id, a.title, a.issue, a.picture, a._created, c.login, d.name
				from pna_articles as a, pna_editors as c, pna_rubrics as d
				where 
				a.rubric = d.id				
				and a.contributor = c.id
				and a._status = 'active'
				and a.issue = -1
				order by <%=(String) pageContext.findAttribute("sort_field")%>
			<%=(String) pageContext.findAttribute("order")%>
		</sql:query>
	</c:when>	
	<c:otherwise>
		<sql:query var="articles" dataSource="${datasrc}">
				select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name
				from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
				where 
				a.issue = b.id
				and a.rubric = d.id
				and a.contributor = c.id
				and a._status = 'active'
				order by <%=(String) pageContext.findAttribute("sort_field")%> asc
			</sql:query>
	</c:otherwise>
</c:choose>

<div id="dataTable" style="width: 900px">
<div class="th" style="width: 80px"><c:url value="" var="url"
	scope="page">
	<c:param name="op" value="view" />
	<c:param name="sort" value="date" />
</c:url> <a href="<c:out value='${url}' />">Дата</a></div>
<div class="th" style="width: 80px">№ выпуска</div>
<div class="th" style="width: 100px">Рубрика</div>
<div class="th" style="width: 110px">Фото</div>
<div class="th" style="width: 150px"><c:url value="" var="url"
	scope="page">
	<c:param name="op" value="view" />
	<c:param name="sort" value="title" />
</c:url> <a href="<c:out value='${url}' />">Заголовок</a></div>
<div class="th" style="width: 100px">Место</div>
<div class="th-last" style="width: 100px">Авторы</div>
<br />
<%
	int cnt = 0;
	String strP = (String) pageContext.findAttribute("p");
	int p = (strP == null) ? 1 : Integer.valueOf(strP);
	int page_min = Constants.ITEMS_ON_PAGE * (p - 1);
	int page_max = page_min + Constants.ITEMS_ON_PAGE;
%> <c:forEach var="r" items="${articles.rows}">
	<%
		cnt++;
		if (cnt > page_min && cnt <= page_max) {
	%>
	<div class="tdfh" style="width: 80px">
	<c:choose>
		<c:when test="${list_type == 'nonprinted'}">
			<fmt:formatDate value="${r._created}" pattern="dd.MM.yyyy" />
		</c:when>
		<c:otherwise>
			<fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />
		</c:otherwise>		
	</c:choose>
	</div>
	<div class="tdfh" style="width: 80px"><c:out value="${r.number}" />
	</div>
	<div class="tdfh" style="width: 100px"><c:out value="${r.name}" />
	</div>
	<div class="tdfh" style="width: 110px"><c:choose>
		<c:when
			test="${r.picture == '' || r.picture == 'null' || r.picture == null}">
			<img src="img/stub_picture.gif" />
		</c:when>
		<c:otherwise>
			<a target="_blank"
				href="<c:out value='${basepath}'/><c:out value='${r.picture}'/>/m.jpg"><img
				src='<c:out value="${basepath}"/><c:out value="${r.picture}"/>/s.jpg' /></a>
		</c:otherwise>
	</c:choose></div>
	<div class="tdfh" style="width: 150px"><c:set var="title"
		value="${r.title}" /> <%
 	String title = (String) pageContext.findAttribute("title");
 		title = Functions.crop(title);
 		pageContext
 				.setAttribute("title", title, PageContext.PAGE_SCOPE);
 %> <c:url value="" var="demo" scope="page">
		<c:param name="op" value="view" />
		<c:param name="mode" value="w_demo" />
		<c:param name="id" value="${r.id}" />
	</c:url> <a href="<c:out value='${demo}' />" target="_blank"><c:out
		value="${title}" /></a></div>
	<div class="tdfh" style="width: 100px;"><sql:query var="places"
		dataSource="${datasrc}">
						select a.name from pna_places as a, pna_articles_places as b 
	where b.place_id=a.id  and b.article_id=? order by a.name asc 
						<sql:param value="${r.id}" />
	</sql:query> <c:forEach var="rr" items="${places.rows}">
		<c:out value="${rr.name}" />
		<br />
	</c:forEach></div>
	<div class="tdfh-last" style="width: 100px;"><sql:query
		var="authors" dataSource="${datasrc}">
						select a.penname from pna_authors as a, pna_articles_authors as b 
	where b.author_id=a.id  and b.article_id=?
						<sql:param value="${r.id}" />
	</sql:query> <c:forEach var="rr" items="${authors.rows}">
		<c:out value="${rr.penname}" />
		<br />
	</c:forEach></div>
	<div class="toolbar"><c:url value="" var="upload" scope="page">
		<c:param name="op" value="view" />
		<c:param name="cat" value="articles" />
		<c:param name="mode" value="ew_upload" />
		<c:param name="id" value="${r.id}" />
	</c:url> <c:url value="" var="edit" scope="page">
		<c:param name="op" value="view" />
		<c:param name="cat" value="articles" />
		<c:param name="mode" value="ew_edit" />
		<c:param name="id" value="${r.id}" />
	</c:url> <c:url value="" var="bin" scope="page">
		<c:param name="op" value="move" />
		<c:param name="cat" value="articles" />
		<c:param name="id" value="${r.id}" />
	</c:url> <a href="<c:out value='${edit}' />" class="button"><img
		src="img/edit.gif"></a> <a href="<c:out value='${upload}' />"
		class="button" style="margin-right: 5px"><img src="img/image.gif"></a>
	<a href="<c:out value='${bin}' />" class="button"><img
		src="img/bin.gif"></a></div>
	<br />
	<%
		}
	%>
</c:forEach></div>
</div>


<div id="footer"><c:set var="items_on_page">
	<%=Constants.ITEMS_ON_PAGE%>
</c:set> <c:if test="${articles.rowCount > items_on_page}">
	<%
		int c = 0;
	%>
	<c:forEach items="${articles.rows}" step="${items_on_page}">
		<%
			c++;
		%>
		<c:url value="index.jsp" var="url">
			<c:param name="op" value="view" />
			<c:param name="cat" value="articles" />
			<c:param name="sort" value="${param.sort}" />
			<c:param name="p">
				<%=c%>
			</c:param>
		</c:url>
		<c:set var="c"><%=c%></c:set>
		<c:if test="${p == c}">
			<div class="current_button"><%="" + c%></div>
		</c:if>
		<c:if test="${p != c}">
			<a href="<c:out value='${url}' />" class="button"><%="" + c%></a>
		</c:if>
	</c:forEach>
</c:if></div>

<br class="br" />
