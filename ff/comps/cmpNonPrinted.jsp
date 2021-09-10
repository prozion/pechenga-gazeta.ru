<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.common.Functions" %>
<%@ page import="java.util.Date" %>

<c:if test="${year >= 2009}">

<sql:query var="nonp" dataSource="${datasrc}">
	select a.id, a.title, a._created
	from pna_articles as a 
	where
		a._status = 'active'
		and a.issue = ?
		and year(a._created) = ? 
		order by a._created desc
		limit 9
	<sql:param value="-1" />
	<sql:param value="${year}" />	
</sql:query>

<div class="front_articles">
<div class="h" style="background: url('ff/img/bg/front_articles_h.gif') #00f; border: 2px solid #900; border-width: 0px 2px 2px 0px; width: 300px;">Не вошедшее в печать</div>
<div class="nonprinted">
<c:set var="c" value="0" />
<c:forEach var="r" items="${nonp.rows}">
	<c:set var="c" value="${c+1}" />
	<c:if test="${c == 1}" >
		<div class="cc">
	</c:if>
			<div>
				<c:set var="created" value="${r._created}" />
				<c:set var="title" value="${r.title}" />
				<span class="date"><fmt:formatDate value="${created}" pattern="dd.MM.yyyy" />.</span>
				<span class="title">
				<c:url value="" var="url">
					<c:param name="view" value="article" />
					<c:param name="id" value="${r.id}" />
				</c:url>	
				<% 
String cropped_title = Functions.crop((String)pageContext.findAttribute("title"), 35); 
				%>	
				<a href="<c:out value='${url}' />">
						<%= cropped_title %>
				</a>
				</span>
			</div>		 				
	<c:if test="${c == 3 || c == 6}" >
		</div>
		<div class="cc">
	</c:if>
	<c:if test="${c == 9}" >
		</div>
	</c:if>	
</c:forEach>
<c:if test="${c < 9}">
</div>
</c:if>
<br style="clear: both" />
<div> </div>

</div>
</div>

</c:if>




