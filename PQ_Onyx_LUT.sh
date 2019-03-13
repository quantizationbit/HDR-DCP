set -x

pushd $EDRHOME/ACES/aces-dev
git checkout master
git pull
git checkout v1.1
git status
popd

CTL_MODULE_PATH="$EDRHOME/ACES/CTLa1:$EDRHOME/ACES/aces-dev/transforms/ctl/utilities:$EDRHOME/ACES/aces-dev/transforms/ctl/lib"

# PQ500
CUBE=65
filename=lutimage.tiff
lutname=PQ500P3
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/csc/ACEScct/ACEScsc.ACEScct_to_ACES.ctl -param1 aIn 1.0 \
    -ctl ./RRTODT.Academy.P3D65_xxx_nits_ST2084.ctl \
        -param1 aIn 1.0 -param1 Y_MAX 500.0 -param1 Y_MIN 0.005 -param1 Y_MID 4.8 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"



# PQ300
CUBE=65
filename=lutimage.tiff
lutname=PQ300P3
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/csc/ACEScct/ACEScsc.ACEScct_to_ACES.ctl -param1 aIn 1.0 \
    -ctl ./RRTODT.Academy.P3D65_xxx_nits_ST2084.ctl \
        -param1 aIn 1.0 -param1 Y_MAX 300.0 -param1 Y_MIN 0.005 -param1 Y_MID 4.8 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"


# PQ100
lutname=PQ100P3
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/csc/ACEScct/ACEScsc.ACEScct_to_ACES.ctl -param1 aIn 1.0 \
    -ctl ./RRTODT.Academy.P3D65_xxx_nits_ST2084.ctl \
        -param1 aIn 1.0 -param1 Y_MAX 100.0 -param1 Y_MIN 0.005 -param1 Y_MID 4.8 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"


