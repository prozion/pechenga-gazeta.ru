<%@ page contentType="text/html;charset=utf-8"%>

<%@ include file="../inc/taglibs.inc"%>
<%@ include file="../inc/sql.inc"%>

<sql:query var="events" dataSource="${datasrc}">
select date, title, ref from pna_events where date >= CURRENT_DATE() order by date asc limit 10
</sql:query>

<div class="events">
<div><img src="ff/img/pointers/sandclocks.gif" style="position: relative; top: 0px; right: 0px; text-align: center; margin: 3px 0px 5px 250px" /></div>
<c:forEach var="r" items="${events.rows}" varStatus="status">
	<div class="p"><span
		class="date" style="padding: 0px 4px; background: #e60; color: #fff; border: 1px solid #000; border-width: 1px 0px 0px 0px;"><fmt:formatDate value="${r.date}"
		pattern="dd.MM.yyyy" /></span> <span class="text" style="color: #444;"><c:out
		value="${r.title}" /></span>
		<c:if test='${r.ref ne "http://pechenga.gazeta.ru" && r.ref ne ""}'>
			<span>.. <a href="<c:out value='${r.ref}' />">>>></a> ..</span>
		</c:if>
		</div>
		<c:if test="${status.count < events.rowCount}">
			<div style="position: relative; left: 5px; margin-top: 7px; margin-bottom: 7px; width: 365px; background: url('ff/img/bg/arrows.gif'); background-repeat: repeat-x; font-size: 5px;"><img style="position: relative; left: -5px;" src="ff/img/pointers/small_blue_arrow.gif" />&nbsp;</div>
		</c:if>
</c:forEach>
</div>
 

