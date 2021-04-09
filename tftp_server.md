# Setup TFTP server
```
$ sudo apt install tftpd-hpa
$ sudo systemctl status tftpd-hpa
● tftpd-hpa.service - LSB: HPA's tftp server
   Loaded: loaded (/etc/init.d/tftpd-hpa; bad; vendor preset: enabled)
   Active: active (running) since T2 2021-03-08 12:42:09 +07; 10s ago
     Docs: man:systemd-sysv-generator(8)
   CGroup: /system.slice/tftpd-hpa.service
           └─21611 /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure /var/lib/tftpboot

Th03 08 12:42:09 bbtechlab systemd[1]: Starting LSB: HPA's tftp server...
Th03 08 12:42:09 bbtechlab tftpd-hpa[21598]:  * Starting HPA's tftpd in.tftpd
Th03 08 12:42:09 bbtechlab tftpd-hpa[21598]:    ...done.
Th03 08 12:42:09 bbtechlab systemd[1]: Started LSB: HPA's tftp server.

$ sudo vi /etc/default/tftpd-hpa
  1 # /etc/default/tftpd-hpa
  2 
  3 TFTP_USERNAME="bamboo"
  4 TFTP_DIRECTORY="/home/bamboo/workspace/tftpboot"        ---> Change this path for yours                                                             
  5 TFTP_ADDRESS=":69"
  6 TFTP_OPTIONS="--secure --create"

$ sudo chown bamboo:bamboo /home/bamboo/workspace/tftpboot/
$ sudo systemctl restart tftpd-hpa
$ sudo systemctl status tftpd-hpa
● tftpd-hpa.service - LSB: HPA's tftp server
   Loaded: loaded (/etc/init.d/tftpd-hpa; bad; vendor preset: enabled)
   Active: active (running) since T2 2021-03-08 12:47:23 +07; 7s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 21786 ExecStop=/etc/init.d/tftpd-hpa stop (code=exited, status=0/SUCCESS)
  Process: 21797 ExecStart=/etc/init.d/tftpd-hpa start (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/tftpd-hpa.service
           └─21812 /usr/sbin/in.tftpd --listen --user tftp --address :69 --secure --create /home/bamboo/workspace

Th03 08 12:47:23 bbtechlab systemd[1]: Stopped LSB: HPA's tftp server.
Th03 08 12:47:23 bbtechlab systemd[1]: Starting LSB: HPA's tftp server...
Th03 08 12:47:23 bbtechlab tftpd-hpa[21797]:  * Starting HPA's tftpd in.tftpd
Th03 08 12:47:23 bbtechlab tftpd-hpa[21797]:    ...done.
Th03 08 12:47:23 bbtechlab systemd[1]: Started LSB: HPA's tftp server.
lines 1-14/14 (END)
```
As you can see, the tftpd-hpa service is running. So, the configuration is successful. Now, we try to test tftp server
```
$ sudo apt install tftp-hpa     #install tftp client
$ cd ~/workspace
$ echo "helloworld" > test_tftp.txt
$ tftp 172.16.157.128
tftp> verbose
Verbose mode on.
tftp> put test_tftp.txt
putting test_tftp.txt to 172.16.157.128:test_tftp.txt [netascii]
Sent 12 bytes in 0.0 seconds [8664 bit/s]
tftp> quit
$ cat ~/workspace/tftpboot/test_tftp.txt 
helloworld
```
