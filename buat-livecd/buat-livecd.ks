# Dibuat oleh Nana Suryana <suryana@gmail.com>
# Dimodifikasi oleh Surya Handika Putratama <ubunteroz@gmail.com>

rootpw --iscrypted $1$b132sCco$Ztcyha/kHgautUanhuP/4/

# Atur firewall agar membuka: 
#
# ssh (22:tcp), http (80:tcp), https (443:tcp)
# printer client (631:udp), printer server (631:udp, 631:tcp)
# samba client (137:udp, 138:udp), 
# samba (137:udp, 138:udp, 139:tcp, 445:tcp)

firewall --enabled --ssh --http --port=137:udp,138:udp,139:tcp,443:tcp,445:tcp,515:tcp,631:tcp,631:udp
services --enabled=NetworkManager,cups,mdns --disabled=sshd,network,nfslock,rpcbind,rpcsvcgssd,rpcgssd,rpcidmapd,nfs,sendmail,sandbox,netfs

xconfig --startxonboot
install
auth --useshadow --passalgo=md5
firstboot --disable
keyboard us
lang id_ID.UTF-8
selinux --disabled
logging --level=info
# cdrom
timezone Asia/Jakarta
bootloader --append="acpi=force" --location=mbr --timeout=12

%packages --excludedocs --nobase --instLangs=id_ID:en_US
%end

%post
userdel -r ___LIVEUSER___

useradd -c "___LOCALUSERFULLNAME___" -m -U ___LOCALUSER___
passwd -d ___LOCALUSER___ > /dev/null

passwd -d root > /dev/null

systemctl disable iptables.service
systemctl start cups.service

rm -f /etc/rc.d/init.d/ign-livecd
rm -f /etc/rc.d/init.d/ign-livecd-akhir

/usr/sbin/ign-root-default64
/usr/sbin/ign-root-grub2
/usr/sbin/ign-root-systemd
%end