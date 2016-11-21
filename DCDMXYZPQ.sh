set -x


# Set for v1.0.3
pushd .
cd $EDRHOME/ACES/aces-dev
git tag
git checkout v1.0.3
popd
CTL_MODULE_PATH="$EDRHOME/ACES/aces-dev/transforms/ctl/utilities:$EDRHOME/ACES/aces-dev/transforms/ctl/lib"
sleep 2

# set for v71 aces
#CTL_MODULE_PATH="/usr/local/lib/CTL:$EDRHOME/ACES/CTL:$EDRHOME/ACES/transforms/ctl/utilities"

# Set for ACES v1 
#CTL_MODULE_PATH="$EDRHOME/ACES/aces-dev/transforms/ctl/utilities:$EDRHOME/ACES/CTLa1"


NITS=(500)
MINS=(.02 .01 .005 )

rm -rfv TIF*

##Gamma
#mkdir "TIF"${NITS[0]}${MINS[0]} "TIF"${NITS[1]}${MINS[0]} "TIF"${NITS[2]}${MINS[0]} "TIF"${NITS[3]}${MINS[0]} "TIF"${NITS[4]}${MINS[0]}
#mkdir "TIF"${NITS[0]}${MINS[1]} "TIF"${NITS[1]}${MINS[1]} "TIF"${NITS[2]}${MINS[1]} "TIF"${NITS[3]}${MINS[1]} "TIF"${NITS[4]}${MINS[1]}
#mkdir "TIF"${NITS[0]}${MINS[2]} "TIF"${NITS[1]}${MINS[2]} "TIF"${NITS[2]}${MINS[2]} "TIF"${NITS[3]}${MINS[2]} "TIF"${NITS[4]}${MINS[2]}
#mkdir "TIF"${NITS[0]}${MINS[3]} "TIF"${NITS[1]}${MINS[3]} "TIF"${NITS[2]}${MINS[3]} "TIF"${NITS[3]}${MINS[3]} "TIF"${NITS[4]}${MINS[3]}
#mkdir "TIF"${NITS[0]}${MINS[4]} "TIF"${NITS[1]}${MINS[4]} "TIF"${NITS[2]}${MINS[4]} "TIF"${NITS[3]}${MINS[4]} "TIF"${NITS[4]}${MINS[4]}
#mkdir "TIF"${NITS[0]}${MINS[5]} "TIF"${NITS[1]}${MINS[5]} "TIF"${NITS[2]}${MINS[5]} "TIF"${NITS[3]}${MINS[5]} "TIF"${NITS[4]}${MINS[5]}



#mkdir "TIFPQ"${NITS[0]}${MINS[0]} "TIFPQ"${NITS[1]}${MINS[0]} "TIFPQ"${NITS[2]}${MINS[0]} "TIFPQ"${NITS[3]}${MINS[0]} "TIFPQ"${NITS[4]}${MINS[0]}
#mkdir "TIFPQ"${NITS[0]}${MINS[1]} "TIFPQ"${NITS[1]}${MINS[1]} "TIFPQ"${NITS[2]}${MINS[1]} "TIFPQ"${NITS[3]}${MINS[1]} "TIFPQ"${NITS[4]}${MINS[1]}
#mkdir "TIFPQ"${NITS[0]}${MINS[2]} "TIFPQ"${NITS[1]}${MINS[2]} "TIFPQ"${NITS[2]}${MINS[2]} "TIFPQ"${NITS[3]}${MINS[2]} "TIFPQ"${NITS[4]}${MINS[2]}
#mkdir "TIFPQ"${NITS[0]}${MINS[3]} "TIFPQ"${NITS[1]}${MINS[3]} "TIFPQ"${NITS[2]}${MINS[3]} "TIFPQ"${NITS[3]}${MINS[3]} "TIFPQ"${NITS[4]}${MINS[3]}
#mkdir "TIFPQ"${NITS[0]}${MINS[4]} "TIFPQ"${NITS[1]}${MINS[4]} "TIFPQ"${NITS[2]}${MINS[4]} "TIFPQ"${NITS[3]}${MINS[4]} "TIFPQ"${NITS[4]}${MINS[4]}
#mkdir "TIFPQ"${NITS[0]}${MINS[5]} "TIFPQ"${NITS[1]}${MINS[5]} "TIFPQ"${NITS[2]}${MINS[5]} "TIFPQ"${NITS[3]}${MINS[5]} "TIFPQ"${NITS[4]}${MINS[5]}

mkdir "TIFPQ"${NITS[0]}${MINS[0]} 
mkdir "TIFPQ"${NITS[0]}${MINS[1]} 
mkdir "TIFPQ"${NITS[0]}${MINS[2]}  

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


 
 
(ctlrender -force -ctl ./InvODT.Academy.Rec2020_ST2084_4000nits.ctl -param1 aIn 1.0 $filename -format exr32 TMP$c1".exr"; \
 \
 \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[0]} -param1 PQ 1 -param1 DCDM 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[0]}"/TIFPQ"${NITS[0]}${MINS[0]}$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[1]} -param1 PQ 1 -param1 DCDM 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[1]}"/TIFPQ"${NITS[0]}${MINS[1]}$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[2]} -param1 PQ 1 -param1 DCDM 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[2]}"/TIFPQ"${NITS[0]}${MINS[2]}$numStr".tiff"; \
 \
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



exit
#done













# Save from original with gamma

 
 
(ctlrender -force -ctl ./InvODT.Academy.Rec2020_ST2084_4000nits.ctl -param1 aIn 1.0 $filename -format exr32 TMP$c1".exr"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[0]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[0]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[0]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[0]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[0]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[0]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[1]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[1]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[1]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[1]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[1]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[1]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[2]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[2]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[2]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[2]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[2]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[2]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[3]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[3]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[3]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[3]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[3]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[3]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[4]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[4]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[4]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[4]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[4]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[4]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[5]} TMP$c1".exr" -format tiff16 "TIF"${NITS[4]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[5]} TMP$c1".exr" -format tiff16 "TIF"${NITS[3]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[5]} TMP$c1".exr" -format tiff16 "TIF"${NITS[2]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[5]} TMP$c1".exr" -format tiff16 "TIF"${NITS[1]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[5]} TMP$c1".exr" -format tiff16 "TIF"${NITS[0]}${MINS[5]}"/"$numStr".tiff"; \
 \
 \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[0]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[0]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[0]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[0]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[0]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[0]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[0]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[1]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[1]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[1]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[1]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[1]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[1]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[1]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[2]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[2]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[2]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[2]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[2]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[2]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[2]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[3]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[3]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[3]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[3]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[3]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[3]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[3]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[4]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[4]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[4]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[4]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[4]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[4]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[4]}"/"$numStr".tiff"; \
 \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[4]} -param1 MIN ${MINS[5]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[4]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[3]} -param1 MIN ${MINS[5]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[3]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[2]} -param1 MIN ${MINS[5]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[2]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[1]} -param1 MIN ${MINS[5]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[1]}${MINS[5]}"/"$numStr".tiff"; \
ctlrender -force  -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX ${NITS[0]} -param1 MIN ${MINS[5]} -param1 PQ 1 TMP$c1".exr" -format tiff16 "TIFPQ"${NITS[0]}${MINS[5]}"/"$numStr".tiff"; \
) &
