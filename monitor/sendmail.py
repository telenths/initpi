#coding=utf-8
import smtplib, base64
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage

import datetime


sender = 'rasberrypi@163.com'
mailto = 'shangshang143.b1530f7@m.yinxiang.com '
imgfiles = 'a.jpeg'

username = 'rasberrypi'
password = 'ttp12345'

msg = MIMEMultipart()
msg['Subject'] = 'from the pi @rasberrypi #monitor'
msg['To'] = mailto
msg['From'] = sender

now = datetime.datetime.today()
htmlbody = '<b>%s</b>'%(now)

print htmlbody

Contents = MIMEText(htmlbody,'html')
msg.attach(Contents)

#att = MIMEText(open(r'./a.jpg','rb').read(),'base64','gb2312')
att = MIMEImage(file(imgfiles, 'rb').read(), _subtype="jpeg")
att["Content-Type"] = 'application/octet-stream'  
att.add_header('content-disposition','attachment',filename=imgfiles)
msg.attach(att)

smtp = smtplib.SMTP('smtp.163.com')
smtp.login(username,password)

smtp.sendmail(sender, mailto, msg.as_string())
smtp.quit()
