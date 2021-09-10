<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.pac.common.Constants, ru.ds.common.Functions" %>

<c:set var="sp" value="Советская Печенга" /> 
<c:set var="pe" value="Печенга" />

<% int items_on_page = Constants.ITEMS_ON_PAGE * 3; %>
	<c:set var="items_on_page">	
<%= 	items_on_page				%>
	</c:set>

<c:if test="${param.year != null}">
	<c:set var="year" value="${param.year}" scope="session" />
	<c:if test="${year == 'all'}" >
		<!--<c:remove var="year" scope="session" />-->
	</c:if>
</c:if>

<div id="header1">
	<span id="title"><c:out value="${cat_label}" /></span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<div id="header2">

	<div class="button">
		<c:url value="" var="url" scope="page">
			<c:param name="op" value="view" />			 
			<c:param name="mode" value="ew_add" />
		</c:url>
		<a href="<c:out value='${url}' />">Добавить выпуск</a>
	</div>
	
	<div class="form" style="margin: 0px 20px 0px 10px">
		<form action="" id="sf_issues" method="get" >
			<input type="hidden" name="p" value="1" />
			<span class="label">Год:</span> 
			<select style="width: 70px" name="year" onChange="activateForm('sf_issues')">
				<c:if test="${year == 'all'}" ><option value='all' selected> </option></c:if>
				<c:if test="${year != 'all'}" ><option value='all' selected><c:out value="${year}" /></option></c:if>
				<option disabled>------</option>
				<option value='2012'>2012</option>
				<option value='2011'>2011</option>	
				<option value='2010'>2010</option>	
				<option value='2009'>2009</option>				
				<option value='2008'>2008</option>
				<option value='2007'>2007</option>
				<option value='2006'>2006</option>
				<option value='2005'>2005</option>
				<option value='2004'>2004</option>
				<option value='2003'>2003</option>
				<option value='1950'>1950</option>
				<option value='1949'>1949</option>
			</select> 
		</form>
	</div>	
	
</div>

<br />	

<div id="body">
	<c:choose>
		<c:when test="${year != null && year != 'all'}" >
			<sql:query var="issues" dataSource="${datasrc}">
				select id, number, date, type
				from pna_issues where year(date) = ?
				and _status = 'active'
				order by date desc
				<sql:param value="${year}" />
			</sql:query>
		</c:when>
		<c:otherwise>
			<sql:query var="issues" dataSource="${datasrc}">
				select id, number, date, type
				from pna_issues
				where _status = 'active'
				order by date desc
			</sql:query>		
		</c:otherwise>
	</c:choose>

	<div id="dataTable" style="width: 900px">
		<div class="th" style="width: 100px;">Дата</div>
		<div class="th" style="width: 100px">Номер</div>
		<div class="th" style="width: 200px">Название газеты</div>				
		<div class="th-last" style="width: 100px">Количество статей</div>
		<br />
<%
			int cnt = 0;
			String strP = request.getParameter("p");
			int p = ( strP == null )? 1 : Integer.valueOf(strP);
			int page_min = items_on_page*(p - 1);
			int page_max = page_min + items_on_page;													 			
%>
		<c:forEach var="r" items="${issues.rows}">
<% 
				cnt++;
				if(cnt > page_min && cnt < page_max) {
%>
			<div class="td" style="width: 100px;">
				<fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />
			</div>
			<div class="td" style="width: 100px">
				<c:out value="${r.number}" />
			</div>			
			<div class="td" style="width: 200px">
				<c:set var="type" value="${r.type}" />
				<c:choose>
					<c:when test="${type == 'sp'}">
						<c:out value="${sp}" />
					</c:when>
					<c:when test="${type == 'pe'}">
						<c:out value="${pe}" />
					</c:when>			
				</c:choose>		
			</div>					
			<div class="td-last" style="width: 100px;">
				<sql:query var="amount" dataSource="${datasrc}">
					select count(*) as amount 
					from pna_articles
					where _status = 'active' 
					and issue = ?
					<sql:param value="${r.id}" />
				</sql:query>
				<c:forEach var="n" items="${amount.rows}">
					<c:out value="${n.amount}" />
				</c:forEach>
			</div>
			<div class="toolbar">	
				<c:url value="" var="edit" scope="page">
					<c:param name="op" value="view" />
					<c:param name="mode" value="ew_edit" />					
					<c:param name="id" value="${r.id}" />									 
				</c:url>
				<c:url value="" var="bin" scope="page">
					<c:param name="op" value="move" />			
					<c:param name="id" value="${r.id}" />						
				</c:url>												
				<a href="<c:out value='${edit}' />" class="button"><img src="img/edit.gif"></a>
				<a href="<c:out value='${bin}' />" class="button"><img src="img/bin.gif"></a>				
			</div>
			<br />
<% 		 } 			%>
		</c:forEach>
	</div>	
</div>


<div id="footer">	
	<c:if test="${issues.rowCount > items_on_page}">
<%				int c=0;	%>
		<c:forEach items="${issues.rows}" step="${items_on_page}">
<% 				c++;		 %>
			<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="issues" />				
				<c:param name="p"> <%= c %> </c:param>	 
			</c:url>
			<a href="<c:out value='${url}' />" class="button"><%= ""+c %></a>
		</c:forEach>
	</c:if>
</div>
<br style="clear: both" />

</table> 
