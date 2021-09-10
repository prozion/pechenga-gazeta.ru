<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Создать статью</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />

<div id="body">
	<form class="ew" action="index.jsp" method="post">
		<input type="hidden" name="op" value="add" />
		<input type="hidden" name="cat" value="articles" />		

		<div class="row"><div class="label">Тип: </div>
			<select name="input_type">
				<option value="is_in_issue" selected>Напечатанная статья</option>
				<option value="out_of_issue">Не вошедшее в печать</option>
			</select> 
		</div>

		<div class="row"><div class="label">Рубрика: </div>
			<select name="input_rubric">
					<sql:query var="rubrics" dataSource="${datasrc}" >
						select id, name from pna_rubrics
					</sql:query>
					<c:forEach var="rr" items="${rubrics.rows}" >
						<option value="<c:out value='${rr.id}' />"><c:out value="${rr.name}" /></option>					
					</c:forEach>		
			</select> 
		</div>		
		
		<div class="row"><div class="label">Дата: </div><input id="sel_date" type="text" name="input_date" size="60" />
			<input type="reset" value=" ... "
onclick="return showCalendar('sel_date', '%Y-%m-%d', '24', true);" />
		</div>		
		
		<div class="row"><div class="label">Заголовок: </div><input type="text" name="input_title" size="60" /></div>
		
		<br />
		
		<div class="row-td"><div class="label">Авторы статьи: </div>
			<sql:query var="authors" dataSource="${datasrc}">
				select id, penname from pna_authors order by penname asc
			</sql:query>
			<select name="input_authors" size="4" multiple>
				<c:forEach var="row" items="${authors.rows}">
					<option value="<c:out value='${row.id}' />"><c:out value="${row.penname}" /></option>
				</c:forEach>				
			</select>
		</div>
		
		<div class="row-td"><div class="label-second">Место: </div>
			<sql:query var="all_places" dataSource="${datasrc}">
				select id, name, alias from pna_places order by name asc
			</sql:query>
			<select name="input_places" size="4" multiple>
				<c:forEach var="i" items="${all_places.rows}">
					<c:choose>
						<c:when test="${$i.alias == 'none'}">
								<option value="<c:out value='${i.id}' />" selected><c:out value="${i.name}" /></option>
						</c:when>
						<c:otherwise>
							<option value="<c:out value='${i.id}' />"><c:out value="${i.name}" /></option>					
						</c:otherwise>
					</c:choose>											
				</c:forEach>				
			</select>
		</div>		
		 			
		<br />
				
		<div class="row">
			<fck:editor instanceName="input_text" basePath="/bb/js/fckeditor" height="300" value=" " />	
		</div>
		
		<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
		
	</form>		
</div>


<div id="footer">
<!-- nothing -->
</div>
