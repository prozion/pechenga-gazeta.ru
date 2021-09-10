<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%
	int index=0;
	String [] months = {"Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"};
%>


<div class="calendar">
	<c:forEach var="row" begin="1" end="4">
		<div class="row">
			<c:forEach var="col" begin="1" end="3">
				<div class="col">
					<div class="hh">
						<% index = (	((Integer)pageContext.findAttribute("row")).intValue() -1)*3 + ((Integer)pageContext.findAttribute("col")).intValue(); 
						 %>
						 <%= months[index - 1] %>
					</div>
					<div class="issues">
						<jsp:include page="subs/subMonth.jsp">
							<jsp:param name="month" value="<%= index %>" />
						</jsp:include>
					</div>
				</div>
			</c:forEach>			
		</div>
	</c:forEach>		
	<div class="row"> </div>
</div>
