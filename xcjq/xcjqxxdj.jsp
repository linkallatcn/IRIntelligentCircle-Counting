<%@page buffer="none" language="java" contentType="text/html;charset=GBK"%><%request.setCharacterEncoding("GBK");%>
<jsp:useBean id="xcjq" scope="page" class="com.luoliang.sql.tomcat5028.dealSql"/><jsp:useBean id="util" scope="page" class="com.luoliang.upload.utils" /><%
String error_info = "";
String r_xcbh=request.getParameter("xcbh")
      ,r_hdid=request.getParameter("hdid");	//小车编号
String xcjqbm = "xcjqhd_20161226"
      ,xcjqhdmxbm = "xcjqhdmxb";
if(r_hdid!=null){
  xcjq.setPoolname("jdbc/xcjq",this);
  java.sql.ResultSet rs_xcjq = xcjq.executeQuery("select * from "+xcjqhdmxbm+" where ID="+r_hdid);
  if(rs_xcjq!=null && rs_xcjq.next()){
    xcjqbm = rs_xcjq.getString("hdjlbm");
  }else error_info="无指定活动ID对应活动！";
  xcjq.closeRsStmt();
  xcjq.freeConnection();
}else error_info="请指定活动ID！";

if(r_xcbh!=null && error_info.length()==0){
  xcjq.setPoolname("jdbc/xcjq",this);
  java.sql.ResultSet rs_xcjq = xcjq.e_Q_C_U("select top 1 * from "+xcjqbm);
  rs_xcjq.moveToInsertRow();
  rs_xcjq.updateString("xcbh",r_xcbh);
  rs_xcjq.updateTimestamp("xcrqsj",new java.sql.Timestamp(java.util.Calendar.getInstance().getTimeInMillis()));
  //rs_xcjq.updateTimestamp("xcrqsj",new java.sql.Timestamp(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(util.getYMDStr(0)).getTime()));
  rs_xcjq.insertRow();
  xcjq.closeRsStmt();
  xcjq.freeConnection();
}else error_info="请指定小车编号！";
%>
<html><head><title>insert info</title></head><body><%=r_xcbh==null?"car number?":"sccess"%></body></html>

