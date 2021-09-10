<%@ page contentType="text/html;charset=utf-8" %>

<%@ include file="../inc/header.inc" %>
<%@ include file="../inc/sql.inc" %>

<%@ page import="ru.ds.pac.common.Constants, ru.ds.common.Functions" %>
 
<%@ page import="org.apache.commons.fileupload.FileItemFactory, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.servlet.ServletFileUpload, org.apache.commons.fileupload.disk.DiskFileItemFactory" %>

<%@ page import="java.io.File, java.io.OutputStream, java.io.FileOutputStream, java.util.List, java.util.Iterator" %>

<%@ page import="java.awt.Image, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.awt.Graphics2D, com.sun.image.codec.jpeg.JPEGEncodeParam, com.sun.image.codec.jpeg.JPEGImageEncoder, com.sun.image.codec.jpeg.JPEGCodec" %>

<%! protected static BufferedImage resize_toX(BufferedImage bimg, int width) {
		
		int height = (int)( width*1.0*bimg.getHeight() / bimg.getWidth() );		
		BufferedImage	img_resized = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
		Graphics2D g = img_resized.createGraphics();
		g.drawImage(bimg, 0, 0, width, height, null);
		g.dispose();
		return img_resized;	
	}
%>


<%
		
	// -- prepare to read multipart form and define filesystem paths
	FileItem fitem, imgitem = null;
	Integer id = null;
	String basepath = pageContext.getServletContext().getRealPath("/")+"upload/articles/h/";
	String dirname = Integer.toString( Math.abs((new Long((new java.util.Date()).getTime())).toString().hashCode() ) );
	pageContext.setAttribute("dirname", dirname);
		
	// -- read request
	//String realpath_base = "/home/web/20081501/home/pechenga-gazeta.ru/www";
	String realpath_base = pageContext.getServletContext().getRealPath("/");
	String realpath_suffix = "/upload/articles/h";
	String catpath = realpath_base + realpath_suffix + "/";
	
	DiskFileItemFactory dfiFactory = new DiskFileItemFactory(Constants.UPLOAD_FILE_SIZE_THRESHOLD, new File(catpath));  
	ServletFileUpload sfup = new ServletFileUpload(dfiFactory);  
	
	
	List fitems = sfup.parseRequest(request);
	
	 
		//List fitems = (new ServletFileUpload(new DiskFileItemFactory())).parseRequest((HttpServletRequest)pageContext.getRequest());  
		Iterator it = fitems.iterator();
		while(it.hasNext()) { 
			fitem = (FileItem)it.next();
			if(fitem.isFormField() ) {
				//if(fitem.getFieldName().equals("id")) id = fitem.getString();
			} else {
				imgitem = fitem;
			}
		}
		id = Integer.parseInt(request.getParameter("id"));
		pageContext.setAttribute("id", id);
		
		// -- check if image for the queried id already exists
	%>	  
		<sql:query var="records" dataSource='${datasrc}'>
		 select picture from pna_articles where id = ?
			<sql:param value="${id}" />
		</sql:query>   
		
		<c:if test="${records.rowCount > 0}" >
			<c:forEach var="row" items="${records.rows}">
				<c:set var="picture" value="${row.picture}" />
				<c:if test="${picture == null}">
					<c:set var="picture" value="" />
				</c:if>
			</c:forEach>
	<%
		// -- remove current image folder from filesystem
			File olddir = new File(catpath + (String)pageContext.getAttribute("picture") );	
		  File[] files = olddir.listFiles();
		  int len = (files == null)? 0: files.length;
		  for(int i=0; i < len; i++) files[i].delete();
		  olddir.delete();
		 	//olddir.close();
		  
		  // -- create new folder and add it to database
			//String path = basepath + dirname + "/";
			String path = catpath + dirname + "/"; 
			File newdir = new File(path);
			newdir.mkdirs();
			//newdir.close();
			  
	%>
		  <sql:update dataSource="${datasrc}">
		  	update pna_articles set picture = ? where id = ?
		  	<sql:param value="${dirname}" />
		  	<sql:param value="${id}" />
		  </sql:update>
	<% 
		  
		  // -- write upoaded file to the folder
		  String tmpfile = path + "img.tmp";
			File ff = new File(tmpfile);
			imgitem.write(ff);  
		  
		  // -- resize image to the main and thumbnail formats, write resized images to the new files
		  
		  JPEGEncodeParam encpar;
		  BufferedImage bi = ImageIO.read(ff);
		  BufferedImage resiS = resize_toX(bi, 100);
		  BufferedImage resiM = resize_toX(bi, 400);
		  OutputStream fosS = new FileOutputStream(new File(path + "s.jpg"));
		  OutputStream fosM = new FileOutputStream(new File(path + "m.jpg"));
		  JPEGImageEncoder encS = JPEGCodec.createJPEGEncoder(fosS);
		  JPEGImageEncoder encM = JPEGCodec.createJPEGEncoder(fosM);
		  
		  encpar = JPEGCodec.getDefaultJPEGEncodeParam(resiS);
		  encpar.setQuality(0.7f, true);
		  encS.setJPEGEncodeParam(encpar);
		  encS.encode(resiS);
		  
		  encpar = JPEGCodec.getDefaultJPEGEncodeParam(resiM);
		  encpar.setQuality(0.9f, true);
		  encM.setJPEGEncodeParam(encpar);
		  encM.encode(resiM);
		  
		  fosS.close();
		  fosM.close();
		  
		  // -- remove original uploaded file from the folder
		  ff.delete();
	%>
		</c:if>
			
		<c:catch var="exc">
			<% //System.out.println("Exception" + pageContext.getAttribute("exc").toString()); %>
		</c:catch>
		
	<jsp:forward page="../../index.jsp">
		<jsp:param name="op" value="view" />
		<jsp:param name="cat" value="articles" />	
		<jsp:param name="mode" value="active" />			
	</jsp:forward>	
