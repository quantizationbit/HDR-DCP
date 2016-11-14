set -x
rm -rfv RGBHDRDCP j2k tmp
mkdir RGBHDRDCP j2k tmp
cd RGBHDRDCP

rm -fv ../j2k/* ../tmp/*

NITS=(75 100 200)
MINS=(.02 .01 .005 .002 .001 .0005)

# PQ 
for nits in ${NITS[@]}
do 

for mins in ${MINS[@]}
do 

    mkdir $nits"nitsRGBPQ"$mins
    cd $nits"nitsRGBPQ"$mins
	opendcp_j2k -i ../../TIFPQ$nits$mins -x -m ../../tmp -o ../../j2k
	opendcp_mxf -i ../../j2k -o Clip$nits$mins.mxf
	rm -fv ../../j2k/* ../../tmp/*
	
	opendcp_xml --reel Clip$nits$mins".mxf"  --digest OpenDCP$nits$mins --kind test -t "RGB HDR Test StEM $nits nits $mins black"
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

