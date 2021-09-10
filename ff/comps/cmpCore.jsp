<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/taglibs.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.common.Functions" %>

<div class="core">

<!--<div class="c" style="width: 205px">
	<div class="h" style="background: url('ff/img/bg/front_articles_h.gif') #f00; border: 2px solid #900; border-width: 0px 2px 2px 0px;">Вне номера</div>
	<div>
	</div>
</div>-->

<div class="c" style="width: 420px; margin-right: 10px;">
	<div class="h" style="background: url('ff/img/bg/front_articles_h.gif') #f00; border: 2px solid #900; border-width: 0px 2px 2px 0px;">Авторы</div>
	<div>
		<jsp:include page="cmpAuthors.jsp" />
	</div>
</div>

<div class="c" style="width: 450px">
	<div class="h" style="background: url('ff/img/bg/front_articles_h.gif') #f00; border: 2px solid #900; border-width: 0px 2px 2px 0px;">Выпуски в <c:out value="${year}" /> году</div>
	<div>
		<jsp:include page="cmpCalendar.jsp" />
	</div>
</div>

<br style="clear: both" />

</div>

