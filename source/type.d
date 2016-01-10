
module dglsl.type;

public import gl3n.linalg : Vector, Matrix;

struct sampler2D {
    // TODO:
}

vec4 texture(sampler2D sampler, vec2 p, float bias = 0) {
    // TODO:
    assert(false);
}
vec4 textureOffset(sampler2D sampler, vec2 p, ivec2 offset, float bias = 0) {
    // TODO:
    assert(false);
}

alias vec2  = Vector!(float, 2);
alias ivec2 = Vector!(int,   2);
alias uvec2 = Vector!(uint,  2);
alias bvec2 = Vector!(ubyte,  2); // this should be bool?
alias vec3  = Vector!(float, 3);
alias ivec3 = Vector!(int,   3);
alias uvec3 = Vector!(uint,  3);
alias bvec3 = Vector!(ubyte,  3); // this should be bool?
alias vec4  = Vector!(float, 4);
alias ivec4 = Vector!(int,   4);
alias uvec4 = Vector!(uint,  4);
alias bvec4 = Vector!(ubyte,  4); // this should be bool?

alias mat2x2 = Matrix!(float, 2, 2);
alias mat2x3 = Matrix!(float, 2, 3);
alias mat2x4 = Matrix!(float, 2, 4);
alias mat3x2 = Matrix!(float, 3, 2);
alias mat3x3 = Matrix!(float, 3, 3);
alias mat3x4 = Matrix!(float, 3, 4);
alias mat4x2 = Matrix!(float, 4, 2);
alias mat4x3 = Matrix!(float, 4, 3);
alias mat4x4 = Matrix!(float, 4, 4);
alias mat2 = mat2x2;
alias mat3 = mat3x3;
alias mat4 = mat4x4;

string glslType(T)() {
    static if (is(T == vec2)) return "vec2";
    else static if (is(T == vec3)) return "vec3";
    else static if (is(T == vec4)) return "vec4";
    else static if (is(T == ivec2)) return "ivec2";
    else static if (is(T == ivec3)) return "ivec3";
    else static if (is(T == ivec4)) return "ivec4";
    else static if (is(T == uvec2)) return "uvec2";
    else static if (is(T == uvec3)) return "uvec3";
    else static if (is(T == uvec4)) return "uvec4";
    else static if (is(T == bvec2)) return "bvec2";
    else static if (is(T == bvec3)) return "bvec3";
    else static if (is(T == bvec4)) return "bvec4";
    else static if (is(T == mat2x2)) return "mat2x2";
    else static if (is(T == mat2x3)) return "mat2x3";
    else static if (is(T == mat2x4)) return "mat2x4";
    else static if (is(T == mat3x2)) return "mat3x2";
    else static if (is(T == mat3x3)) return "mat3x3";
    else static if (is(T == mat3x4)) return "mat3x4";
    else static if (is(T == mat4x2)) return "mat4x2";
    else static if (is(T == mat4x3)) return "mat4x3";
    else static if (is(T == mat4x4)) return "mat4x4";
    else return T.stringof;
}

unittest {
    assert(glslType!vec2 == "vec2");
    assert(glslType!vec3 == "vec3");
    assert(glslType!vec4 == "vec4");
    assert(glslType!ivec2 == "ivec2");
    assert(glslType!bvec3 == "bvec3");
    assert(glslType!uvec4 == "uvec4");

    assert(glslType!mat2 == "mat2x2");
    assert(glslType!mat3 == "mat3x3");
    assert(glslType!mat4 == "mat4x4");
    assert(glslType!mat2x2 == "mat2x2");
    assert(glslType!mat2x3 == "mat2x3");
    assert(glslType!mat2x4 == "mat2x4");
    assert(glslType!mat2x3 == "mat2x3");
    assert(glslType!mat3x3 == "mat3x3");
    assert(glslType!mat4x3 == "mat4x3");

    assert(glslType!int == "int");
    assert(glslType!uint == "uint");
    assert(glslType!bool == "bool");
}

