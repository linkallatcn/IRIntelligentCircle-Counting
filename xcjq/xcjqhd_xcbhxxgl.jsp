<%@page buffer="none" language="java" contentType="text/html;charset=GBK"%><%request.setCharacterEncoding("GBK");%>
<jsp:useBean id="xcjq" scope="page" class="com.luoliang.sql.tomcat5028.dealSql"/><jsp:useBean id="util" scope="page" class="com.luoliang.upload.utils" /><html>
	<head>
    <title>С�������Ϣ����</title>
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

String xcjqbm = "xcjqhd_20161226"
      ,xcjqhdmxbm = "xcjqhdmxb"
      ,hdxcjlbm = "xcjqhd_xcbh_20161226";

String r_opmode = request.getParameter("opmode")
      ,r_hdid = request.getParameter("hdid")
      ,r_xcm = request.getParameter("xcm")
      ,r_xcbh = request.getParameter("xcbh")
      ,r_xcysbh = request.getParameter("xcysbh")
      ,r_xczrxm = request.getParameter("xczrxm")
      ,r_xcid = request.getParameter("xcid");

if(r_opmode==null) r_opmode="";

String rs_hdmc=""
      ,rs_hdrq="";

if(r_hdid!=null){
  xcjq.setPoolname("jdbc/xcjq",this);
  java.sql.ResultSet rs_xcjq_hd = xcjq.executeQuery("select * from "+xcjqhdmxbm+" where id="+r_hdid);
  if(rs_xcjq_hd!=null && rs_xcjq_hd.next()){
    rs_hdmc = rs_xcjq_hd.getString("hdmc");
    rs_hdrq = rs_xcjq_hd.getString("hdrq");
    xcjqbm = rs_xcjq_hd.getString("hdjlbm");
    hdxcjlbm= rs_xcjq_hd.getString("hdxcjlb");
  }
  xcjq.closeRsStmt();
  xcjq.freeConnection();
}

//id	xcm	xcbh	xcysbh	xczrxm
//System.out.println(hdxcjlbm);
if(r_opmode.equals("tj")){
  xcjq.setPoolname("jdbc/xcjq",this);
  glxx_info="С�������Ϣ���"+(xcjq.executeUpdate("insert into "+hdxcjlbm+"(xcm,xcbh,xcysbh,xczrxm) values('"+r_xcm+"','"+r_xcbh+"','"+r_xcysbh+"','"+r_xczrxm+"')")==1?"���":"ʧ��")+"��";
}else
if(r_opmode.equals("xg")){
	xcjq.setPoolname("jdbc/xcjq",this);
	glxx_info = "С�������Ϣ�޸�"+(xcjq.executeUpdate("update "+hdxcjlbm+" set xcm='"+r_xcm+"',xcbh='"+r_xcbh+"',xcysbh='"+r_xcysbh+"',xczrxm='"+r_xczrxm+"' where id="+r_xcid)==1?"���":"ʧ��")+"��";
}else
if(r_opmode.equals("sc")){
	xcjq.setPoolname("jdbc/xcjq",this);
	glxx_info="С�������Ϣɾ��"+(xcjq.executeUpdate("delete from "+hdxcjlbm+" where id="+r_xcid)==1?"���":"ʧ��")+"��";
}
%>

    <table style="WIDTH:95%" borderColor="#0000ff" cellSpacing=0 cellPadding=3 rules=rows border=1 frame=hsides align="center">
      <tr> 
        <td valign="middle" colspan="6" align="center"><%=rs_hdmc%><BR><%=rs_hdrq%><BR><b>С�������Ϣ����</b></td>
      </tr><%
      if(glxx_info.length()>0){
      %><tr><td colspan="6" align="center"><%=glxx_info%></td></tr>
      <%}%>
      <tr>
        <td>С��ID</td>
        <td>С������</td>
        <td>���</td>
        <td>ԭʼ���</td>
        <td>��������</td>
        <td>����</td>
      </tr>
      <tr>
        <form name="xcbhxxbd" method="post">
        <td>&nbsp;</td>
        <td><input type="text" name="xcm" value="С����" size="30" title="С������"></td>
        <td><input type="text" name="xcbh" value=""/ title="С�����"></td>
        <td><input type="text" name="xcysbh" value=""/ title="С��ԭʼ���"></td>
        <td><input type="text" name="xczrxm" value=""/ title="��������"></td>
        <td align="center">
          <input type="submit" name="action_tj" value="���" onclick="jianchabiaodan(document.xcbhxxbd,3)">
          <input type="hidden" name="opmode" value="">
          <input type="hidden" name="hdid" value="<%=r_hdid%>">
        </td>
        </form>
      </tr><%
				//id	xcm	xcbh	xcysbh	xczrxm
        xcjq.setPoolname("jdbc/xcjq",this);
        java.sql.ResultSet rs_xcjq = xcjq.executeQuery("select * from "+hdxcjlbm);
        if(rs_xcjq!=null)
          while(rs_xcjq.next()){
            String rs_xcid=rs_xcjq.getString("ID")
                  ,rs_xcm=rs_xcjq.getString("xcm")
                  ,rs_xcbh=rs_xcjq.getString("xcbh")
                  ,rs_xcysbh = rs_xcjq.getString("xcysbh")
                  ,rs_xczrxm = rs_xcjq.getString("xczrxm");
        %>
      <tr>
        <form name="xcbhxxbd<%=rs_xcid%>" method="post">
        <td><%=rs_xcid%></td>
        <td><input type="text" name="xcm" value="<%=rs_xcm%>" size="30" title="С����"></td>
        <td><input type="text" name="xcbh" value="<%=rs_xcbh%>" size="20" title="���"/></td>
        <td><input type="text" name="xcysbh" value="<%=rs_xcysbh%>" size="20" title="ԭʼ���"></td>
        <td><input type="text" name="xczrxm" value="<%=rs_xczrxm%>" size="20" title="С����������"/></td>
        <td align="center">
          <input type="submit" name="action_xg" value="�޸�" onclick="jianchabiaodan(document.xcbhxxbd<%=rs_xcid%>,1)">&nbsp;<input type="submit" name="action_sc" value="ɾ��" onclick="jianchabiaodan(document.xcbhxxbd<%=rs_xcid%>,2)">
          <input type="hidden" name="opmode" value="">
          <input type="hidden" name="xcid" value="<%=rs_xcid%>">
          
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
          if(bd.xcm.value.length==0){
            isvalid = false;
            alert("С��������Ϊ�գ�");
            bd.xcm.focus();
          }
          if(bd.xcbh.value.length==0){
            isvalid = false;
            alert("С����Ų���Ϊ�գ�");
            bd.xcbh.focus();
          }
          if(bd.xcysbh.value.length==0){
            isvalid = false;
            alert("С��ԭʼ��Ų���Ϊ�գ�");
            bd.xcysbh.focus();
          }
          if(bd.xczrxm.value.length==0){
            isvalid = false;
            alert("С��������������Ϊ�գ�");
            bd.xczrxm.focus();
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


