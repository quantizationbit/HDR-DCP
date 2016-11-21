set -x
rm -rfv RGBHDRDCP HDRDCP j2k tmp
mkdir HDRDCP j2k tmp
cd HDRDCP

rm -fv ../j2k/* ../tmp/*

NITS=(500)
MINS=(.02 .01 .005 )

# PQ 
for nits in ${NITS[@]}
do 

for mins in ${MINS[@]}
do 

    mkdir $nits"nitsXYZPQ"$mins
    cd $nits"nitsXYZPQ"$mins
	opendcp_j2k -i ../../TIFPQ$nits$mins -x -m ../../tmp -o ../../j2k
	opendcp_mxf -i ../../j2k -o Clip$nits$mins.mxf
	rm -fv ../../j2k/* ../../tmp/*
	
	opendcp_xml --reel Clip$nits$mins".mxf"  --digest OpenDCP$nits$mins --kind test -t "XYZ PQ HDR Test StEM $nits nits $mins black"
    cd ..
done
done


## Gamma
#for nits in ${NITS[@]}
#do 

#for mins in ${MINS[@]}
#do 

    #mkdir $nits"nitsRGB"$mins
    #cd $nits"nitsRGB"$mins
	#opendcp_j2k -i ../../TIF$nits$mins -x -m ../../tmp -o ../../j2k
	#opendcp_mxf -i ../../j2k -o Clip$nits$mins.mxf
	#rm -fv ../../j2k/* ../../tmp/*
	
	#opendcp_xml --reel Clip$nits$mins".mxf"  --digest OpenDCP$nits$mins --kind test -t "RGB HDR Test StEM $nits nits $mins black"
    #cd ..
#done
#done




ls -l .
cd ..
exit

