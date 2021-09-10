<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Редактирование выпуска газеты</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<sql:query var="records" dataSource="${datasrc}">
	select date, number
	from pna_issues where id = ?
	<sql:param value="${param.id}" />
</sql:query>

<c:forEach var="r" items="${records.rows}">
<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<input type="hidden" name="op" value="edit" />
		<input type="hidden" name="cat" value="issues" />
		<input type="hidden" name="id" value="<c:out value='${param.id}' />" />					
		
		<div class="row"><div class="label">Дата: </div><input id="sel_date" type="text" name="input_date" size="60" value="<c:out value='${r.date}' />" />
			<input type="reset" value=" ... "
onclick="return showCalendar('sel_date', '%Y-%m-%d', '24', true);" />
		</div>		
		
		<div class="row"><div class="label">Номер: </div><input type="text" name="input_number" size="60" value="<c:out value='${r.number}' />" /></div>		
		 			
		<br />
		
		<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		
	</form>		
</div>
</c:forEach>

<div id="footer">
<!-- nothing -->
</div>
