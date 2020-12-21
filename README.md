# Image-Effects
Various image effects and filters. GLSL shaders created with the app [ShaderEditor](https://github.com/markusfisch/ShaderEditor).

| Chromatic Aberation | Sepia Grain | Grayscale | Kaleidoscope | Glitch |
| -------- | -------- | -------- | -------- | -------- |
| <img width="120" height="246" alt="chromatic_aberration" src="https://user-images.githubusercontent.com/18415215/102819950-b55f9500-43d4-11eb-867f-f70dc5489cd6.gif">| <img width="120" height="246" alt="sepia_grain" src="https://user-images.githubusercontent.com/18415215/102820011-d2946380-43d4-11eb-9ac6-5b52519696a2.gif"> | <img width="120" height="246" alt="grayscale" src="https://user-images.githubusercontent.com/18415215/102819987-c5777480-43d4-11eb-8a20-c15a7b3ad026.gif"> | <img width="120" height="246" alt="kaleidoscope" src="https://user-images.githubusercontent.com/18415215/102819999-cc05ec00-43d4-11eb-9653-0025d923774d.gif"> | <img width="120" height="246" alt="glitch" src="https://user-images.githubusercontent.com/18415215/102819974-bee8fd00-43d4-11eb-9893-348ba34d7ed3.gif"> |

### Aspect Ratio
My phone's camera has a different aspect ratio than the display resolution. That is why I added the following three lines in most of the shaders to add black borders at the top and bottom:

    [...]
    float aspectRatio = 18.5 / 16.0;
    [...]
    st.x = st.x * aspectRatio +
      (1.0 - aspectRatio) / 2.0;
    [...]
    //crop image to aspect ratio of the camera
    col = col * step(st.x, 1.0) * step(0.0, st.x);
