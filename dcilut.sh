set -x

pushd $EDRHOME/ACES/aces-dev
git checkout master
git pull
git checkout v1.0.3
git status
popd

CTL_MODULE_PATH="$EDRHOME/ACES/CTLa1:$EDRHOME/ACES/aces-dev/transforms/ctl/utilities:$EDRHOME/ACES/aces-dev/transforms/ctl/lib"


CUBE=65
filename=lutimage.tiff
lutname=2000lut
ociolutimage --generate --cubesize $CUBE --output $filename

ctlrender -force -verbose \
  -ctl DCDM_to_XYZPQ_48nits_2000_to_1_contrast.ctl \
$filename -format tiff16 2000lut.tiff


# Extract LUT
rm -fv IDT_LMT.spi3d
ociolutimage --extract --cubesize $CUBE --input $lutname".tiff" \
  --output $lutname".spi3d"


ociobakelut --lut $lutname".spi3d" --format iridas_itx --cubesize $CUBE $lutname".cube"

