<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Редактирование сообщения</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<sql:query var="records" dataSource="${datasrc}">
	select datetime, name, town, text, commentary
	from pna_messages where id = ?
	<sql:param value="${param.id}" />
</sql:query>

<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<c:forEach var="r" items="${records.rows}">
			<input type="hidden" name="op" value="edit" />
			<input type="hidden" name="id" value="<c:out value='${param.id}' />" />						
			
			<div class="row"><div class="label">Дата и время:</div>
				<div class="noneditable"><fmt:formatDate value="${r.datetime}" pattern="dd.MM.yyyy hh:mm" /></div> 
			</div>
			<div class="row">
				<div class="label">Имя:</div>
				<div class="noneditable"><c:out value="${r.name}" /></div> 
			</div>
			<div class="row">
				<div class="label">Город:</div>
				<div class="noneditable"><c:out value="${r.town}" /></div>
			</div>
			<div class="row">
				<div class="label">Вопрос:</div>
				<textarea rows="5" cols="50" name="input_text"><c:out value="${r.text}" /></textarea> 
			</div>				
			<div class="row">
			<div class="label" style="margin-bottom: 1em;">Ответ:</div>
			<c:set var="commentary" value='${r.commentary}' />
			<fck:editor instanceName="input_commentary" basePath="/bb/js/fckeditor" height="300" value='<%= (String)pageContext.getAttribute("commentary") %>' />	
			</div>
			<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		</c:forEach>
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
