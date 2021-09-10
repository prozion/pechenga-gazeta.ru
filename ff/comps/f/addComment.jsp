<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../../inc/taglibs.inc" %>
<%@ include file="../../inc/sql.inc" %>

<%@ page import="ru.ds.antibot.AntibotImage" %>

<jsp:useBean id="dt" class="java.util.Date" />
<c:set var="datetime">
	<fmt:formatDate value="${dt}" type="both" pattern="yyyyMMddHHmmss" />
</c:set>

<c:set var="name" value="${param.input_name}" scope="page" />
<c:set var="town" value="${param.input_town}" scope="page" />
<c:set var="text" value="${param.input_text}" scope="page" />
<c:set var="email" value="${param.input_email}" scope="page" />
<c:set var="article_id" value="${param.input_article_id}" scope="page" />
<c:set var="input_code" value="${param.input_code}" scope="page" />

<%
	String banned_ip = "0:0:0:0:0:0:0:1";
	String ip = request.getRemoteAddr(); 
	if(banned_ip.equals(ip)) pageContext.setAttribute("banned", "yes");
	pageContext.setAttribute("ip", ip);
%>


<%
	AntibotImage ai = (AntibotImage)session.getAttribute("ai");
	if(ai == null) {
		pageContext.setAttribute("code", "x");
	} else {
		pageContext.setAttribute("code", ai.getCode());
		ai.deleteFile();
		session.removeAttribute("ai");		
	}
%>

<% // 	<c:when test="${code == input_code}"> %>

<c:choose>
	<c:when test="${code == input_code }">
		<c:set var="error" value="" scope="session" />
		<sql:update dataSource="${datasrc}">
			insert into pna_comments(datetime, name, town, text, email, ip, article_id)
			values(?,?,?,?,?,?,?)
			<sql:param value="${datetime}" />
			<sql:param value="${name}" />
			<sql:param value="${town}" />
			<sql:param value="${text}" />	
			<sql:param value="${email}" />	
			<sql:param value="${ip}" />	 
			<sql:param value="${article_id}" />
		</sql:update>
	</c:when>
	<c:otherwise>
		<c:set var="error" value="wrong code" scope="session" />
	</c:otherwise>
</c:choose>

<c:set var="param.op" value="" />
<c:set var="banned" value="no" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="p" value="" />
	<jsp:param name="op" value="" />
	<jsp:param name="view" value="article" />		
	<jsp:param name="id" value="<%= (String)pageContext.getAttribute("article_id") %>" />
</jsp:forward>
 