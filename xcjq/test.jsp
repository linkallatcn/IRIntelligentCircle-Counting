<%@page import="java.util.*"%>
<%
Date now = new Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String snow = sdf.format(now);  // 2009-11-19 14:12:23
System.out.println(snow);

  Calendar calendar1 = Calendar.getInstance(TimeZone.getTimeZone("GMT+8"));
  Calendar calendar2 = Calendar.getInstance(TimeZone.getTimeZone("GMT+1"));

  System.out.println("Millis = " + calendar1.getTimeInMillis());
  System.out.println("Millis = " + calendar2.getTimeInMillis());

  System.out.println("hour = " + calendar1.get(Calendar.HOUR));
  System.out.println("hour = " + calendar2.get(Calendar.HOUR));
  
  System.out.println("hour = " + calendar1.get(Calendar.MINUTE));
  System.out.println("hour = " + calendar2.get(Calendar.MINUTE));
  
  System.out.println("hour = " + calendar1.get(Calendar.SECOND));
  System.out.println("hour = " + calendar2.get(Calendar.SECOND));

  System.out.println("date = " + calendar1.getTime());
  System.out.println("date = " + calendar2.getTime());
%>
