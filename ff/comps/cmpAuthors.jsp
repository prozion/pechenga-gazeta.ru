<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.common.Functions" %>

<c:set var="imgpath" value="ff/img/stuff" />

<% 
	pageContext.setAttribute("order","desc"); 
	pageContext.setAttribute("sort_field","b.date");
	pageContext.setAttribute("limit","7");
%>

<sql:query var="authors" dataSource="${datasrc}">
select auth.penname, auth.alias, count(*) from pna_articles as a, pna_authors as auth, 
pna_issues as i, pna_articles_authors as a_auth 
where a.issue = i.id
and a.id = a_auth.article_id
and auth.id = a_auth.author_id
and auth.alias != 'other'
and auth.writer = 'yes'
and year(i.date) = ?
group by auth.penname
order by count(*) desc
limit 8
<sql:param value="${year}" />
</sql:query>

<c:forEach var="r" items="${authors.rows}" >
<c:if test="${r.alias != ''}">
	<div class="author_box">
		<div class="cci">
				<img src="<c:out value='${imgpath}' />/<c:out value='${r.alias}' />.jpg" />
		</div>
		<div class="cc">
			<h3><c:out value="${r.penname}" /></h3>
			<c:set var="alias" value="${r.alias}" />
			<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp">
				<jsp:param name="name" value='<%= pageContext.findAttribute("alias") %>' />
			</jsp:include></b></span>
			<jsp:include page="subs/subLatestArticles.jsp">
				<jsp:param name="name" value='<%= pageContext.findAttribute("alias") %>' />
				<jsp:param name="number" value="4" />					
			</jsp:include>
		</div>
		<br style="clear: both" />
		<div> </div>
	</div>
</c:if>
</c:forEach>

<!-- <div class="author_box">
	<div class="cci"><img src="<c:out value='${imgpath}' />/pogoretskaya.jpg" /></div>
	<div class="cc">
		<h3>ОКСАНА ПОГОРЕЦКАЯ</h3>
		<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp">
			<jsp:param name="name" value="pogoretskaya" />	
		</jsp:include></b></span>
		<jsp:include page="subs/subLatestArticles.jsp">
			<jsp:param name="name" value="pogoretskaya" />
			<jsp:param name="number" value="4" />					
		</jsp:include>
	</div>
	<br style="clear: both" />
	<div> </div>
</div>
<div class="author_box">
	<div class="cci"><img src="<c:out value='${imgpath}' />/bulygin.jpg" /></div>
	<div class="cc">
		<h3>АЛЕКСЕЙ БУЛЫГИН</h3>
		<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp">
			<jsp:param name="name" value="bulygin" />	
		</jsp:include> </b></span>
		<jsp:include page="subs/subLatestArticles.jsp">
			<jsp:param name="name" value="bulygin" />
			<jsp:param name="number" value="4" />					
		</jsp:include>
	</div>
	<br style="clear: both" />
	<div> </div>
</div>
<div class="author_box">
	<div class="cci"><img src="<c:out value='${imgpath}' />/fedorova.jpg" /></div>
	<div class="cc">
		<h3>МАРИЯ ФЕДОРОВА</h3>
		<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp"> 
			<jsp:param name="name" value="fedorova" />	
		</jsp:include> </b></span>
		<jsp:include page="subs/subLatestArticles.jsp">
			<jsp:param name="name" value="fedorova" />
			<jsp:param name="number" value="4" />					
		</jsp:include>
	</div>
	<br style="clear: both" />
	<div> </div>
</div>
<div class="author_box">
	<div class="cci"><img src="<c:out value='${imgpath}' />/cherednichenko.jpg" /></div>
	<div class="cc">
		<h3>СВЕТЛАНА ЧЕРЕДНИЧЕНКО</h3>
		<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp"> 
			<jsp:param name="name" value="cherednichenko" />	
		</jsp:include> </b></span>
		<jsp:include page="subs/subLatestArticles.jsp">
			<jsp:param name="name" value="cherednichenko" />
			<jsp:param name="number" value="4" />					
		</jsp:include>
	</div>
	<br style="clear: both" />
	<div> </div>
</div>
<div class="author_box">
	<div class="cci"><img src="<c:out value='${imgpath}' />/isaeva.jpg" /></div>
	<div class="cc">
		<h3>И. САЕВА</h3>
		<span class="total">Всего: <b><jsp:include page="subs/subCountArticles.jsp"> 
			<jsp:param name="name" value="saeva" />	
		</jsp:include> </b></span>
		<jsp:include page="subs/subLatestArticles.jsp">
			<jsp:param name="name" value="saeva" />
			<jsp:param name="number" value="4" />					
		</jsp:include>
	</div>
	<br style="clear: both" />
	<div> </div>
</div> -->

