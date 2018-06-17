#! /bin/bash

awk 'BEGIN { do_print = 1; }
     { if (do_print) { print; } }
     /# --- AUTO-ZONE/ { do_print = 0; }' < lab.conf > lab.conf.NEW
mv lab.conf.NEW lab.conf

for i in $(seq 2 9)
do
   rm -rf n$i-{pc1,pc2,routeur}
   rm -f n$i-{pc1,pc2,routeur}.startup
done
