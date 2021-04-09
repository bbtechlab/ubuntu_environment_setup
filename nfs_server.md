# Setup nfs-kernel-server
```
$ sudo apt-get install nfs-kernel-server
Once installed, edit the /etc/exports file as root to add the following line, assuming that the IP address of qemu emulator board will be 192.168.1.100:
$ sudo vi /etc/exports
# /etc/exports: the access control list for filesystems which may be exported
  1 # /etc/exports: the access control list for filesystems which may be exported
  2 #       to NFS clients.  See exports(5).
  3 #
  4 # Example for NFSv2 and NFSv3:
  5 # /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
  6 #
  7 # Example for NFSv4:
  8 # /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
  9 # /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
 10 #
/home/bamboo/workspace/nfsroot  *(rw,no_root_squash,no_all_squash,async,no_subtree_check)
make sure that there is no space between the IP address and the NFS options, otherwise default options will be used for this IP address, causing your root filesystem to be read-only.
$ sudo service nfs-kernel-server restart
```
Display all exported file systems from an NFS server
```
$ sudo showmount -e
Export list for bbtechlab:
/home/bamboo/workspace/nfsroot *
```
