#!/bin/sh

myfs() {
	df $1 | grep ^/dev | awk '{print $1}'
}

rootfs=`myfs /`
echo "rootfs=$rootfs"
for dir in /*; do
	if [ ! -d $dir ]; then
		continue
	fi
	subfs=`myfs $dir`
	if [ "${rootfs}" = "${subfs}" ]; then
		echo "$dir is also on $subfs"
		du -sh $dir
	else
		echo "$dir is NOT on $rootfs it is on $subfs"
	fi
done
