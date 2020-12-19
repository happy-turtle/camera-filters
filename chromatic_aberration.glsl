#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform samplerExternalOES cameraBack;
uniform vec2 cameraAddent;
uniform mat2 cameraOrientation;
float aspectRatio = 18.5 / 16.0;

float amount = 0.003;

void main(void) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  //camera texture
  vec2 st = cameraAddent + uv * cameraOrientation;
  st.x = st.x * aspectRatio +
    (1.0 - aspectRatio) / 2.0;

  //chromatic aberration
  vec2 dist = 16.0 * pow(st - 0.5, vec2(3.0, 3.0));
  amount *= length(dist);
  vec3 col = vec3(texture2D(cameraBack, st - amount).r,
    texture2D(cameraBack, st).g,
    texture2D(cameraBack, st + amount).b);

  //crop image to aspect ratio of the camera
  col = col * step(st.x, 1.0) * step(0.0, st.x);

  gl_FragColor = vec4(col, 1.0);
}
