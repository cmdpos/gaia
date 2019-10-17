#!/usr/bin/env bash

tail -f fileA, fileB | sed ':x; /==> fileA/ {n;:y;/==> /bx; n; by}; d'


exit

脚本就是输出下面两行之间的内容，对吧
==> fileA


==>