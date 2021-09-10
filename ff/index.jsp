<%@ page contentType="text/html; charset=utf-8"%>

<%@ include file="inc/taglibs.inc"%>
<%@ include file="inc/sql.inc"%>

<%
	session.setMaxInactiveInterval(1800);
%>

<html>
<head>
<title>Газета Печенга. Печенгский район. Новости и свежая
информация</title>
<meta name="keywords"
	content="Печенгский район, Киркенес, Печенга, Заполярный, Никель, Помор-зона, Штокман, Рыбачий" />
<meta name="description"
	content="Печенга. Центральная газета Печенгского района. Новости Никеля, Заполярного, российско-норвежского приграничья." />
<link rel='icon' href='ff/img/favicon/favicon.ico' type='image/x-icon' />
<link rel='shortcut icon' href='ff/img/favicon/favicon.ico'
	type='image/x-icon' />
<link href="ff/styles/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="ff/js/functions.js"> </script>

<!-- begin of Top100 code -->
<script id="top100Counter" type="text/javascript"
	src="http://counter.rambler.ru/top100.jcn?1501452"></script>
<noscript><img
	src="http://counter.rambler.ru/top100.cnt?1501452" alt="" width="1"
	height="1" border="0"></noscript>
<!-- end of Top100 code -->

</head>
<body>

<div class="toppest_menu"><span><a href="index.jsp"><b>Начало</b></a></span>
<span><a href="?p=maps">Карты и схемы</a></span> <span><a
	href="?p=reference">Справочник</a></span> <span><a href="?p=links">Печенгский
район в интернете</a></span></div>

<table width="100%">
	<tr>
		<td align="center" valign="top">

		<div class="canvas"><%@ include file="inc/header.block"%>

		<c:choose>
			<c:when test="${param.year == null && year == null}">
				<c:set var="year" value="2012" scope="session" />
			</c:when>
			<c:when test="${param.year != null}">
				<c:set var="year" value="${param.year}" scope="session" />
			</c:when>
		</c:choose>

		<div class="r_middle"><c:choose>
			<c:when test="${param.op == 'addmsg'}">
				<jsp:include page="comps/f/addMsg.jsp" />
			</c:when>
			<c:when test="${param.op == 'addcomment'}">
				<jsp:include page="comps/f/addComment.jsp" />
			</c:when>
			<c:when test="${param.sw != null}">
				<c:set var="view" value="search_result" scope="request" />
				<c:set var="sw" value="${param.sw}" scope="request" />
				<c:remove var="cat" />
			</c:when>
			<c:when test="${param.view != null}">
				<c:set var="view" value="${param.view}" scope="request" />
			</c:when>
			<c:when test="${param.i != null}">
				<c:set var="view" value="issue" scope="request" />
				<c:set var="issue" value="${param.i}" />
				<c:remove var="cat" />
			</c:when>
			<c:when test="${param.p != null}">
				<c:set var="view" value="page" scope="request" />
				<c:set var="p" value="${param.p}" />
			</c:when>
			<c:when test="${param.mode != null}">
				<c:set var="view" value="mode" scope="request" />
				<c:set var="mode" value="${param.mode}" scope="session" />
			</c:when>
			<c:when test="${param.cat != null}">
				<c:set var="view" value="list" />
				<c:set var="cat" value="${param.cat}" scope="session" />
			</c:when>
			<c:when test="${param.place != null}">
				<c:set var="view" value="list" />
				<c:set var="place" value="${param.place}" scope="request" />
				<c:remove var="cat" />
			</c:when>
			<c:otherwise>
				<c:set var="view" value="frontpage" scope="request" />
			</c:otherwise>
		</c:choose> <!-- search panel -->
		<div class="searchbox">
		<div>
		<form action="" method="post" class="search">
		<div style="font-family: Arial; font-size: 10pt;">Искать в
		газете Печенга:</div>
		<input type="text" name="sw" size="20" /> <input type="submit"
			value="Найти" /></form>
		</div>
		<div style="margin-left: 100px;">
		<form id="yf" method="post" action="">
		<div style="font-family: Arial; font-size: 10pt;">Год:</div>
		<select name="year" onChange="activateForm('yf')">
			<option value="<c:out value='1949' />"><c:out
							value='1949' /></option>
			<option value="<c:out value='1950' />"><c:out
							value='1950' /></option>
			<c:forEach var="y" begin="2003" end="2012">
				<c:choose>
					<c:when test="${year == y}">
						<option value="<c:out value='${y}' />" selected><c:out
							value='${y}' /></option>
					</c:when>
					<c:otherwise>
						<option value="<c:out value='${y}' />"><c:out
							value='${y}' /></option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select></form>
		</div>
		<div style="margin-left: 50px"><jsp:include
			page="comps/cmpStat.jsp" /></div>
		<!--<div class="h">панель поиска</div>--> <br />
		<p></p>
		</div>

		<!-- middle content --> <c:choose>
			<c:when test="${view == 'page'}">
				<c:choose>
					<c:when test="${p == 'licenses'}">
						<jsp:include page="html/licenses.jsp" />
					</c:when>
					<c:when test="${p == 'prices'}">
						<jsp:include page="html/prices.jsp" />
					</c:when>
					<c:when test="${p == 'maps'}">
						<jsp:include page="html/maps.jsp" />
					</c:when>
					<c:when test="${p == 'reference'}">
						<jsp:include page="html/reference.jsp" />
					</c:when>
					<c:when test="${p == 'links'}">
						<jsp:include page="html/links.jsp" />
					</c:when>
					<c:when test="${p == 'reqs'}">
						<jsp:include page="html/reqs.jsp" />
					</c:when>
					<c:when test="${p == 'guestbook'}">
						<jsp:include page="comps/cmpGuestbook.jsp" />
					</c:when>
				</c:choose>
			</c:when>
			<c:when test="${view == 'frontpage'}">
				<jsp:include page="comps/cmpFront.jsp" />
				<!--<jsp:include page="comps/cmpNonPrinted.jsp" />-->
				<jsp:include page="comps/cmpPreCore.jsp" />
				<jsp:include page="comps/cmpCore.jsp" />
				<jsp:include page="comps/cmpLatestRecords.jsp" />
			</c:when>
			<c:when test="${view == 'list'}">
				<jsp:include page="comps/cmpList.jsp" />
			</c:when>
			<c:when test="${view == 'article'}">
				<jsp:include page="comps/cmpArticle.jsp" />
			</c:when>
			<c:when test="${view == 'search_result'}">
				<jsp:include page="comps/cmpList.jsp">
					<jsp:param name="sw" value="<%=pageContext.findAttribute("sw")%>" />
				</jsp:include>
			</c:when>
			<c:when test="${view == 'issue'}">
				<jsp:include page="comps/cmpList.jsp">
					<jsp:param name="issue"
						value="<%=pageContext.findAttribute("issue")%>" />
				</jsp:include>
			</c:when>
			<c:otherwise>
				<jsp:include page="comps/cmpFront.jsp" />
				<jsp:include page="comps/cmpCore.jsp" />
				<jsp:include page="comps/cmpLatestRecords.jsp" />
			</c:otherwise>
		</c:choose>

		<div class="places_strip">
		<div class="hpage"
			style="background: url('ff/img/bg/front_articles_h.gif') #f00; border: 2px solid #900; border-width: 0px 2px 2px 0px;">Города
		в фокусе</div>
		<div class="line"><span><a href="?place=nikel"><img
			src="ff/img/towns/n.jpg" /></a></span> <span><a href="?place=pechenga"><img
			src="ff/img/towns/p.jpg" /></a></span> <span><a href="?place=zap"><img
			src="ff/img/towns/z.jpg" /></a></span> <span><a href="?place=kirkenes"><img
			src="ff/img/towns/k.jpg" /></a></span> <span><a href="?place=korzunovo"><img
			src="ff/img/towns/kor.jpg" /></a></span> <span><a
			href="?place=rajakoski"><img src="ff/img/towns/r.jpg" /></a></span> <span><a
			href="?place=sputnik"><img src="ff/img/towns/s.jpg" /></a></span></div>
		</div>

		</div>

		<div class="secondary_nav"><span><a href="?p=guestbook">Ваши
		предложения по сайту!</a></span> <span><a href="?p=prices">Расценки на
		услуги</a></span></div>

		<div class="r_footer">
		<div class="wrapper">
		<div class="c">
		<div><b>Газета Печенга</b></div>
		<div>2009 &copy; МУП Печенга</div>
		<div><a href="?p=reqs" style="font-weight: bold;">Информация
		о компании</a></div>
		<div><a href="?p=licenses">Лицензии и свидетельства</a></div>
		<div class="h2">email (редакция):</div>
		<div><a href="mailto:pechenga@mail.ru">pechenga@mail.ru</a></div>
		<!-- <div class="h2">email (вебмастер):</div>
		<div><a href="mailto:feedback@pechenga-gazeta.ru">feedback@pechenga-gazeta.ru</a></div>-->
		</div>

		<div class="c">
		<div class="h2">ТЕЛЕФОНЫ (8-815-54):</div>
		<div><b>приемная:</b> 5-20-77</div>
		<div><b>директор:</b> 5-02-39</div>
		<div><b>гл. редактор:</b> 5-14-21</div>
		<div><b>журналисты Никель:</b></div>
		<div>5-14-21, 5-16-37, 5-20-78</div>
		<div><b>коррпункт Заполярный:</b></div>
		<div>3-89-99</div>
		</div>

		<div class="c">
		<div class="h2">ТЕЛЕФОНЫ (8-815-54):</div>
		<div><b>студия Печенга-ТВ:</b> 5-08-69</div>
		<div><b>бухгалтерия:</b> 5-18-55</div>
		<div><b>служба доставки газеты, печатный отдел:</b></div>
		<div>5-17-83</div>
		</div>

		<div class="c">
		<div class="h2">ТЕЛЕФОНЫ (8-815-54):</div>
		<div><b>пункты приема подписки и объявлений:</b></div>
		<div>Никель - 5-15-28,</div>
		<div>Заполярный - 3-89-99</div>
		</div>

		<div style="clear: both"></div>
		</div>
		</div>

		<div class="banners"><a
			href="http://yandex.ru/cy?base=0&amp;host=pechenga-gazeta.ru"><img
			src="http://www.yandex.ru/cycounter?pechenga-gazeta.ru" width="88"
			height="31" alt="Яндекс цитирования" border="0" /></a> <!-- murman.ru -->
		<a href="http://www.murman.ru/"><img
			src="http://www.murman.ru/images/buttons/button-5.gif" width="88"
			height="31" border=0 alt="murman.ru"></a> <!--/ murman.ru --> <!-- SpyLOG -->
		<script src="http://tools.spylog.ru/counter_cv.js" id="spylog_code"
			type="text/javascript" counter="1094582" part="" track_links="ext"
			page_level="0">
</script>
		<noscript><a
			href="http://u10945.82.spylog.com/cnt?cid=1094582&f=3&p=0"
			target="_blank"> <img
			src="http://u10945.82.spylog.com/cnt?cid=1094582&p=0" alt="SpyLOG"
			border="0" width="88" height="31"></a></noscript>
		<!--/ SpyLOG --> <!--Rating@Mail.ru COUNTER--><script
			language="JavaScript" type="text/javascript"><!--
d=document;var a='';a+=';r='+escape(d.referrer)
js=10//--></script><script language="JavaScript1.1" type="text/javascript"><!--
a+=';j='+navigator.javaEnabled()
js=11//--></script><script language="JavaScript1.2" type="text/javascript"><!--
s=screen;a+=';s='+s.width+'*'+s.height
a+=';d='+(s.colorDepth?s.colorDepth:s.pixelDepth)
js=12//--></script><script language="JavaScript1.3" type="text/javascript"><!--
js=13//--></script><script language="JavaScript" type="text/javascript"><!--
d.write('<a href="http://top.mail.ru/jump?from=1504877"'+
' target="_top"><img src="http://d6.cf.b6.a1.top.mail.ru/counter'+
'?id=1504877;t=56;js='+js+a+';rand='+Math.random()+
'" alt="Рейтинг@Mail.ru"'+' border="0" height="31" width="88"/><\/a>')
if(11<js)d.write('<'+'!-- ')//--></script>
		<noscript><a target="_top"
			href="http://top.mail.ru/jump?from=1504877"><img
			src="http://d6.cf.b6.a1.top.mail.ru/counter?js=na;id=1504877;t=56"
			border="0" height="31" width="88" alt="Рейтинг@Mail.ru" /></a></noscript>
		<script language="JavaScript" type="text/javascript"><!--
if(11<js)d.write('--'+'>')//--></script> <!--/COUNTER--> <!--LiveInternet counter-->
		<script type="text/javascript">
	document.write("<a href='http://www.liveinternet.ru/click' "
			+ "target=_blank><img src='http://counter.yadro.ru/hit?t12.8;r"
			+ escape(document.referrer)
			+ ((typeof (screen) == "undefined") ? "" : ";s"
					+ screen.width
					+ "*"
					+ screen.height
					+ "*"
					+ (screen.colorDepth ? screen.colorDepth
							: screen.pixelDepth)) + ";u" + escape(document.URL)
			+ ";" + Math.random()
			+ "' alt='' title='LiveInternet: показано число просмотров за 24"
			+ " часа, посетителей за 24 часа и за сегодня' "
			+ "border=0 width=88 height=31><\/a>")//
</script> <!--/LiveInternet--> <a href='http://top.gde.ru/newspapers.html'
			target=_blank><img
			src='http://top.gde.ru/isapi/tracker.dll?T?33200&6'
			alt='Топ100 - Газеты' width=88 height=31 border=0></a> <!-- begin of Top100 logo -->
		<a href="http://top100.rambler.ru/top100/"><img
			src="http://top100-images.rambler.ru/top100/banner-88x31-rambler-black2.gif"
			alt="Rambler's Top100" width="88" height="31" border="0" /></a> <!-- end of Top100 logo -->

		</div>

		</div>
		<div style="text-align: center">
			<a href="http://www2.clustrmaps.com/counter/maps.php?url=http://pechenga-gazeta.ru" id="clustrMapsLink"><img src="http://www2.clustrmaps.com/counter/index2.php?url=http://pechenga-gazeta.ru" style="border:0px;" alt="Locations of visitors to this page" title="Locations of visitors to this page" id="clustrMapsImg" onerror="this.onerror=null; this.src='http://clustrmaps.com/images/clustrmaps-back-soon.jpg'; document.getElementById('clustrMapsLink').href='http://clustrmaps.com';" />
</a>
		</div>
		</td>
	</tr>
</table>
</body>
</html>
