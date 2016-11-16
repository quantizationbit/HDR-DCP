//  709 linear 1.0 = 1.0 nit to 2020 PQ 0.0-1.0


import "ACESlib.Utilities";
import "ACESlib.Utilities_Color";
import "ACESlib.Transform_Common";
import "ACESlib.ODT_Common";


const float XYZ_2_2020_PRI_MAT[4][4] = XYZtoRGB(REC2020_PRI,1.0);
const float R709_PRI_2_XYZ_MAT[4][4] = RGBtoXYZ(REC709_PRI,1.0);


void main 
(
  input varying float rIn, 
  input varying float gIn, 
  input varying float bIn, 
  output varying float rOut,
  output varying float gOut,
  output varying float bOut 
)
{
  // Put input variables (OCES) into a 3-element vector
  float R709[3] = {rIn, gIn, bIn};
  

// convert from P3 to XYZ
     float XYZ[3] = mult_f3_f44( R709, R709_PRI_2_XYZ_MAT);
    // Convert from XYZ to ACES primaries
    float outputCV[3] = mult_f3_f44( XYZ, XYZ_2_2020_PRI_MAT);
    outputCV = Y_2_ST2084_f3(outputCV);


  rOut = outputCV[0];
  gOut = outputCV[1];
  bOut = outputCV[2];
  //aOut = aIn;
}


