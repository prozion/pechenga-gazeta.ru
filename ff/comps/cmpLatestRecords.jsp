<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.common.Functions" %>
<%@ page import="java.util.Date" %>

<% 
	pageContext.setAttribute("order","desc"); 
	pageContext.setAttribute("sort_field","a._created");
	pageContext.setAttribute("limit","21");
%>

		<sql:query var="latest_records" dataSource="${datasrc}">
						select a.id, a.title, a.text, a.issue, a._created, b.number, b.date,  d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a._status = 'active'
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
						limit <%= (String)pageContext.findAttribute("limit") %>
		</sql:query>				


<div class="front_articles">

<div class="h" style="background: url('ff/img/bg/front_articles_h_blue.gif') #f00; border: 2px solid #009; border-width: 0px 2px 2px 0px; width: 300px;">Последние добавления в архив</div>


<div class="new_archive">

<c:set var="c" value="0" />
<div class="rem"><span class="f">ДОБАВЛЕНО:</span> <b>в течении суток</b> | более суток назад </div>
<% Date now = new Date(); %>
<c:forEach var="r" items="${latest_records.rows}">
	<c:set var="c" value="${c+1}" />
	<c:if test="${c == 1}" >
		<div class="cc">
	</c:if>
			<div>				
				<span class="date"><fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />.</span>
				<span class="title">
				<c:url value="" var="url">
					<c:param name="view" value="article" />
					<c:param name="id" value="${r.id}" />
				</c:url>
				<c:set var="created" value="${r._created}" />
				<c:set var="title" value="${r.title}" />
<%
	Date created = (Date)pageContext.findAttribute("created");
	long diff = (now.getTime() - created.getTime())/1000/60/60;
	pageContext.setAttribute("diff", diff);
	String cropped_title = Functions.crop((String)pageContext.findAttribute("title"), 35);
%>				
				<a href="<c:out value='${url}' />">
					<c:if test="${diff < 24}"><b></c:if>
						 <%= cropped_title %>
					<c:if test="${diff < 24}"></b></c:if>
				</a>
				</span>		 				
			</div>
	<c:if test="${c == 7 || c == 14}" >
		</div><div class="cc">
	</c:if>
	<c:if test="${c == 21}" >
		</div>
	</c:if>			
</c:forEach>
<br style="clear: both" />
<div> </div>
</div>

</div>			

