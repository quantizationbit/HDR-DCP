set -x
mkdir HDRDCP j2k tmp
cd HDRDCP

rm -fv ../j2k/* ../tmp/*

nits=300
$EDRHOME/DCP/opendcp/build/cli/opendcp_j2k -i ../TIF$nits -x -m ../tmp -o ../j2k
$EDRHOME/DCP/opendcp/build/cli/opendcp_mxf -i ../j2k -o Clip$nits.mxf
rm -fv ../j2k/* ../tmp/*

nits=200
$EDRHOME/DCP/opendcp/build/cli/opendcp_j2k -i ../TIF$nits -x -m ../tmp -o ../j2k
$EDRHOME/DCP/opendcp/build/cli/opendcp_mxf -i ../j2k -o Clip$nits.mxf
rm -fv ../j2k/* ../tmp/*

nits=150
$EDRHOME/DCP/opendcp/build/cli/opendcp_j2k -i ../TIF$nits -x -m ../tmp -o ../j2k
$EDRHOME/DCP/opendcp/build/cli/opendcp_mxf -i ../j2k -o Clip$nits.mxf
rm -fv ../j2k/* ../tmp/*

nits=100
$EDRHOME/DCP/opendcp/build/cli/opendcp_j2k -i ../TIF$nits -x -m ../tmp -o ../j2k
$EDRHOME/DCP/opendcp/build/cli/opendcp_mxf -i ../j2k -o Clip$nits.mxf
rm -fv ../j2k/* ../tmp/*

nits=48
$EDRHOME/DCP/opendcp/build/cli/opendcp_j2k -i ../TIF$nits -x -m ../tmp -o ../j2k
$EDRHOME/DCP/opendcp/build/cli/opendcp_mxf -i ../j2k -o Clip$nits.mxf
rm -fv ../j2k/* ../tmp/*

$EDRHOME/DCP/opendcp/build/cli/opendcp_xml --reel Clip300.mxf  --reel Clip200.mxf --reel Clip150.mxf --reel Clip100.mxf --reel Clip48.mxf  --digest OpenDCP --kind test -t "HDR Test StEM"
rm -fv ../j2k/* ../tmp/*

ls -l .
cd ..
exit

