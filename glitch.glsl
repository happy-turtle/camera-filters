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
float aspectRatio = 18.5 / 16.0;

float _Amount = 0.003;
float _Fill = 0.1;
float _Frequency = 10000.0;

float random(float x) {
  return fract(sin(dot(vec2(x),
    vec2(12.9898, 78.233))) * 43758.5453123);
}

void main(void) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  //camera texture
  vec2 st = cameraAddent + uv * cameraOrientation;
  st.x = st.x * aspectRatio +
    (1.0 - aspectRatio) / 2.0;

  //random stripes
  float stripes = step(_Fill,
    random(floor(uv.y * _Frequency * ftime)));

  //displacement
  st += stripes * 0.005;

  //chromatic aberration
  vec2 dist = 16.0 * pow(st - 0.5, vec2(3.0, 3.0));
  _Amount *= length(dist);
  vec3 col = vec3(texture2D(cameraBack, st - _Amount).r,
    texture2D(cameraBack, st).g,
    texture2D(cameraBack, st + _Amount).b);

  //crop image to aspect ratio of the camera
  col = col * step(st.x, 1.0) * step(0.0, st.x);

  gl_FragColor = vec4(col, 1.0);
}
