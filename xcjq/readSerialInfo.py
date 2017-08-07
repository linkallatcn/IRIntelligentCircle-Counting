//http://stackoverflow.com/questions/22975511/python3-pyserial-library
//http://tieba.baidu.com/p/2887523362
//http://tieba.baidu.com/p/3834959715
//http://blog.csdn.net/xhao014/article/details/7640568
//有关字符集编码转换问题
//http://www.mkyong.com/python/python-3-typeerror-cant-convert-bytes-object-to-str-implicitly/
//https://zhidao.baidu.com/question/1702084912076851860.html
//http://www.cnblogs.com/itech/archive/2011/03/28/1997878.html
import urllib.request
import serial
import time

xcbhjs=0
ser = serial.Serial("COM3",9600)
while 1:
  xcbh = ser.readline()
  url="http://127.0.0.1:7513/xcjq/xcjqxxdj.jsp?hdid=1&xcbh="+xcbh.decode()
  u_r_o = urllib.request.urlopen(url)
  s_html = u_r_o.read()
  u_r_o.close()
  xcbhjs=xcbhjs+1
  if xcbhjs==10 : break;

ser.close()
