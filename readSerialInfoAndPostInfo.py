import urllib.request
import serial
serialCommunicationPort="COM22"
ser = serial.Serial(serialCommunicationPort,9600)
while 1:
  xcbh = ser.readline()
  xcbhz = xcbh.decode()
  xzbhdm = xcbhz[xcbhz.find(',')+1:xcbhz.find('\r\n')]
  print(xzbhdm);
  url_local="http://127.0.0.1/xcjq/xcjqxxdj.jsp?hdid=2&xcbh="+xzbhdm
  u_r_o = urllib.request.urlopen(url_local)
  s_html = u_r_o.read()
  u_r_o.close()
  url_remote="http://117.78.42.197/xcjq/xcjqxxdj.jsp?hdid=2&xcbh="+xzbhdm
  u_r_o = urllib.request.urlopen(url_remote)
  s_html = u_r_o.read()
  u_r_o.close()

ser.close()
