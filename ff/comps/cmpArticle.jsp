<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.antibot.AntibotImage" %>

<% session.setMaxInactiveInterval(-1); %>

<c:set var="basepath" value="upload/articles/h/" />

<%
	String ip = request.getRemoteAddr(); 
	pageContext.setAttribute("ip", ip);
%>

<sql:update dataSource="${datasrc}">
insert into pna_visits(article, ip) values(?, ?)
	<sql:param value="${param.id}" />
	<sql:param value="${ip}" />	
</sql:update>

<sql:query var="article" dataSource="${datasrc}">
	select a.id, a.title, a.issue, a.picture, a.text, b.number, b.date, c.login, d.alias
	from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
	where 
	a.issue = b.id
	and a.contributor = c.id
	and a.rubric = d.id
	and a.id = ?
	limit 1
	<sql:param value="${param.id}" />
</sql:query>
<c:forEach var="r" items="${article.rows}">
	<c:set var="article_id" value="${r.id}" scope="page" />
	<c:if test="${r.alias == 'docs'}">
		<c:set var="type" value="docs" /> 
	</c:if>
	<c:if test="${r.alias == 'announcement'}">
		<c:set var="type" value="ans" /> 
	</c:if>	
	<c:choose>
		<c:when test="${type == 'docs' || type == 'ans'}">
			<div class="doc">
				<c:url value="" var="url">
					<c:param name="i" value="${r.number}" />
				</c:url>			
				<div class="info"><span class="date"><fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" /></span> | <span class="issue">Выпуск №<a href="<c:out value='${url}' />"><c:out value="${r.number}" /></a></span>
				</div>
				<c:if test="${type != 'docs'}">
					<div class="title"><c:out value="${r.title}" /></div>
				</c:if>
				<div class="text"><c:out value="${r.text}" escapeXml="false" /></div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="article">
				<c:if test="${r.issue != -1}" >
				<c:url value="" var="url">
					<c:param name="i" value="${r.number}" />
				</c:url>
				<div class="info"><span class="date"><fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" /></span> | <span class="issue">Выпуск № <a class="issue_num" href="<c:out value='${url}' />"><c:out value="${r.number}" /></a></span> | <span class="places">
							<sql:query var="places" dataSource="${datasrc}" >
								select b.name from pna_articles_places as a, pna_places as b
								where a.article_id=?
								and b.id=a.place_id
								<sql:param value="${r.id}" />
							</sql:query>
							<% int c=0; %>
							<c:forEach var="rr" items="${places.rows}">
								<c:out value="${rr.name}" />
								<% pageContext.setAttribute("c", ++c); %>
								<c:if test="${c < places.rowCount}">, </c:if>					
							</c:forEach>
						</span>
				</div>
				</c:if>
				<div class="title"><c:out value="${r.title}" /></div>
					<c:choose>
						<c:when test="${r.picture == '' || r.picture == 'null' || r.picture == null}">
						</c:when>
						<c:otherwise>
							<div class="picture">
								<img src='<c:out value="${basepath}"/><c:out value="${r.picture}"/>/m.jpg' />
							</div>							
						</c:otherwise>
					</c:choose>	
				<div class="text"><c:out value="${r.text}" escapeXml="false" /></div>
				<br style="clear: both;" />
			</div>
			
			<sql:query var="records" dataSource="${datasrc}">
				select id, datetime, name, town, text
				from pna_comments
				where _status='active'
				and article_id = ?
				order by datetime asc
				<sql:param value="${article_id}" />
			</sql:query>

			<div class="comments">
				<div class="comments_header">
					КОММЕНТАРИИ
				</div>
				<c:if test="${error == 'wrong code'}">
					<div class="error">Неправильно введен код, попробуйте еще раз!</div>
					<c:set var="error" value="" scope="session" />
				</c:if>
				<c:forEach var="r" items="${records.rows}" >
					<div class="box">
						<div class="top">
							<span class="datetime"><fmt:formatDate value="${r.datetime}" type="both" pattern="dd.MM.yyyy HH:mm" /></span>			
							<span class="name"><c:out value="${r.name}" /></span>
							<span class="town"><c:out value="${r.town}" /></span>
						</div>
						<div class="text">
					<c:set var="comment_text" value="${r.text}" />
					<%
					String text = (String)pageContext.findAttribute("comment_text");
					java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\n");
					java.util.regex.Matcher m = pattern.matcher(text);
					String res = m.replaceAll("<br />");
					pageContext.setAttribute("comment_text", res);
					%>
							<c:out value="${comment_text}" escapeXml="false" /></div>			
					</div>
				</c:forEach>						
			</div>


			<script>
				function validate(){
					nameval = document.inputform.input_name.value;
					townval = document.inputform.input_town.value;
					textval = document.inputform.input_text.value;
					if(nameval == '') {
						alert("Введите имя");
						return false;
					}
					if(townval == '') {
						alert("Введите город");	
						return false;		
					}
					if(textval == '' || textval.length < 3) {
					 	alert("Напишите сообщение");
						return false;		 	
					}
				}
			</script>

			<% 
			
				AntibotImage ai = (AntibotImage)session.getAttribute("ai");
				String antibot_folder_path = "ff/img/antibot";
				if(ai == null) {
					//session.setAttribute("antibot_code", antibot_code);
					session.setAttribute("antibot_pic_real_path", 
												request.getRealPath(antibot_folder_path));
					ai = new AntibotImage(60, 23, (String)session.getAttribute("antibot_pic_real_path"));
					ai.createImage();
					session.setAttribute("ai", ai);					
					session.setAttribute("antibot_pic_path", antibot_folder_path + "/" + ai.getFileName());
				} else {
					session.setAttribute("antibot_pic_path", antibot_folder_path + "/" + ai.getFileName());
				}
			%>
	 
	<div class="comments_form">
		<div style="font: normal 9pt Arial; color: #fff; background: #a00; border: #900; 
		padding: 5px 10px; margin: 10px 0px;"> 
		<p><b style="text-align: center"><center>Уважаемые пользователи нашего сайта!</center></b></p>
<p>Вот уже больше года наш сайт работает для вас. Мы стараемся совершенствоваться.
Теперь, в связи с некоторыми техническими изменениями на сайте нашим гостям необходимо будет указывать свой «ник»,
город и адрес электронного ящика для того, чтобы оставить свои комментарии. 
Надеемся, что такая форма регистрации не вызовет никаких затруднений.</p>

<p>С нового года на сайте будут действовать правила, обязательные для наших пользователей: комментарии, выходящие за рамки приличия, содержащие нецензурную лексику, 
сообщения с "особой" смысловой нагрузкой  - агрессивные и оскорбительные комментарии, 
также клевета, будут удаляться модератором.</p>
		</div>
		<div><b>Ваш комментарий</b></div>
		<form name="inputform" class="ew" action="index.jsp" method="post" onSubmit="return validate(this);">
				<input type="hidden" name="op" value="addcomment" />
				<input type="hidden" name="input_article_id" value="<c:out value='${article_id}' />" />						
				
				<div class="row">
					<div class="label">Имя:</div>
					<input type="text" name="input_name" size="40" />
				</div>
				<div class="row">
					<div class="label">Город:</div>
					<input type="text" name="input_town" size="40" />
				</div>
				<div class="row">
					<div class="label">Email:</div>
					<input type="text" name="input_email" size="40" />
				</div>
				<div class="row">
					<div class="label">Сообщение:</div>
					<textarea rows="5" cols="50" name="input_text"></textarea> 
				</div>
				<div class="row">				
					<div class="label">Введите код, указанный на картинке: <input type="text" name="input_code" size="10" /> <img class="proof_pic" src="<c:out value='${antibot_pic_path}' />" /></div>
					
				</div>
				<div class="row" style="margin: 10px 0px;"><input class="submit" type="submit" value="Отправить" /></div>
		</form>		
	</div>




		</c:otherwise>
	</c:choose>
</c:forEach>

