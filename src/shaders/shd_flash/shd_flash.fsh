varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float intensity; 

void main() {
    gl_FragColor = vec4(vec3(1.0), texture2D(gm_BaseTexture, v_vTexcoord).a * intensity); 
}
