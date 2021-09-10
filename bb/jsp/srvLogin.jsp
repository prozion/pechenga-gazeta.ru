<%@ page contentType="text/html;charset=utf-8" %>

<html>
<head>		
	<title>Админцентр / Логин</title>
	<link href="styles/styles.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/functions.js">
  </script>  
</head>

<div style="margin: 100px 0px 20px 30px">
</div>	

<div class="SectionHeader" style="margin: 0px 0px 0px 12px">
Администрирование сайта
</div>	

<div style="text-align: left">
<div id="acMainPanel">	
<form action="?op=login" method="post">
  <table width="100%" style="margin: 0px 0px 0px 10px">	
    <tr>
      <td>
        <span>Логин:</span> 
      </td>
      <td>
        <input type="text" size="30" name="usr" />
      </td>
    </tr>
    <tr>
      <td>
        <span>Пароль:</span> 
      </td>
      <td>
        <input type="password" size="30" name="pwd" />
      </td>
    </tr>
    <tr>
      <td> 
      </td>
      <td>
        <input type="submit" value="Ok" />
      </td>
    </tr>        
  </table>
</form>
</div>
</div>

</body>
</html>

			
