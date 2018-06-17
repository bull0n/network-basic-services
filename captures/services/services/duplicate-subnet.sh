#! /bin/bash

# BUGS
#    - supports upto 9 subnets (else fix the MAC address fixup below)

if [ $# != 1 ]; then
   echo "$0: bad args." >&2
   echo "$0 count" >&2
   exit 2
fi

for i in $(seq 2 $1)
do
   for j in n1-*.startup
   do
      dest=$(echo $j | sed "s/n1/n$i/")
      cp $j $dest
      case $dest in
         *-routeur.startup) sed --in-place "s/192.168\.1\./192.168.$i./g;s/1\.168\.192/$i.168.192/g;s/192.168\.0\.1/192.168.0.$i/g;s/net1/net$i/g;s/00:00:01:00:00:01/00:00:01:00:00:0$i/g" $dest;;
      esac
      mkdir $(basename $dest .startup)
   done

   cat >> lab.conf <<EOF

n$i-pc1[0]="$i"
n$i-pc2[0]="$i"
n$i-routeur[0]="$i"
n$i-routeur[1]="0"
n$i-routeur[mem]=64
EOF
done


