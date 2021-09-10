<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="java.io.File" %>

<%! 
		public void delete_recursively(File ff) {
			try {																					
				if(ff.isDirectory()) {					
					File[] flist = ff.listFiles();
					for(int i=0; i < flist.length; i++ ) {
						delete_recursively(flist[i]);
					}
					ff.delete();
				}
				else {
					ff.delete();
				}
			} catch(Exception exc) {
				// System.out.println("error while deleting directories: " + exc.getMessage());
				// TODO: make logging
				// logger.error("error while deleting directories: " + exc.getMessage());
			}
		}
			
%>

<sql:query var="pic" dataSource="${datasrc}" >
	select picture from pna_articles where id = ?
	<sql:param value="${param.id}" />
</sql:query>

<c:forEach var="r" items="${pic.rows}" >
	<c:set var="picfolder" value="${r.picture}" />
</c:forEach>

<%
	String picfolder = (String)pageContext.findAttribute("picfolder");
	String app_path = pageContext.getServletContext().getRealPath("/");
	String cat_path = "upload/articles/h/";
	File ff = new File(app_path + cat_path + picfolder);
	delete_recursively(ff);
%>
<sql:transaction dataSource="${datasource_var}"> 
	<sql:update>
		delete from pna_articles_authors where article_id = ?
		<sql:param value="${param.id}" />
	</sql:update>
	
	<sql:update>
		delete from pna_articles_places where article_id = ?
		<sql:param value="${param.id}" />
	</sql:update>
	
	<sql:update>
		delete from pna_articles where id = ?
		<sql:param value="${param.id}" />
	</sql:update>
</sql:transaction>

<jsp:forward page="../../index.jsp">
	<jsp:param name="op" value="view" />
	<jsp:param name="mode" value="bin" />	
	<jsp:param name="id" value="" />		
</jsp:forward>

