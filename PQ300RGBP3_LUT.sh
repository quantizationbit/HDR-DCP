set -x

pushd $EDRHOME/ACES/aces-dev
git checkout master
git pull
git checkout v1.0.3
git status
popd

CTL_MODULE_PATH="$EDRHOME/ACES/CTLa1:$EDRHOME/ACES/aces-dev/transforms/ctl/utilities:$EDRHOME/ACES/aces-dev/transforms/ctl/lib"


# PQ300
CUBE=65
filename=lutimage.tiff
lutname=PQ300P3
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/csc/ACEScct/ACEScsc.ACEScct_to_ACES.ctl -param1 aIn 1.0 \
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/rrt/RRT.ctl -param1 aIn 1.0 \
    -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX 300.0 -param1 MIN 0.005 -param1 PQ 1 \
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
    -ctl $EDRHOME/ACES/aces-dev/transforms/ctl/rrt/RRT.ctl -param1 aIn 1.0 \
    -ctl ./ODT.Academy.P3DCI_XXXXnits.ctl -param1 aIn 1.0 -param1 MAX 100.0 -param1 MIN 0.005 -param1 PQ 1 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"


# Gamma 300
lutname=PQ300P3_2Gamma300_709
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/CTLa1/PQP3D65-2PQ2020.ctl -param1 aIn 1.0 \
    -ctl $EDRHOME/ACES/CTLa1/PQ2020-2-709Gamma.ctl -param1 aIn 1.0 -param1 CLIP 300.0 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"

# Gamma 100
lutname=PQ300P3_2Gamma100_709
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/CTLa1/PQP3D65-2PQ2020.ctl -param1 aIn 1.0 \
    -ctl $EDRHOME/ACES/CTLa1/PQ2020-2-709Gamma.ctl -param1 aIn 1.0 -param1 CLIP 100.0 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"

# Gamma 300
lutname=PQ2020_2Gamma300_709
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
    -ctl $EDRHOME/ACES/CTLa1/PQ2020-2-709Gamma.ctl -param1 aIn 1.0 -param1 CLIP 300.0 \
$filename -format tiff16 $lutname".tiff"


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"

