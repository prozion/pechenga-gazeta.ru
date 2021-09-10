<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Создать номер</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<input type="hidden" name="op" value="add" />
		<input type="hidden" name="cat" value="issues" />				
		
		<div class="row"><div class="label">Дата: </div><input id="sel_date" type="text" name="input_date" size="60" />
			<input type="reset" value=" ... "
onclick="return showCalendar('sel_date', '%Y-%m-%d', '24', true);" />
		</div>		
		
		<div class="row"><div class="label">Номер: </div><input type="text" name="input_number" size="60" /></div>		
		 			
		<br />
		
		<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
