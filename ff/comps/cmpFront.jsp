<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.common.Functions" %>

<c:set var="basepath" value="upload/articles/h/" />

<% 
	pageContext.setAttribute("order","desc"); 
	pageContext.setAttribute("sort_field","a._updated");
	pageContext.setAttribute("limit","7");
%>

	
		<sql:query var="front_articles" dataSource="${datasrc}">
						select a.id, a.title, a.text, a.issue, a.picture, b.number, b.date, c.login, d.name, d.alias
						from pna_articles as a, pna_issues as b, pna_editors as c, pna_rubrics as d
						where 
						a.issue = b.id
						and a.rubric = d.id				
						and a.contributor = c.id
						and a._status = 'active'
						and a.picture != 'null'
						and d.alias != 'obituary'
						and d.alias != 'ads'
						and year(b.date) = ?
						order by <%= (String)pageContext.findAttribute("sort_field") %>
						<%= (String)pageContext.findAttribute("order") %>
						limit <%= (String)pageContext.findAttribute("limit") %>
						<sql:param value="${year}" />
		</sql:query>				

<div class="front_articles">

<div class="h" style="background: url('ff/img/bg/front_articles_h.gif') #f00; border: 2px solid #900; border-width: 0px 2px 2px 0px;">Последние статьи</div>

<% int c=0; %>
<div class="c1">
<c:forEach var="r" items="${front_articles.rows}">
<% pageContext.setAttribute("c", ++c); %>
	<c:choose>
		<c:when test="${c == 1}">
			<div class="large_box">
				<c:url value="" var="url">
					<c:param name="view" value="article" />
					<c:param name="id" value="${r.id}" />
				</c:url>
				<a href="<c:out value='${url}' />"><img class="foto" src="<c:out value='${basepath}' /><c:out value='${r.picture}' />/m.jpg" /></a>
				<div class="title">
				<a href="<c:out value='${url}' />"><c:out value='${r.title}' /></a></div>	
				<div class="bottom">
				<span class="rubric"> 
					<img src="ff/img/pointers/rubric_2.gif" />  							
					<c:url value="" var="rubric">
						<c:param name="cat" value="${r.alias}" />
					</c:url>  
					<a href="<c:out value='${rubric}' />"><c:out value="${r.name}" /></a>
				</span>
				<span class="date">/ <fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" /> /</span> <a href="<c:out value='${url}' />">Читать...</a></div>
				<br style="clear: both" />		
				<img src="ff/img/pic.gif" height="1px" width="400px" />
			</div> 		
		</c:when>
		<c:when test="${c == 2}">
			<div class="comments_box">
					<sql:query var="records" dataSource="${datasrc}">
							select b.article_id, b.id, b.datetime, b.name, b.text, a.title
							from pna_articles as a, pna_comments as b, 
							(select tmp.article_id, tmp.datetime from pna_comments as tmp order by tmp.datetime desc) as c
							where b._status='active'
							and b.article_id = a.id
							and b.article_id = c.article_id
							and b.datetime = c.datetime
							group by b.article_id
							order by b.datetime desc
							limit 9
					</sql:query>
					<h2>Комментарии читателей</h2>
					<c:forEach var="rr" items="${records.rows}">
						<c:set var="text" value="${rr.text}" />
						<%
							String text = (String)pageContext.findAttribute("text"); 
							text =""; //switch off comments
							pageContext.setAttribute("text", Functions.crop(text, 60)); 
						%>
						<c:url var="url" value="">
							<c:param name="view" value="article" />
							<c:param name="id" value="${rr.article_id}" />
						</c:url> 
						<div class="item">
							<span class="name"><c:out value="${rr.name}" />:</span>
							<span class="phrase"><a href="<c:out value='${url}' />"><c:out value="${text}" />&nbsp;<b>&gt;&gt;</b></a><br />
							<span class="commented_article"><a href="<c:out value='${url}' />"><c:out value="${rr.title}" /></a></span>
							<sql:query var="cn" dataSource="${datasrc}">
								select count(*) as num
								from pna_comments
								where article_id = ? and _status = ?
								<sql:param value="${rr.article_id}" />
								<sql:param value="active" />
							</sql:query>
							<c:forEach var="rrr" items="${cn.rows}">
								<span class="comments_number">(<c:out value="${rrr.num}" />)</span>
							</c:forEach>
						</div>
					</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<div class="small_box">
				<c:url value="" var="url">
					<c:param name="view" value="article" />
					<c:param name="id" value="${r.id}" />
				</c:url>
				<a href="<c:out value='${url}' />"><img class="foto" src="<c:out value='${basepath}' /><c:out value='${r.picture}' />/m.jpg" /></a>
				<div class="rubric"> 
				<img src="ff/img/pointers/rubric_2.gif" />  							
				<c:url value="" var="rubric">
					<c:param name="cat" value="${r.alias}" />
				</c:url>  
				<a href="<c:out value='${rubric}' />"><c:out value="${r.name}" /></a>
				</div>				
				<div class="title">
				<a href="<c:out value='${url}' />"><c:out value='${r.title}' /></a>
					<sql:query var="cn" dataSource="${datasrc}">
						select count(*) as num
						from pna_comments
						where article_id = ? and _status = ?
						<sql:param value="${r.id}" />
						<sql:param value="active" />
					</sql:query> 
					<c:forEach var="rrr" items="${cn.rows}">
						<br /><img src="ff/img/pointers/mini_pen.gif" />&nbsp;<span class="comments_number">(комментариев-<c:out value="${rrr.num}" />)</span>
					</c:forEach>
				</div>
				<div class="bottom">		
					<span class="date"><fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" /></span>
					<span class="toread">
						<a href="<c:out value='${url}' />">Читать...</a>
					</span>
				</div>				
				<div style="clear: both; font-size: 1px" > </div>
				<img src="ff/img/pic.gif" height="1px" width="400px" /> 				
			</div>
		</c:otherwise>
	</c:choose>
	<c:if test="${c == 2}"></div><!-- end 1c --><div class="c2">
			<div class="small_box">
				<c:url value="" var="url">
					<c:param name="view" value="article" />
					<c:param name="id" value="${r.id}" />
				</c:url>
				<a href="<c:out value='${url}' />"><img class="foto" src="<c:out value='${basepath}' /><c:out value='${r.picture}' />/m.jpg" /></a>
				<div class="rubric"> 
				<img src="ff/img/pointers/rubric_2.gif" />  							
				<c:url value="" var="rubric">
					<c:param name="cat" value="${r.alias}" />
				</c:url>  
				<a href="<c:out value='${rubric}' />"><c:out value="${r.name}" /></a>
				</div>				
				<div class="title">
				<a href="<c:out value='${url}' />"><c:out value='${r.title}' /></a>
					<sql:query var="cn" dataSource="${datasrc}">
						select count(*) as num
						from pna_comments
						where article_id = ? and _status = ?
						<sql:param value="${r.id}" />
						<sql:param value="active" />
					</sql:query>
					<c:forEach var="rrr" items="${cn.rows}">
						<br /><img src="ff/img/pointers/mini_pen.gif" />&nbsp;<span class="comments_number">(комментариев-<c:out value="${rrr.num}" />)</span>
					</c:forEach>
				</div>		
				<div class="bottom">		
					<span class="date"><fmt:formatDate value="${r.date}" pattern="dd.MM.yyyy" /></span>
					<span class="toread">
						<a href="<c:out value='${url}' />">Читать...</a>
					</span>
				</div>			
				<div style="clear: both; font-size: 1px" > </div>
				<img src="ff/img/pic.gif" height="1px" width="400px" /> 				
			</div>		
	</c:if> 
	<c:if test="${c == 7}"></div><!-- end 2c --></c:if> 
</c:forEach>
<br style="clear: both" />
</div>			

