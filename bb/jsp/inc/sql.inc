<sql:setDataSource url="jdbc:mysql://localhost:3306/20081501_1" user="b20081501_1" password="iKJhrnMJ" driver="org.gjt.mm.mysql.Driver" var="datasource_var" />

<% // aliases %>
<c:set var="datasource" value="${datasource_var}" scope="request" />
<c:set var="datasrc" value="${datasource_var}" scope="request" />
