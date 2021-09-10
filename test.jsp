<%@ taglib uri="jstl/c" prefix="c" %>

<%@ page import="java.util.*" %>

<%

List<Integer> a1 = new ArrayList();
List<Integer> a2 = new ArrayList();

for(int i=0; i<10; i++) {
	a1.add(i, new Integer(i));
}

for(int j=0; j<5; j++) {
	a2.add(j, new Integer(j));			
}

pageContext.setAttribute("a1", a1);
pageContext.setAttribute("a2", a2);

%>

<c:forEach var="i" items="${a1}">
	<c:forEach var="j" items="${a2}">
		j = <c:out value="${j}" /> , i = <c:out value="${i}" /><br />
	</c:forEach>
</c:forEach>
