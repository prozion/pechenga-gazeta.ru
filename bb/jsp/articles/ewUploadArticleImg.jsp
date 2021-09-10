<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<div id="header1">
	<span id="title">Загрузить фото</span>
</div>

<div id="body">
		
	<c:url var="process" value="index.jsp">
		<c:param name="op" value="upload" />>
		<c:param name="id" value="${param.id}" />
	</c:url>			
	<form action="<c:out value='${process}' />" enctype="multipart/form-data" method="post"> 
		<input type="hidden" name="id" value="<c:out value='${param.id}' />" />
		<input type="file" id="upload" name="input_image" size="30" />
		<input type="submit" value="Загрузить" />
	</form> 
</div>
