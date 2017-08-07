<%@page buffer="none" language="java" contentType="text/html;charset=GBK"%><%request.setCharacterEncoding("GBK");%>
<jsp:useBean id="xcjq" scope="page" class="com.luoliang.sql.tomcat5028.dealSql"/><jsp:useBean id="util" scope="page" class="com.luoliang.upload.utils" /><html>
	<head>
    <title>小车计圈活动信息管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <style type="text/css">
      a:link {text-decoration: none;color: #006600;}
      a:hover {color: #cc0000;text-decoration: underline;}
      a:visited {text-decoration: none;color:#666666;}
    </style>
  </head>
  <script language="JavaScript" type="text/javascript" src="/datetime/WdatePicker.js"></script>
  <body leftmargin="0" topmargin="10" marginwidth="0" marginheight="0"><%
String glxx_info = "";
java.util.Calendar cal = java.util.Calendar.getInstance();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String xcjqhdmxbm = "xcjqhdmxb";

String r_opmode = request.getParameter("opmode")
      ,r_hdmc = request.getParameter("hdmc")
      ,r_hdrq = request.getParameter("hdrq")
      ,r_hdid = request.getParameter("hdid")
      ,r_hdjlbm = request.getParameter("hdjlbm")
      ,r_hdxcjlb= request.getParameter("hdxcjlb");

if(r_hdrq==null) r_hdrq = sdf.format(cal.getTime());
if(r_opmode==null) r_opmode="";

String hdjlbm_qz = "xcjqhd_"
      ,hdxcjlb_qz = hdjlbm_qz+"xcbh"
      ,hdrq_hz = r_hdrq.replace(":","").replace("-","").replace(" ","");
      
//ID	hdmc	hdrq	hdjlbm	hdxcjlb
if(r_opmode.equals("tj")){
  xcjq.setPoolname("jdbc/xcjq",this);
  String r_hdjlbm_tj = hdjlbm_qz+hdrq_hz
        ,r_hdxcjlb_tj = hdxcjlb_qz+hdrq_hz;
  if(xcjq.executeUpdate("insert into "+xcjqhdmxbm+"(hdmc,hdrq,hdjlbm,hdxcjlb) values('"+r_hdmc+"',#"+r_hdrq+"#,'"+r_hdjlbm_tj+"','"+r_hdxcjlb_tj+"')")==1){
    xcjq.executeUpdate("create table "+r_hdjlbm_tj+" (id counter,xcbh text(20),xcrqsj datetime)");
    xcjq.executeUpdate("create table "+r_hdxcjlb_tj+" (id counter,xcm text(50),xcbh text(20),xcysbh text(20),xczrxm text(50))");
    glxx_info="小车计圈活动信息添加完成！";
  }else glxx_info="小车计圈活动信息添加失败！";
}else
if(r_opmode.equals("xg")){
	xcjq.setPoolname("jdbc/xcjq",this);
	glxx_info = "小车计圈活动信息修改"+(xcjq.executeUpdate("update "+xcjqhdmxbm+" set hdmc='"+r_hdmc+"',hdrq=#"+r_hdrq+"# where id="+r_hdid)==1?"完成":"失败")+"！";
}else
if(r_opmode.equals("sc")){
	xcjq.setPoolname("jdbc/xcjq",this);
	if(xcjq.executeUpdate("delete from "+xcjqhdmxbm+" where id="+r_hdid)==1){
    xcjq.executeUpdate("drop table "+r_hdjlbm);
    xcjq.executeUpdate("drop table "+r_hdxcjlb);
    glxx_info="小车计圈活动信息删除完成！";
  }else glxx_info="小车计圈活动信息删除失败！";
}
%>

<script language="JavaScript" type="text/javascript" src="/datetime/WdatePicker.js"></script>
    <table style="WIDTH:95%" borderColor="#0000ff" cellSpacing=0 cellPadding=3 rules=rows border=1 frame=hsides align="center">
      <tr> 
        <td valign="middle" colspan="4" align="center"><b>小车计圈活动信息管理</b></td>
      </tr><%
      if(glxx_info.length()>0){
      %><tr><td colspan="4" align="center"><%=glxx_info%></td></tr>
      <%}%>
      <tr>
        <td>活动ID</td>
        <td>活动名称</td>
        <td>活动日期</td>
        <td>操作</td>
      </tr>
      <tr>
        <form name="xcjqhdxxbd" method="post">
        <td>&nbsp;</td>
        <td><input type="text" name="hdmc" value="小车测试" size="30" title="活动名称"></td>
        <td><input type="text" name="hdrq" style="width:150px"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<%=sdf.format(cal.getTime())%>"/></td>
        <td align="center">
          <input type="submit" name="action_tj" value="添加" onclick="jianchabiaodan(document.xcjqhdxxbd,3)">
          <input type="hidden" name="opmode" value="">
        </td>
        </form>
      </tr><%
				//ID	hdmc	hdrq	hdjlbm	hdxcjlb
        xcjq.setPoolname("jdbc/xcjq",this);
        java.sql.ResultSet rs_xcjq = xcjq.executeQuery("select * from "+xcjqhdmxbm);
        if(rs_xcjq!=null)
          while(rs_xcjq.next()){
            String rs_hdid=rs_xcjq.getString("ID")
                  ,rs_hdmc=rs_xcjq.getString("hdmc")
                  ,rs_hdrq=rs_xcjq.getString("hdrq")
                  ,rs_hdjlbm = rs_xcjq.getString("hdjlbm")
                  ,rs_hdxcjlb = rs_xcjq.getString("hdxcjlb");
        %>
      <tr>
        <form name="xcjqhdxxbd<%=rs_hdid%>" method="post">
        <td><a href="xcjqhd_xcbhxxgl.jsp?hdid=<%=rs_hdid%>"><%=rs_hdid%></a></td>
        <td><input type="text" name="hdmc" value="<%=rs_hdmc%>" size="30" title="活动名称"></td>
        <td><input type="text" name="hdrq" style="width:150px"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<%=rs_hdrq%>"/></td>
        <td align="center">
          <input type="submit" name="action_xg" value="修改" onclick="jianchabiaodan(document.xcjqhdxxbd<%=rs_hdid%>,1)">&nbsp;<input type="submit" name="action_sc" value="删除" onclick="jianchabiaodan(document.xcjqhdxxbd<%=rs_hdid%>,2)">
          <input type="hidden" name="opmode" value="">
          <input type="hidden" name="hdid" value="<%=rs_hdid%>">
          <input type="hidden" name="hdjlbm" value="<%=rs_hdjlbm%>">
          <input type="hidden" name="hdxcjlb" value="<%=rs_hdxcjlb%>">
        </td>
        </form>
      </tr>
          <%
          }
        xcjq.closeRsStmt();
        xcjq.freeConnection();
      %>
      <script language="javascript">
        function jianchabiaodan(bd,xiugai_shanchu){
          var isvalid = true;
          if(bd.hdmc.value.length==0){
            isvalid = false;
            alert("活动名称不能为空！");
            bd.hdmc.focus();
          }
          if(bd.hdrq.value.length==0){
            isvalid = false;
            alert("活动日期不能为空！");
            bd.hdrq.focus();
          }
          if(isvalid){
            if(xiugai_shanchu==1) bd.opmode.value="xg";
            else
            if(xiugai_shanchu==2) bd.opmode.value="sc";
            else
            if(xiugai_shanchu==3) bd.opmode.value="tj";
            bd.submit();
          }
        }
      </script>
    </table>
    <BR><BR>
  </body>
</html>
