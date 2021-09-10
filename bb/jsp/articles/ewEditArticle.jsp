<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>

<div id="header1">
	<span id="title">Редактировать статью</span>
	
	<div id="userdata">Редактор: <strong><c:out value="${current_user}" /></strong> [<a href="?op=logout">Выйти</a>]
	</div>
</div>

<br />



<div id="body">
	<sql:query var="articles" dataSource="${datasrc}">
		select a.id, a.title, a.text, a.issue, a.picture, a.rubric, a._type, b.number, b.date, c.login, d.name
		from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
		where 
		a.issue = b.id
		and a.rubric = d.id
		and a.contributor = c.id
		and a._status = 'active'
		and a.id = ?
		order by a._updated desc
		<sql:param value="${param.id}" />
	</sql:query>
	<c:forEach var="r" items="${articles.rows}">
		<form class="ew" action="index.jsp" method="post">
			<input type="hidden" name="op" value="edit" />
			<input type="hidden" name="cat" value="articles" />
			<input type="hidden" name="id" value="<c:out value='${param.id}' />" />						
	
		<div class="row"><div class="label">Тип: </div>
			<select name="input__type">
				<c:if test="${r._type == 'is_in_issue'}">
					<option value="is_in_issue" selected>Напечатанная статья</option>
					<option value="out_of_issue">Не вошедшее в печать</option>
				</c:if>
				<c:if test="${r._type == 'out_of_issue'}">
					<option value="out_of_issue" selected>Не вошедшее в печать</option>				
					<option value="is_in_issue">Напечатанная статья</option>
				</c:if>				
			</select> 
		</div>	
	
			<div class="row"><div class="label">Рубрика: </div>
				<select name="input_rubric">
					<sql:query var="rubrics" dataSource="${datasrc}" >
						select id, name from pna_rubrics
					</sql:query>
					<c:forEach var="rr" items="${rubrics.rows}" >
						<c:choose>
							<c:when test="${r.rubric == rr.id}">
								<option value="<c:out value='${rr.id}' />" selected><c:out value="${rr.name}" /></option>
							</c:when>
							<c:otherwise>
								<option value="<c:out value='${rr.id}' />"><c:out value="${rr.name}" /></option>
							</c:otherwise>
						</c:choose>
					</c:forEach>			
				</select> 
			</div>		
			
			<div class="row"><div class="label">Дата: </div><input id="sel_date" type="text" name="input_date" size="60" value="<fmt:formatDate value='${r.date}' pattern='yyyy-MM-dd' />" />
				<input type="reset" value=" ... "
	onclick="return showCalendar('sel_date', '%Y-%m-%d', '24', true);" />
			</div>		
			
			<div class="row"><div class="label">Заголовок: </div><input type="text" name="input_title" size="60" value="<c:out value='${r.title}' />" /></div>
			
			<br />
			
			<div class="row-td"><div class="label">Авторы статьи: </div>
				<sql:query var="authors_for_this_article" dataSource="${datasrc}">
					select a.id from pna_authors as a, pna_articles_authors as b where b.author_id = a.id and b.article_id = ?
					<sql:param value="${r.id}" /> 
				</sql:query>
				<sql:query var="all_authors" dataSource="${datasrc}">
					select id, penname from pna_authors order by penname asc
				</sql:query>
				<select name="input_authors" size="4" multiple>
					<c:set var="is_author" value="" />
					<c:forEach var="i" items="${all_authors.rows}">
						<c:set var="is_author" value="false" />
						<c:forEach var="j" items="${authors_for_this_article.rows}">
							<c:if test="${i.id == j.id}">
								<c:set var="is_author" value="true" />
							</c:if>
						</c:forEach>			
						<c:choose>
							<c:when test="${is_author == 'true'}">
								<option value="<c:out value='${i.id}' />" selected><c:out value="${i.penname}" /></option>
							</c:when>
							<c:otherwise>
								<option value="<c:out value='${i.id}' />"><c:out value="${i.penname}" /></option>
							</c:otherwise>
						</c:choose>											
					</c:forEach>				
				</select>
			</div>
			
			<div class="row-td"><div class="label-second">Место: </div>
				<sql:query var="places_for_this_article" dataSource="${datasrc}">
					select a.id from pna_places as a, pna_articles_places as b where b.place_id = a.id and b.article_id = ? order by a.name asc
					<sql:param value="${r.id}" /> 
				</sql:query>
				<sql:query var="all_places" dataSource="${datasrc}">
					select id, name from pna_places order by name asc
				</sql:query>
				<select name="input_places" size="4" multiple>
					<c:set var="is_place" value="" />
					<c:forEach var="i" items="${all_places.rows}">
						<c:set var="is_place" value="false" />
						<c:forEach var="j" items="${places_for_this_article.rows}">
							<c:if test="${i.id == j.id}">
								<c:set var="is_place" value="true" />
							</c:if>
						</c:forEach>			
						<c:choose>
							<c:when test="${is_place == 'true'}">
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
			<c:set var="text" value='${r.text}' />
<% 
	String text = (String)pageContext.getAttribute("text");
	if(text == null || text.equals("")) text=" ";
%>
			<fck:editor instanceName="input_text" basePath="/bb/js/fckeditor" height="300" value='<%= text %>' />	
			</div>

			<div class="row"><input class="submit" type="submit" value="Сохранить" /></div>
			
		</form>		
	</c:forEach>
</div>


<div id="footer">
<!-- nothing -->
</div>
