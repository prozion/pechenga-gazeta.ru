<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="inc/header.inc" %>
<%@ include file="inc/sql.inc" %>

<html>
<head>		
	<title>Управление контентом</title>
	<link href="styles/styles.css" rel="stylesheet" type="text/css" />
	<link href="styles/calendar-win2k-1.css" rel="stylesheet" type="text/css" />	
	<script type="text/javascript" src="js/pac.js"></script>
	<script type="text/javascript" src="js/calendar/calendar.js"></script>
	<script type="text/javascript" src="js/calendar/calendar-ru.js"></script>
	<script type="text/javascript" src="js/calendar/helper.js"></script>		
	<script type="text/javascript" src="js/fckeditor/fckeditor.js"></script>
</head>
		
<body style="margin: 0; padding: 0; background-image: url('img/bg2.gif')">  			
		<table width="100%" cellspacing="0" cellpadding="0" style="background-color: #d7d3cb">
		  <tr>
			 <td style="background-color: #88a09f"><img src="img/empty.gif" height="10"><td>
			</tr>			
		  <tr>
			 <td><img src="img/empty.gif" width="800" height="2"></td>
			</tr>	
			<tr>
			 <td style="background-color: #888"><img src="img/empty.gif"  height="1"></td>
			</tr>
			<tr>
			 <td style="background-color: #fff"><img src="img/empty.gif" height="1"></td>
			</tr>
     </table>		
			
		<table width="100%" cellspacing="0" cellpadding="0" class="acMenuBar">
		<tr>
			 <td><img src="img/empty.gif" width="800" height="1"></td>
			</tr>
      <tr><td>
        <span class="acMenuItem" style="left: 0px;">
          <a href=".." style="cursor: default;" target="_blank">
            <strong>Просмотр сайта</strong>
          </a>
        </span>
      
      <span class="acMenuItem" style="left: 120px;">
  				<a onClick="toggleMenu('viewContentList', this)" style="cursor: default;">
            <span style="text-decoration: underline">К</span>онтент
          </a>
        </span>

        <span class="acMenuItem" style="left: 240px; vertical-align: top">
          <a onClick="toggleMenu('viewMenusList', this)" style="cursor: default;">
            <span style="text-decoration: underline">М</span>еню
          </a>
        </span>
        
        <span class="acMenuItem" style="left: 360px;">
          <a onClick="toggleMenu('popupSettings', this)" style="cursor: default;">
            <span style="text-decoration: underline">Н</span>астройки
          </a>
        </span>
        
        <span class="acMenuItem" style="left: 480px;">
          <a onClick="alert('Панель управления сайтом PAC v0.2\n 2007-2010 © prozion')" style="cursor: default;">
            С<span style="text-decoration: underline">п</span>равка
          </a>
        </span></tr></td>
		</table>
			
		<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
			 <td style="background-color: #888"><img src="img/empty.gif" width="800" height="1"><td>
			</tr>	
		</table>        
  
  <div style="margin: 50px 0px 0px 0px;"></div>  
	
  <div id="acMainPanel">

			<c:set var="op" value="${param.op}" scope="page" />
			<c:set var="mode" value="${param.mode}" scope="page" />
			
			<c:if test="${op == '' || op == null}">
				<c:set var="op" value="view" />
			</c:if>
			<c:if test="${param.cat != null}">
				<c:set var="cat" value="${param.cat}" scope="session" />
			</c:if>
			<c:if test="${cat == '' || cat == null}">
				<c:set var="cat" value="articles" scope="session" />
			</c:if>
			<c:if test="${mode == '' || mode == null}">
				<c:set var="mode" value="active" />
			</c:if>
  
	  	<c:choose>
	  		<c:when test="${op == 'view'}">
	  			<c:if test="${cat == 'articles'}">
	  				<c:if test="${mode == 'active'}">
							<jsp:include page="articles/acArticles.jsp" />
						</c:if>
	  				<c:if test="${mode == 'bin'}">
							<jsp:include page="articles/acArticlesBin.jsp" />
						</c:if>
	  				<c:if test="${mode == 'w_demo'}">
							<jsp:forward page="articles/wArticleDemo.jsp" />
						</c:if>						
	  				<c:if test="${mode == 'ew_add'}">
							<jsp:include page="articles/ewAddArticle.jsp" />
						</c:if>
	  				<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="articles/ewEditArticle.jsp" />
						</c:if>
	  				<c:if test="${mode == 'ew_upload'}">
							<jsp:include page="articles/ewUploadArticleImg.jsp" />
						</c:if>																								
					</c:if>			
	  			<c:if test="${cat == 'issues'}">
	  				<c:if test="${mode == 'active'}">
							<jsp:include page="issues/acIssues.jsp" />
						</c:if>			
						<c:if test="${mode == 'ew_add'}">
							<jsp:include page="issues/ewAddIssue.jsp" />
						</c:if>								
						<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="issues/ewEditIssue.jsp" />
						</c:if>						
					</c:if>	
					<c:if test="${cat == 'msg'}">
						<c:if test="${mode == 'active'}">
							<jsp:include page="messages/acMessages.jsp" />
						</c:if>
						<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="messages/ewEditMessage.jsp" />
						</c:if>	
					</c:if>
					<c:if test="${cat == 'comment'}">
						<c:if test="${mode == 'active'}">
							<jsp:include page="comments/acComments.jsp" />
						</c:if>
						<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="comments/ewEditComment.jsp" />
						</c:if>	
					</c:if>
					<c:if test="${cat == 'events'}">
						<c:if test="${mode == 'active'}">
							<jsp:include page="events/acEvents.jsp" />
						</c:if>
						<c:if test="${mode == 'ew_add'}">
							<jsp:include page="events/ewAddEvent.jsp" />
						</c:if>	
						<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="events/ewEditEvent.jsp" />
						</c:if>	
					</c:if>	
					<c:if test="${cat == 'videos'}">
						<c:if test="${mode == 'active'}">
							<jsp:include page="videos/acVideos.jsp" />
						</c:if>
						<c:if test="${mode == 'ew_add'}">
							<jsp:include page="videos/ewAddVideo.jsp" />
						</c:if>	
						<c:if test="${mode == 'ew_edit'}">
							<jsp:include page="videos/ewEditVideo.jsp" />
						</c:if>	
					</c:if>																						
				</c:when>
				
	  		<c:when test="${op == 'add'}">
	  			<c:if test="${cat == 'articles'}">
	  				<jsp:include page="articles/fAddArticle.jsp" />
					</c:if>	
					<c:if test="${cat == 'issues'}">
	  				<jsp:include page="issues/fAddIssue.jsp" />
					</c:if>
					<c:if test="${cat == 'events'}">
	  				<jsp:include page="events/fAddEvent.jsp" />
					</c:if>
					<c:if test="${cat == 'videos'}">
	  				<jsp:include page="videos/fAddVideo.jsp" />
					</c:if>
				</c:when>
				
				<c:when test="${op == 'edit'}">
	  				<c:if test="${cat == 'articles'}">
						<jsp:include page="articles/fEditArticle.jsp" />
					</c:if>	  
					<c:if test="${cat == 'msg'}">
						<jsp:include page="messages/fEditMessage.jsp" />
					</c:if>		
					<c:if test="${cat == 'events'}">
						<jsp:include page="events/fEditEvent.jsp" />
					</c:if>	
					<c:if test="${cat == 'videos'}">
						<jsp:include page="videos/fEditVideo.jsp" />
					</c:if>
					<c:if test="${cat == 'issues'}">
	  				<jsp:include page="issues/fEditIssue.jsp" />
					</c:if>	 
					<c:if test="${cat == 'comment'}">
	  				<jsp:include page="comments/fEditComment.jsp" />
					</c:if>	  					
				</c:when>
				
				<c:when test="${op == 'upload'}">
					<c:if test="${cat == 'articles'}">
						<jsp:include page="articles/fUploadArticleImg.jsp" />
					</c:if>	  		
				</c:when>				
				
				<c:when test="${op == 'move'}">
					<c:if test="${cat == 'articles'}">
						<jsp:include page="articles/fMoveArticle.jsp" />
					</c:if>				
					<c:if test="${cat == 'issues'}">
	  				<jsp:include page="issues/fMoveIssue.jsp" />
					</c:if>	 																	
				</c:when>

				<c:when test="${op == 'restore'}">
					<c:if test="${cat == 'articles'}">
						<jsp:include page="articles/fRestoreArticle.jsp" />
					</c:if>											
				</c:when>
				
				<c:when test="${op == 'delete'}">
					<c:if test="${cat == 'articles'}">
						<jsp:include page="articles/fDeleteArticle.jsp" />
					</c:if>			
					<c:if test="${cat == 'msg'}">
						<jsp:include page="messages/fDeleteMessage.jsp" />
					</c:if>
					<c:if test="${cat == 'events'}">
						<jsp:include page="events/fDeleteEvent.jsp" />
					</c:if>
					<c:if test="${cat == 'videos'}">
						<jsp:include page="videos/fDeleteVideo.jsp" />
					</c:if>
					<c:if test="${cat == 'comment'}">
						<jsp:include page="comments/fDeleteComment.jsp" />
					</c:if>
				</c:when>
				
				<c:when test="${op == 'logout'}">
					<jsp:include page="f/fLogout.jsp" />					
				</c:when>							
				
				<c:otherwise>
					<jsp:include page="articles/acArticles.jsp" />
				</c:otherwise>										
			</c:choose>            
  </div>
  
  
<!------------ Popup windows ---------->  
  <div id="viewContentList" class="acPopupMenu">
  <table width="150px" cellspacing="0" cellpadding="0"> 
    <tr><td style="padding: 3px 0px 3px 0px; ">
    	<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="articles" />
				<c:param name="mode" value="active" />
			</c:url>    
    	<a href='<c:out value="${url}" />'>Статьи</a>
    </td></tr>
    <tr><td style="padding: 3px 0px 3px 0px; ">
    	<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="events" />
				<c:param name="mode" value="active" />
			</c:url>    
    	<a href='<c:out value="${url}" />'>Анонсы</a>
    </td></tr>
    <tr><td style="padding: 3px 0px 3px 0px; ">
    	<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="videos" />
				<c:param name="mode" value="active" />
			</c:url>    
    	<a href='<c:out value="${url}" />'>Видео</a>
    </td></tr>
    <tr><td style="padding: 3px 0px 3px 0px; ">
    	<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="msg" />
				<c:param name="mode" value="active" />
			</c:url>    
    	<a href='<c:out value="${url}" />'>Отзывы</a>
    </td></tr>
    <tr><td style="padding: 3px 0px 3px 0px; ">
    	<c:url value="index.jsp" var="url">
				<c:param name="op" value="view" />
				<c:param name="cat" value="comment" />
				<c:param name="mode" value="active" />
			</c:url>    
    	<a href='<c:out value="${url}" />'>Комментарии</a>
    </td></tr>
    <tr><td style="padding: 3px 0px 0px 0px"><img src="img/empty.gif" style="background-color: #888;" height="1" width="100%"></td></tr>
     <tr><td style="padding: 0px 0px 3px 0px"><img src="img/empty.gif"  height="1" width="100%" style="background-color: #fff;"></td></tr>    
    <tr><td style="padding: 3px 0px 5px 0px; ">    
    <c:url value="" var="url">
			<c:param name="op" value="view" />	
			<c:param name="cat" value="issues" />					 
			<c:param name="mode" value="active" />
		</c:url>
		<a href="<c:out value='${url}' />">Выпуски газеты</a>
    </td></tr>		
  </table> 
  </div>
  
  <div style="margin: 50px 0px 0px 0px"></div>

  <div id="viewMenusList" class="acPopupMenu" > 
  <table width="150px" cellspacing="0" cellpadding="0">  
    <tr><td style="padding: 3px 0px; ">
			<a style="color: #999">О газете</a>
    </td></tr>
    <tr><td style="padding: 3px 0px; ">
			<a style="color: #999">Коллектив</a>
    </td></tr>
  </table>
  </div>
  
  <div id="popupSettings" class="acPopupMenu">
  <table width="150px" cellspacing="0" cellpadding="0">
    <tr><td style="padding: 3px 0px;"><a style="color: #999">Пользователи
    </a></td></tr>
    <tr><td style="padding: 3px 0px 0px 0px"><img src="img/empty.gif" style="background-color: #888;" height="1" width="100%"></td></tr>
     <tr><td style="padding: 0px 0px 3px 0px"><img src="img/empty.gif"  height="1" width="100%" style="background-color: #fff;"></td></tr>                  
     <tr><td style="padding: 3px 0px; "><a style="color: #999">Опции просмотра</a></td></tr>                  
  </table>
  </div>          
  
</body>
</html>
      
