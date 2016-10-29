set -x
mkdir HDRDCP j2k tmp
cd HDRDCP

rm -fv ../j2k/* ../tmp/*

NITS=(500 300 150 100 48)

for nits in ${NITS[@]}
do 

    mkdir $nits"nits"
    cd $nits"nits"
	opendcp_j2k -i ../../TIF$nits -x -m ../../tmp -o ../../j2k
	opendcp_mxf -i ../../j2k -o Clip$nits.mxf
	rm -fv ../../j2k/* ../../tmp/*
	
	opendcp_xml --reel Clip$nits".mxf"  --digest OpenDCP$nits --kind test -t "HDR Test StEM $nits nits"
    cd ..
done




ls -l .
cd ..
exit

