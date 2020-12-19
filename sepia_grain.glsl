#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform samplerExternalOES cameraBack;
uniform vec2 cameraAddent;
uniform mat2 cameraOrientation;
uniform float ftime;
float grain = 0.25;
float aspectRatio = 18.5 / 16.0;

float luma(vec3 color)
{ return dot(color, vec3(0.299, 0.587, 0.114)); }

void main(void) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  //camera texture
  vec2 st = cameraAddent + uv * cameraOrientation;
  st.x = st.x * aspectRatio +
    (1.0 - aspectRatio) / 2.0;
  vec3 col = texture2D(cameraBack, st).rgb;

  //film grain
  float toRadians = 3.14 / 180.0;
  float randomIntensity = fract(100000.0 *
    sin((gl_FragCoord.x + gl_FragCoord.y *
      ftime) * toRadians));
  col += grain * randomIntensity;
  col = vec3(luma(col),
    0.7 * luma(col), 0.4 * luma(col));

  //crop image to aspect ratio of the camera
  col = col * step(st.x, 1.0) * step(0.0, st.x);

  gl_FragColor = vec4(col, 1.0);
}
