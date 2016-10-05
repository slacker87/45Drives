card1=$(lspci | grep 0750 | awk 'NR==1{print $1}')
card2=$(lspci | grep 0750 | awk 'NR==2{print $1}')

if [ -e /etc/zfs/vdev_id.conf.test ];then
        rm -f /etc/zfs/vdev_id.conf.test
fi

#Card 1
slot=1
echo "# by-vdev" >> /etc/zfs/vdev_id.conf.test
echo "# name     fully qualified or base name of device link" >> /etc/zfs/vdev_id.conf.test
while [ $slot -lt 25 ];do
        echo "alias 1-$slot     /dev/disk/by-path/pci-0000:$card1-scsi-0:0:$(expr $slot - 1):0" >> /etc/zfs/vdev_id.conf.test
        let slot=slot+1
done

#Card 2
slot=1
while [ $slot -lt 22 ];do
        if [ $slot -eq 21 ];then
                echo "alias 2-$slot     /dev/disk/by-path/pci-0000:$card2-scsi-0:0:23:0" >> /etc/zfs/vdev_id.conf.test
        else
                echo "alias 2-$slot     /dev/disk/by-path/pci-0000:$card2-scsi-0:0:$(expr $slot - 1):0" >> /etc/zfs/vdev_id.conf.test
        fi
        let slot=slot+1
done
~