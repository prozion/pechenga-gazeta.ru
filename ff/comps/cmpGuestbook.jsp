<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="java.util.Date" %>
<%@ page import="ru.ds.antibot.AntibotImage" %>

<% session.setMaxInactiveInterval(-1); %>

<c:set var="pp" value="${param.pp}" />
<c:if test="${pp == null}">
	<c:set var="pp" value="1" />
</c:if>

<%	
		int RECORDS_PER_PAGE = 5;
		int pp = Integer.parseInt((String)pageContext.findAttribute("pp"));
		int start_record = (pp-1)*RECORDS_PER_PAGE;
%> 

<sql:query var="records" dataSource="${datasrc}">
	select id, datetime, name, town, text, commentary
	from pna_messages
	where _status='active'
	order by datetime desc
	limit <%= start_record %>, <%= RECORDS_PER_PAGE %>
</sql:query>

<div class="html" style="margin-top: 0px; padding-top: 0px;">	

<h1 style="margin: 0; padding: 1px 5px; background: #e50; color: #fff; font: bold 13px Arial; text-align: center;">ВАШИ ОТЗЫВЫ</h1>
			
<div class="guestbook">
	<c:if test="${error == 'wrong code'}">
		<div class="error">Неправильно введен код, попробуйте еще раз!</div>
		<c:set var="error" value="" scope="session" />
	</c:if>
	<c:forEach var="r" items="${records.rows}" >
		<div class="box">
			<div class="top">
				<span class="datetime"><fmt:formatDate value="${r.datetime}" type="both" pattern="dd.MM.yyyy HH:mm" /></span>			
				<span class="name"><c:out value="${r.name}" />, </span>
				<span class="town"><c:out value="${r.town}" /></span>
			</div>
			<div class="text">
				<c:out value="${r.text}" /></div>			
			<div class="commentary">
				<c:out value="${r.commentary}" escapeXml="false" />
			</div>
		</div>
	</c:forEach>						
</div>

<c:set var="rpp">
	<%= RECORDS_PER_PAGE %>
</c:set>
<sql:query var="total" dataSource="${datasrc}">
	select * from pna_messages 
	where _status='active'
</sql:query>
<c:if test="${total.rowCount > rpp}">
<div class="pagebar">
<c:if test="${total.rowCount%rpp == 0}">
	<c:set var="end" value="${total.rowCount/rpp}" />
</c:if>
<c:if test="${total.rowCount%rpp != 0}">
	<c:set var="end" value="${1 + total.rowCount/rpp}" />
</c:if>
<c:forEach var="i" begin="1" end="${end}" step="1">
	<c:url var="purl" value="">
		<c:param name="p" value="_guestbook" />
		<c:param name="pp" value="${i}" />
	</c:url>
	<span class="page">
	<c:if test="${i == pp}">
		<b>[<c:out value="${i}" />]</b>
	</c:if>
	<c:if test="${i != pp}">
		<a href="<c:out value='${purl}' />">[<c:out value="${i}" />]</a>
	</c:if>	
	</span>
</c:forEach>
</div>
</c:if>

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
	 
<div class="formbox">
	<form name="inputform" class="ew" action="index.jsp" method="post" onSubmit="return validate(this);">
			<input type="hidden" name="op" value="addmsg" />					
			
			<div class="row">
				<div class="label">Имя:</div>
				<input type="text" name="input_name" size="40" />
			</div>
			<div class="row">
				<div class="label">Город:</div>
				<input type="text" name="input_town" size="40" />
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

</div>
