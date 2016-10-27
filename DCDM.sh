  
set -x


mkdir TIF48 TIF100 TIF150 TIF200 TIF300
rm -fv TIF*/*


# find all exr files
c1=0
# generally set CMax to 3,4, 7,8 depending on number of cores
CMax=4

num=1

#for filename in $EDRDATA/EXR/StEM_DOLBY/PQ/StEM*XYZ/*.tif ; do
# just the first files as test
for filename in $EDRDATA/EXR/StEM_DOLBY/PQ/StEM*2020/*tif ; do


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
ctlrender -force  -ctl $EDRHOME/ACES/transforms/ctl/odt/dcdm/odt_dcdm.ctl TMP$c1".exr" -format tiff16 "TIF48/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR.ctl -param1 MAX 100.0  TMP$c1".exr" -format tiff16 "TIF100/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR.ctl -param1 MAX 150.0  TMP$c1".exr" -format tiff16 "TIF150/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR.ctl -param1 MAX 200.0  TMP$c1".exr" -format tiff16 "TIF200/"$numStr".tiff"; \
ctlrender -force  -ctl $EDRHOME/ACES/CTL/odt_dcdm_HDR.ctl -param1 MAX 300.0  TMP$c1".exr" -format tiff16 "TIF300/"$numStr".tiff"; \
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

