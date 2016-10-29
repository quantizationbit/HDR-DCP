  
set -x

# set for v71 aces
CTL_MODULE_PATH="/usr/local/lib/CTL:$EDRHOME/ACES/CTL:$EDRHOME/ACES/transforms/ctl/utilities"

NITS=(500 300 150 100 48)
rm -rfv TIF*
mkdir "TIF"${NITS[0]} "TIF"${NITS[1]} "TIF"${NITS[2]} "TIF"${NITS[3]} "TIF"${NITS[4]}
rm -fv TIF*/*

# find all exr files
c1=0
# generally set CMax to 3,4, 7,8 depending on number of cores
CMax=8
num=1

#for filename in $EDRDATA/EXR/StEM_DOLBY/PQ/StEM*XYZ/*.tif ; do
# just the first files as test
for filename in /EDRDATA2/StEM_Dolby_PQ/StEM*2020/*tif ; do


 # file name w/extension e.g. 000111.tiff
 cFile="${filename##*/}"
 # remove extension
 cFile="${cFile%.tif}"
 # note cFile now does NOT have tiff extension!
 #echo -e "crop: $filename \n"
 
 
 numStr=`printf "%06d" $num`
 num=`expr $num + 1`
 
if [ $c1 -le $CMax ]; then


 
 
(ctlrender -force -ctl $EDRHOME/ACES/CTL/INVPQnk10k2020-2-OCES.ctl -param1 MAX 4000.0 $filename -format exr32 TMP$c1".exr"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR_PQ.ctl -param1 MAX ${NITS[4]}  TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR_PQ.ctl -param1 MAX ${NITS[3]}  TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR_PQ.ctl -param1 MAX ${NITS[2]}  TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR_PQ.ctl -param1 MAX ${NITS[1]}  TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR_PQ.ctl -param1 MAX ${NITS[0]}  TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}"/"$numStr".tiff"; \
) &
 

 sleep 0.1


c1=$[$c1 +1]
fi

if [ $c1 = $CMax ]; then
for job in `jobs -p`
do
echo $job
wait $job 
done
c1=0
fi

done


for job in `jobs -p`
do
echo $job
wait $job 
done

