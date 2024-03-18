# dglsl

This library is an alpha version, and most functions are not yet implemented.

This is a library that makes it easier to use GLSL 3.3 shaders from D language.

## Install

Add the following in dub.json:

```json
  ...
  "stringImportPaths": ["./"],
  "dependencies": {
    "dglsl": "~>0.6.0"
  }
  ...
```

Don't forget to specify `stringImportPaths`.

## How to Use

Define a shader program as a class:

```dlang
import dglsl;

class VertShader : Shader!Vertex {
  @layout(location = 0)
  @input vec3 position;

  @layout(location = 1)
  @input vec3 color;

  @output vec3 vertColor;

  @uniform mat4 projectionMatrix;

  void main() {
    vertColor = color;
    gl_Position = projectionMatrix * vec4(position, 1.0);
  }
}

class FragShader : Shader!Fragment {
  @input vec3 vertColor;
  @output vec3 fragColor;

  void main() {
    fragColor = vec3(vertColor);
  }
}
```

Next, compile the shader and create the program:

```dlang
auto shader = new VertShader();
shader.compile();

auto frag = new FragShader();
frag.compile();

auto p = makeProgram(shader, frag);
glUseProgram(p.id);
p.projectionMatrix = mat4.identity;
```

After, render primitives using standard OpenGL 3 functions.
