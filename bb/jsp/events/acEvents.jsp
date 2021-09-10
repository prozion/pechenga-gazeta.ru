<%@ page contentType="text/html;charset=utf-8"%>

<%@ include file="../inc/header.inc"%>
<%@ include file="../inc/sql.inc"%>

<%@ page import="ru.ds.pac.common.Constants,ru.ds.common.Functions"%>

<c:set var="cat" value="events" scope="session" />

<div id="header1"><span id="title">Анонсы</span>

<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]</div>
</div>

<br />

<div id="header2">

<div class="button"><c:url value="" var="url_add_article"
	scope="page">
	<c:param name="op" value="view" />
	<c:param name="mode" value="ew_add" />
</c:url> <a href="<c:out value='${url_add_article}' />">Добавить анонс</a>
</div>

</div>

<br />

<div id="body"><sql:query var="news" dataSource="${datasrc}">
		select id, date, title, ref
		from pna_events where _status = 'active'
		order by date desc
	</sql:query>

<div id="dataTable" style="width: 900px">
<div class="th" style="width: 80px">Дата</div>
<div class="th" style="width: 300px">Ссылка</div>
<div class="th-last" style="width: 400px">Текст</div>
<br />
<%
	int cnt = 0;
	String strP = request.getParameter("p");
	int p = (strP == null) ? 1 : Integer.valueOf(strP);
	int page_min = Constants.ITEMS_ON_PAGE * (p - 1);
	int page_max = page_min + Constants.ITEMS_ON_PAGE;
%> <c:forEach var="r" items="${news.rows}">
	<%
		cnt++;
		if (cnt > page_min && cnt < page_max) {
	%>
	<div class="td" style="width: 80px"><fmt:formatDate
		value="${r.date}" pattern="dd.MM.yyyy" /></div>
	<div class="td" style="width: 300px;"><c:set var="ref"
		value="${r.ref}" /> <%=Functions.crop((String) pageContext.findAttribute("ref"), 30)%>
	</div>
	<div class="td-last" style="width: 400px;"><c:set var="title"
		value="${r.title}" /> <%=Functions.crop((String) pageContext.findAttribute("title"), 50)%>
	</div>
	<div class="toolbar"><c:url value="" var="edit" scope="page">
		<c:param name="op" value="view" />
		<c:param name="mode" value="ew_edit" />
		<c:param name="id" value="${r.id}" />
	</c:url> <c:url value="" var="delete" scope="page">
		<c:param name="op" value="delete" />
		<c:param name="id" value="${r.id}" />
	</c:url> <a href="<c:out value='${edit}' />" class="button"><img
		src="img/edit.gif"></a> <a href="<c:out value='${delete}' />"
		class="button"><img src="img/drop.gif"></a></div>
	<br />
	<%
		}
	%>
</c:forEach></div>
</div>


<div id="footer"><c:set var="items_on_page">
	<%=Constants.ITEMS_ON_PAGE%>
</c:set> <c:if test="${news.rowCount > items_on_page}">
	<%
		int c = 0;
	%>
	<c:forEach items="${news.rows}" step="${items_on_page}">
		<%
			c++;
		%>
		<c:url value="index.jsp" var="url">
			<c:param name="op" value="view" />
			<c:param name="cat" value="events" />
			<c:param name="p">
				<%=c%>
			</c:param>
		</c:url>
		<a href="<c:out value='${url}' />" class="button"><%="" + c%></a>
	</c:forEach>
</c:if></div>
<br style="clear: both" />

</table>
