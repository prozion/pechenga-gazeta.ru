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
<c:set var="input_code" value="${param.input_code}" scope="page" />

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

<c:choose>
	<c:when test="${code == input_code}">
		<c:set var="error" value="" scope="session" />
		<sql:update dataSource="${datasrc}">
			insert into pna_messages(datetime, name, town, text)
			values(?,?,?,?)
			<sql:param value="${datetime}" />
			<sql:param value="${name}" />
			<sql:param value="${town}" />
			<sql:param value="${text}" />	
		</sql:update>
	</c:when>
	<c:otherwise>
		<c:set var="error" value="wrong code" scope="session" />
	</c:otherwise>
</c:choose>

<c:set var="param.op" value="" />
<jsp:forward page="../../index.jsp">
	<jsp:param name="p" value="guestbook" />
	<jsp:param name="op" value="" />	
</jsp:forward>
