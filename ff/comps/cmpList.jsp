<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<c:set var="basepath" value="upload/articles/h/" />

<% 
	pageContext.setAttribute("order","desc"); 
	pageContext.setAttribute("sort_field","b.date");
	pageContext.setAttribute("limit","10");
	pageContext.setAttribute("mid_limit","40");		
	pageContext.setAttribute("long_limit","100");			
%>


<c:choose>
	<c:when test="${cat == 'municipality'}" >
		<c:set var="category" value="municipality" />
	</c:when>
	<c:when test="${cat == 'culture'}" >
		<c:set var="category" value="culture" />
	</c:when>
	<c:when test="${cat == 'sport'}" >
		<c:set var="category" value="sport" />
	</c:when>
	<c:when test="${cat == 'education'}" >
		<c:set var="category" value="education" />
	</c:when>
	<c:when test="${cat == 'society'}" >
		<c:set var="category" value="society" />
	</c:when>
	<c:when test="${cat == 'culture'}" >
		<c:set var="category" value="culture" />
	</c:when>
	<c:when test="${cat == 'celebrations'}" >
		<c:set var="category" value="celebrations" />
	</c:when>
	<c:when test="${cat == 'kgmk'}" >
		<c:set var="category" value="kgmk" />
	</c:when>
	<c:when test="${cat == 'neighbours'}" >
		<c:set var="category" value="neighbours" />
	</c:when>
	<c:when test="${cat == 'criminal'}" >
		<c:set var="category" value="criminal" />
	</c:when>
	<c:when test="${cat == 'culture'}" >
		<c:set var="category" value="culture" />
	</c:when>
	<c:when test="${cat == 'docs'}" >
		<c:set var="category" value="docs" />
	</c:when>
	<c:when test="${cat == 'others'}" >
		<c:set var="category" value="*" />
	</c:when>				

	<c:when test="${cat == 'nature'}" >
		<c:set var="category" value="nature" />
	</c:when>
	<c:when test="${cat == 'history'}" >
		<c:set var="category" value="history" />
	</c:when>	
	<c:when test="${cat == 'search'}" >
		<c:set var="category" value="search" />
	</c:when>			
	<c:when test="${cat == 'obituary'}" >
		<c:set var="category" value="obituary" />
	</c:when>												
	<c:when test="${cat == 'announcement'}" >
		<c:set var="category" value="announcement" />
	</c:when>		
	<c:when test="${cat == 'post'}" >
		<c:set var="category" value="post" />
	</c:when>
	<c:when test="${cat == 'opinion'}" >
		<c:set var="category" value="opinion" />
	</c:when>			
	<c:otherwise>
		<c:set var="category" value="none" />
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${param.issue != null}">
		<sql:query var="max" dataSource="${datasrc}">
			select max(number) as mm from pna_issues where year(date)=?
			<sql:param value="${year}" />
		</sql:query>
		<sql:query var="min" dataSource="${datasrc}">
			select min(number) as mn from pna_issues where year(date)=?
			<sql:param value="${year}" />
		</sql:query>	
		<c:forEach var="it" items="${max.rows}">
			<c:set var="max" value="${it.mm}" scope="page" />
		</c:forEach>
		<c:forEach var="it" items="${min.rows}">
			<c:set var="min" value="${it.mn}" scope="page" />
		</c:forEach>		
		<c:set var="issue" value="${param.issue}" />
		<div class="hpage">
			<c:set var="next" value="${issue+1}" />
			<c:set var="prev" value="${issue-1}" />
			<c:url var="prev_url" value="index.jsp">
				<c:param name="i" value="${prev}" />
			</c:url>
			<c:url var="next_url" value="index.jsp">
				<c:param name="i" value="${next}" />
			</c:url>			
			<b>Выпуски газета Печенга</b> | <a href="index.jsp"><c:out value="${year}" /></a> год 
			<span style="margin-left: 100px">
			<c:if test="${prev >= min }">
				<a href="<c:out value='${prev_url}' />">№<c:out value="${prev}" /></a> << |
			</c:if>
			<b>№<c:out value="${param.issue}" /></b>
			<c:if test="${next <= max }">
				| >> <a href="<c:out value='${next_url}' />">№<c:out value="${next}" /></a>
			</c:if>
			</span>
			
		</div>
	
		<sql:query var="articles" dataSource="${datasrc}">
						select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						and b.number = ?
						
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
				<sql:param value="${param.issue}" />
		</sql:query>				
	</c:when>
	
	<c:when test="${param.sw != null}">	
		<sql:query var="articles" dataSource="${datasrc}">
				select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
				from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
				where 
				a.issue = b.id
				and a.rubric = d.id				
				and a.contributor = c.id
				and a._status = 'active'
				and (a.text like '%<%= (String)pageContext.findAttribute("sw") %>%'
				or a.title like '%<%= (String)pageContext.findAttribute("sw") %>%')
				order by <%= (String)pageContext.findAttribute("sort_field") %>
				<%= (String)pageContext.findAttribute("order") %>
				limit <%= (String)pageContext.findAttribute("long_limit") %>
		</sql:query>
	
		<div class="search_results_header">Результаты для <strong><c:out value="${sw}" /></strong>, всего <c:out value="${articles.rowCount}" /> результатов:</div>
			
		</c:when>
	
	<c:when test="${category != 'none'}">
		<sql:query var="articles" dataSource="${datasrc}">
						select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						and d.alias = ?
						and year(b.date) = ?
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
						limit <%= (String)pageContext.findAttribute("mid_limit") %>
				<sql:param value="${category}" />
				<sql:param value="${year}" />
		</sql:query>				
	</c:when>
	<c:when test="${param.place != null}">
		<sql:query var="articles" dataSource="${datasrc}">
						select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d, pna_articles_places as e, pna_places as f
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						and a.id = e.article_id
						and e.place_id = f.id
						and f.alias = ?
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
						limit <%= (String)pageContext.findAttribute("mid_limit") %>
				<sql:param value="${param.place}" />
		</sql:query>				
	</c:when>	
	<c:otherwise>
		<sql:query var="articles" dataSource="${datasrc}">
						select a.id, a.title, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
						limit <%= (String)pageContext.findAttribute("limit") %>
		</sql:query>
	</c:otherwise>
</c:choose>


<c:forEach var="r" items="${articles.rows}">
					
	<div class="searchresult">
		<div class="picture">
			<c:choose>
				<c:when test="${r.picture == '' || r.picture == 'null' || r.picture == null}">
					<img src="ff/img/stub_picture.gif" />
				</c:when>
				<c:otherwise>
					<a href="<c:out value='${basepath}'/><c:out value='${r.picture}'/>/m.jpg"><img src='<c:out value="${basepath}"/><c:out value="${r.picture}"/>/s.jpg' /></a>							
				</c:otherwise>
			</c:choose>
		</div>
		<div class="rubric">
			<img src="ff/img/pointers/rubric.gif" />  							
				<c:url value="" var="rubric">
					<c:param name="cat" value="${r.alias}" />
				</c:url>  
				<a href="<c:out value='${rubric}' />"><c:out value="${r.name}" /></a>
		</div>											
		<div class="title">
			<c:url value="" var="full_text" scope="page">
				<c:param name="view" value="article" />
				<c:param name="id" value="${r.id}" />									 
			</c:url>
			<a href="<c:out value='${full_text}' />"><c:out value="${r.title}" /></a>
			<sql:query var="cn" dataSource="${datasrc}">
				select count(*) as num
				from pna_comments
				where article_id = ?
				<sql:param value="${r.id}" />
			</sql:query>
			<c:forEach var="rrr" items="${cn.rows}">
				<c:if test="${rrr.num > 0}">
					<span class="comments_number">(комментариев-<c:out value="${rrr.num}" />)</span>
				</c:if>
			</c:forEach>			
		</div>
		<div class="infostrip">
			<c:url value="" var="url">
				<c:param name="i" value="${r.number}" />
			</c:url>
			<span class="label">№ </span><span class="issue"><a href="<c:out value='${url}' />"><c:out value="${r.number}" /></a>
			 	<span class="date">
					(<fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" />)
				</span>
			</span>	| 							
			<span class="places">
				<sql:query var="places" dataSource="${datasrc}">
					select a.name, a.alias from pna_places as a, pna_articles_places as b 
				where b.place_id=a.id  and b.article_id=? order by a.name asc 
					<sql:param value="${r.id}" /> 
				</sql:query>
				<% int c=0; %>
				<c:forEach var="rr" items="${places.rows}">
					<% pageContext.setAttribute("c", ++c); %>
					<c:url value="" var="place">
						<c:param name="place" value="${rr.alias}" />
					</c:url>
					<a href="<c:out value='${place}' />"><c:out value="${rr.name}" /></a>
					<c:if test="${c < places.rowCount}">,</c:if>
				</c:forEach>
			</span>								
			<span class="label"> | </span><span class="authors">
				<sql:query var="authors" dataSource="${datasrc}">
				select a.penname from pna_authors as a, pna_articles_authors as b 
				where b.author_id=a.id  and b.article_id=?
					<sql:param value="${r.id}" /> 
				</sql:query>
				<% c=0; %>
				<c:forEach var="rr" items="${authors.rows}">
					<% pageContext.setAttribute("c", ++c); %>
					<c:choose>
						<c:when test="${rr.penname != 'Другой'}">
							<a href=""><c:out value="${rr.penname}" /></a>
						</c:when>
						<c:otherwise>
							...
						</c:otherwise>
					</c:choose>
					<c:if test="${c < authors.rowCount}">,</c:if>
				</c:forEach>	
			</span>
		</div>
		<br style="clear: both" />					
	</div>
</c:forEach>

