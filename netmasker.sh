#!/bin/bash

function usage {
    echo "Usage: $0 <network>"
    exit 1
}

[ $# -ne 1 ] && usage

Ad=$(echo $1 | cut -d'.' -f1)
Bd=$(echo $1 | cut -d'.' -f2)
Cd=$(echo $1 | cut -d'.' -f3)
Dd=$(echo $1 | cut -d'.' -f4 | cut -d '/' -f1)
CIDR=$(echo $1 | cut -d'.' -f4 | cut -d '/' -f2)

netmask=""

for i in $(seq 1 $CIDR);do
    netmask=$netmask"1"
    [ $(($i%8)) -eq 0 ] && [ $i -ne 32 ] && netmask=$netmask"."
done

for i in $(seq $(($CIDR+1)) 32);do
    netmask=$netmask"0"
    [ $(($i%8)) -eq 0 ] && [ $i -ne 32 ]  && netmask=$netmask"."
done

mskAb=$(echo $netmask | cut -d'.' -f1)
mskBb=$(echo $netmask | cut -d'.' -f2)
mskCb=$(echo $netmask | cut -d'.' -f3)
mskDb=$(echo $netmask | cut -d'.' -f4 | cut -d '/' -f1)

mskAd=$((2#$mskAb))
mskBd=$((2#$mskBb))
mskCd=$((2#$mskCb))
mskDd=$((2#$mskDb))

netAd=$(($Ad & $mskAd))
netBd=$(($Bd & $mskBd))
netCd=$(($Cd & $mskCd))
netDd=$(($Dd & $mskDd))

imskAd=$(($mskAd ^ 255))
imskBd=$(($mskBd ^ 255))
imskCd=$(($mskCd ^ 255))
imskDd=$(($mskDd ^ 255))

brdAd=$((netAd | imskAd))
brdBd=$((netBd | imskBd))
brdCd=$((netCd | imskCd))
brdDd=$((netDd | imskDd))

for i in $(seq $netAd $brdAd);do
    for j in $(seq $netBd $brdBd);do
        for k in $(seq $netCd $brdCd);do
            for l in $(seq $netDd $brdDd);do
                echo $i.$j.$k.$l
            done
        done
    done
done
