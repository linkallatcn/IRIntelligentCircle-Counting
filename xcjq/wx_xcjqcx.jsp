<%@page buffer="none" language="java" contentType="text/html;charset=GBK"%><%request.setCharacterEncoding("GBK");%>
<%
StringBuffer error_info_sb = new StringBuffer()
            ,jqxx_sb = new StringBuffer();
String hdidxcm="1/T01";
int pos_fgf = hdidxcm.indexOf("/");
String hdid = pos_fgf>0?hdidxcm.substring(0,pos_fgf):"1"
      ,xcm = pos_fgf>0?hdidxcm.substring(pos_fgf+1):hdidxcm;

String xcjqbm = "xcjqhd_20161226"
      ,xcjqhdmxbm = "xcjqhdmxb"
      ,hdxcjlbm = "xcjqhd_xcbh_20161226";

String xcbh = ""
      ,xczrxm = "";

String driverClassName = "sun.jdbc.odbc.JdbcOdbcDriver"
      ,xcjq_URL = "jdbc:odbc:dsnxcjq"
      ,xcjq_user = "admin"
      ,xcjq_password = "";
java.sql.Driver driver = (java.sql.Driver)Class.forName(driverClassName).newInstance();
java.sql.DriverManager.registerDriver(driver);
java.sql.Connection xcjq_conn = java.sql.DriverManager.getConnection(xcjq_URL,xcjq_user,xcjq_password);
java.sql.Statement xcjq_statment = xcjq_conn.createStatement();
java.sql.ResultSet xcjq_rs =  xcjq_statment.executeQuery("select * from "+xcjqhdmxbm+" where id="+hdid);
if(xcjq_rs!=null && xcjq_rs.next()){
  xcjqbm = xcjq_rs.getString("hdjlbm");
  hdxcjlbm = xcjq_rs.getString("hdxcjlb");
}else error_info_sb.append("无指定活动ID对应活动！<BR>");
xcjq_rs.close();
xcjq_rs=null;

if(error_info_sb.length()==0){
  java.sql.ResultSet rs_xcjq_jlb = xcjq_statment.executeQuery("select * from "+hdxcjlbm+" where xcm='"+xcm+"'");
  if(rs_xcjq_jlb!=null && rs_xcjq_jlb.next()){
    xcbh = rs_xcjq_jlb.getString("xcbh");
    xczrxm = rs_xcjq_jlb.getString("xczrxm");
    jqxx_sb.append(xczrxm).append("/").append(xcm).append("\r\n");
  }else error_info_sb.append("不能确定小车编号及小车主人姓名！<BR>");
  rs_xcjq_jlb.close();
  rs_xcjq_jlb=null;
}

long interval_xc = 10000;
int count = 0;
//System.out.println(xcbh);
//System.out.println(xczrxm);
//System.out.println(error_info_sb.toString());
if(!xcbh.equals("") && error_info_sb.length()==0){
  long time_xc_bj = 0
      ,time_xcjq_bj = 0;
  //System.out.println("select * from "+xcjqbm+" where xcbh like '"+xcbh+"%' order by xcrqsj");
  java.sql.ResultSet rs_xcjq = xcjq_statment.executeQuery("select * from "+xcjqbm+" where xcbh like '"+xcbh+"%' order by xcrqsj");
  while(rs_xcjq!=null && rs_xcjq.next()){
    long time_xc = rs_xcjq.getTimestamp("xcrqsj").getTime();
    if(time_xc-time_xcjq_bj>interval_xc){
      //time_xc_bj = time_xc;
      time_xcjq_bj = time_xc ;
      count++;
      java.util.Calendar calendar = java.util.Calendar.getInstance();
      calendar.setTimeInMillis(time_xc);
      jqxx_sb.append(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime())).append("第").append(count<10?"00"+count:(count<100?"0"+count:count)).append("圈").append("\r\n");
    }
  }
  rs_xcjq.close();
  rs_xcjq=null;
}else error_info_sb.append("无小车计圈信息！<BR>");
System.out.println(jqxx_sb.toString());
xcjq_statment.close();
xcjq_statment=null;
xcjq_conn.close();
xcjq_conn=null;
%>