# Image-Effects
Various image effects and filters. GLSL shaders created with the app [ShaderEditor](https://github.com/markusfisch/ShaderEditor).

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
