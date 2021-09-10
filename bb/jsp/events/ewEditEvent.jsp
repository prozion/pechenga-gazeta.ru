<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Редактирование события</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<sql:query var="records" dataSource="${datasrc}">
	select date, title, ref
	from pna_events where id = ?
	<sql:param value="${param.id}" />
</sql:query>

<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<c:forEach var="r" items="${records.rows}">
			<input type="hidden" name="op" value="edit" />
			<input type="hidden" name="id" value="<c:out value='${param.id}' />" />						
			
			<div class="row"><div class="label">Дата: </div><input id="sel_date" type="text" name="input_date" size="60" value="<fmt:formatDate value='${r.date}' pattern='yyyy-MM-dd' />" />
				<input type="reset" value=" ... "
	onclick="return showCalendar('sel_date', '%Y-%m-%d', '24', true);" />
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Текст:</div>
				<input size="100" name="input_title" value="<c:out value='${r.title}' />" />	
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Ссылка:</div>
				<input size="100" name="input_ref" value="<c:out value='${r.ref}' />" />	
			</div>
			<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		</c:forEach>
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
