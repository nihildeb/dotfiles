#!/usr/bin/env bash
set -e

#script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
#script_file=$(basename ${BASH_SOURCE[0]})
#script_abs=$script_dir/$script_file
#echo entering $script_abs

# Copies ary1 and ary2 into ary3
# concat ary1 ary2 ary3
concat() {
    eval "${3:?}=( \"\${$1[@]}\" \"\${$2[@]}\" )"
}

cust1_domains=(
hildebrant.org
unixfier.com
secropolis.com
willitping.com
wickedgrog.com
happymoose.com
directfromgermany.com
opensoundengine.com
floremo.com
yardata.com
ipsaw.com
oxfammodels.com
)

cust2_domains=(
gisimple.com
gisimply.com
gissimple.com
govergis.com
marketvisualization.com
salesvisualization.com
understandata.com
)

all_domains=()
concat cust1_domains cust2_domains all_domains

