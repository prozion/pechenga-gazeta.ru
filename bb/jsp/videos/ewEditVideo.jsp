<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Редактирование видео</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<sql:query var="records" dataSource="${datasrc}">
	select issue, title, url
	from pna_videos where id = ?
	<sql:param value="${param.id}" />
</sql:query>

<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<c:forEach var="r" items="${records.rows}">
			<input type="hidden" name="op" value="edit" />
			<input type="hidden" name="id" value="<c:out value='${param.id}' />" />						
			
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Выпуск:</div>
				<input size="100" name="input_issue" value="<c:out value='${r.issue}' />" />	
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Название сюжета:</div>
				<input size="100" name="input_title" value="<c:out value='${r.title}' />" />	
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Ссылка:</div>
				<input size="100" name="input_url" value="<c:out value='${r.url}' />" />	
			</div>
			<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		</c:forEach>
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
