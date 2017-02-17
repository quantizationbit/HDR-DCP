const float SDR_CINEMA_PEAK_LUMINANCE = 48.0;
const float SDR_CINEMA_THEATER_BLACK_LUMINANCE = 0.024;
const float SDR_CINEMA_THEATER_BLACK_CHROMATICITY_x = 0.314;
const float SDR_CINEMA_THEATER_BLACK_CHROMATICITY_y = 0.351;

// derived from above constants
const float SDR_CINEMA_THEATER_BLACK_X = SDR_CINEMA_THEATER_BLACK_CHROMATICITY_x * SDR_CINEMA_THEATER_BLACK_LUMINANCE / SDR_CINEMA_THEATER_BLACK_CHROMATICITY_y;
const float SDR_CINEMA_THEATER_BLACK_Y = SDR_CINEMA_THEATER_BLACK_LUMINANCE;
const float SDR_CINEMA_THEATER_BLACK_Z  = (1.0 - SDR_CINEMA_THEATER_BLACK_CHROMATICITY_x - SDR_CINEMA_THEATER_BLACK_CHROMATICITY_y) * SDR_CINEMA_THEATER_BLACK_LUMINANCE / SDR_CINEMA_THEATER_BLACK_CHROMATICITY_y;

////////////////////////////////////////////////////////////
// from ACESlib.Utilties_Color.a1.0.1.ctl

// Base functions from SMPTE ST 2084-2014

// Constants from SMPTE ST 2084-2014
const float pq_m1 = 0.1593017578125; // ( 2610.0 / 4096.0 ) / 4.0;
const float pq_m2 = 78.84375; // ( 2523.0 / 4096.0 ) * 128.0;
const float pq_c1 = 0.8359375; // 3424.0 / 4096.0 or pq_c3 - pq_c2 + 1.0;
const float pq_c2 = 18.8515625; // ( 2413.0 / 4096.0 ) * 32.0;
const float pq_c3 = 18.6875; // ( 2392.0 / 4096.0 ) * 32.0;

const float pq_C = 10000.0;

// Converts from linear cd/m^2 to the non-linear perceptually quantized space
// Note that this is in float, and assumes normalization from 0 - 1
// (0 - pq_C for linear) and does not handle the integer coding in the Annex 
// sections of SMPTE ST 2084-2014
float Y_2_ST2048( float C )
{
  // Note that this does NOT handle any of the signal range
  // considerations from 2084 - this returns full range (0 - 1)
  float L = C / pq_C;
  float Lm = pow( L, pq_m1 );
  float N = ( pq_c1 + pq_c2 * Lm ) / ( 1.0 + pq_c3 * Lm );
  N = pow( N, pq_m2 );
  return N;
}
////////////////////////////////////////////////////////////


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

    // Decode DCDM (relative luminance above black)
    float X = (52.37/48.0) * pow(rIn, 2.6);
    float Y = (52.37/48.0) * pow(gIn, 2.6);
    float Z = (52.37/48.0) * pow(bIn, 2.6);
    
    // multiply by peak luminance
    X = SDR_CINEMA_PEAK_LUMINANCE * X;
    Y = SDR_CINEMA_PEAK_LUMINANCE * Y;
    Z = SDR_CINEMA_PEAK_LUMINANCE * Z;
    
    // Add theater black to simulate SDR Cinema black level while using Dolby Projector
    X = X + SDR_CINEMA_THEATER_BLACK_X;
    Y = Y + SDR_CINEMA_THEATER_BLACK_Y;
    Z = Z + SDR_CINEMA_THEATER_BLACK_Z;
    
    // encode into 10000 nits PQ
    rOut = Y_2_ST2048( X );
    gOut = Y_2_ST2048( Y );
    bOut = Y_2_ST2048( Z );
} 
