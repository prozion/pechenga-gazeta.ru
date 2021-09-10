<%@ page contentType="text/html;charset=utf-8" %>

<%@ taglib uri='jstl/c' prefix='c' %>

<c:set var="res" value="" scope="request" />
<jsp:include page="jsp/f/fVerifyLogin.jsp" />

<c:choose>
	<c:when test="${res == 'true'}">	
		<jsp:include page="jsp/srvMain.jsp" /> 
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${param.op == 'login'}"> 
				<jsp:include page="jsp/f/fLogin.jsp" />
			</c:when>
			<c:otherwise>
				<!-- returns op='login' back here with parameters of username and password. After that parameters are used in fLogin.jsp to register the user (current_user scoped variable):--> 
				<jsp:include page="jsp/srvLogin.jsp" /> 	
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>