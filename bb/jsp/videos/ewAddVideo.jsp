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


<div id="body">
	<form class="ew" action="index.jsp" method="post">
			<input type="hidden" name="op" value="add" />						
			
			<div class="row"><div class="label">Дата: </div>
				<input id="sel_date" type="text" name="input_issue" size="60" />
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Название сюжета:</div>
				<input size="100" name="input_title" />	
			</div>
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Ссылка:</div>
				<input size="100" name="input_url" />	
			</div>
			<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
