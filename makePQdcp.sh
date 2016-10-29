set -x
mkdir PQHDRDCP j2k tmp
cd PQHDRDCP

rm -fv ../j2k/* ../tmp/*

NITS=(500 300 150 100 48)

for nits in ${NITS[@]}
do 

    mkdir $nits"nitsPQ"
    cd $nits"nitsPQ"
	opendcp_j2k -i ../../TIF$nits -x -m ../../tmp -o ../../j2k
	opendcp_mxf -i ../../j2k -o Clip$nits.mxf
	rm -fv ../../j2k/* ../../tmp/*
	
	opendcp_xml --reel Clip$nits".mxf"  --digest OpenDCP$nits --kind test -t "PQ HDR Test StEM $nits nits"
    cd ..
done




ls -l .
cd ..
exit

