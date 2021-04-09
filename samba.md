# Setup SAMBA server
```
$ sudo apt-get install samba
$ sudo vim /etc/samba/smb.conf
# Allow users who've been granted usershare privileges to create
# public shares, not just authenticated ones
   usershare allow guests = yes
socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RVCBUF=131072 SO_SNDBUF=131072
write cache size = 4194304
min receivefile size = 16384

follow links = yes
wide links = yes
unix extensions = no
#======================= Share Definitions =======================
...
# Please note that you also need to set appropriate Unix permissions
# to the drivers directory for these users to have write rights in it
;   write list = root, @lpadmin
[workspace]
    comment = <user>
    path = /home/<user>/workspace
    public = yes
    writeable = yes
    create mask = 0777
    directory mask = 0777

$ sudo smbpasswd -a <user>
$ sudo /etc/init.d/smbd restart
```
