<%@page buffer="none" language="java" contentType="text/html;charset=GBK"%><%request.setCharacterEncoding("GBK");%>
<jsp:useBean id="xcjq" scope="page" class="com.luoliang.sql.tomcat5028.dealSql"/><jsp:useBean id="util" scope="page" class="com.luoliang.upload.utils" /><%
StringBuffer error_info_sb = new StringBuffer();
String xcjqbm = "xcjqhd_20161226"
      ,xcjqhdmxbm = "xcjqhdmxb"
      ,hdxcjlbm = "xcjqhd_xcbh_20161226";
String r_xcbh=request.getParameter("xcbh")
      ,r_hdid=request.getParameter("hdid");	//小车编号

String xcm = ""
      ,xczrxm = "";

long interval_xc = 10000;
int count = 0;
if(r_hdid!=null){
  xcjq.setPoolname("jdbc/xcjq",this);
  java.sql.ResultSet rs_xcjq = xcjq.executeQuery("select * from "+xcjqhdmxbm+" where ID="+r_hdid);
  if(rs_xcjq!=null && rs_xcjq.next()){
    xcjqbm = rs_xcjq.getString("hdjlbm");
    hdxcjlbm = rs_xcjq.getString("hdxcjlb");
  }else error_info_sb.append("无指定活动ID对应活动！<BR>");
  xcjq.closeRsStmt();
  xcjq.freeConnection();
  
  if(error_info_sb.length()==0){
    xcjq.setPoolname("jdbc/xcjq",this);
    java.sql.ResultSet rs_xcjq_jlb = xcjq.executeQuery("select * from "+hdxcjlbm+" where xcbh='"+r_xcbh+"'");
    if(rs_xcjq_jlb!=null && rs_xcjq_jlb.next()){
      xcm = rs_xcjq_jlb.getString("xcm");
      xczrxm = rs_xcjq_jlb.getString("xczrxm");
    }else error_info_sb.append("不能确定小车名及小车主人姓名！<BR>");
    xcjq.closeRsStmt();
    xcjq.freeConnection();
  }
  
}else error_info_sb.append("请指定活动ID！<BR>");
%>
<html>
	<head><title>指定小车计圈状态显示</title></head>
<body><table border="1"><tr><td colspan="2" align="center"><%=xczrxm%>&nbsp;&nbsp;<%=xcm%></td></tr>
<%
if(r_xcbh!=null && error_info_sb.length()==0){
  long time_xc_bj = 0
      ,time_xcjq_bj = 0;
  xcjq.setPoolname("jdbc/xcjq",this);
  java.sql.ResultSet rs_xcjq = xcjq.e_Q_C_U("select * from "+xcjqbm+" where xcbh like '"+r_xcbh+"%' order by xcrqsj");
  while(rs_xcjq!=null && rs_xcjq.next()){
    long time_xc = rs_xcjq.getTimestamp("xcrqsj").getTime();
    if(time_xc-time_xcjq_bj>interval_xc){
      //time_xc_bj = time_xc;
      time_xcjq_bj = time_xc ;
      count++;
      %><tr><td align="right"><%=count%></td><%java.util.Calendar calendar = java.util.Calendar.getInstance();
      calendar.setTimeInMillis(time_xc);
    %><td align="left"><%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime())%></td><%
    }
  }
  xcjq.closeRsStmt();
  xcjq.freeConnection();
}else error_info_sb.append("无小车计圈信息！<BR>");
if(error_info_sb.length()>0){%><tr><td colspan="2"><%=error_info_sb.toString()%></td></tr><%}%></table>
	</body>
</html>

