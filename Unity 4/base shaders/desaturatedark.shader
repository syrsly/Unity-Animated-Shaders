// Upgrade NOTE: replaced 'PositionFog()' with multiply of UNITY_MATRIX_MVP by position
// Upgrade NOTE: replaced 'V2F_POS_FOG' with 'float4 pos : SV_POSITION'

Shader "custom/Desaturated Darks" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _Darkening ("Darkening", Range (0,1)) = 0.5
}
Category {
    /* Upgrade NOTE: commented out, possibly part of old style per-pixel lighting: Blend AppSrcAdd AppDstAdd */
    Fog { Color [_AddFog] }
    
    #warning Upgrade NOTE: SubShader commented out; uses Unity 2.x style fixed function per-pixel lighting. Per-pixel lighting is not supported without shaders anymore.
/*SubShader {
        
        // Ambient pass
        Pass {
            Name "BASE"
            Tags {"LightMode" = "Always" /* Upgrade NOTE: changed from PixelOrNone to Always */}
CGPROGRAM
// profiles arbfp1
// fragment frag
// fragmentoption ARB_fog_exp2
// fragmentoption ARB_precision_hint_fastest

#include "UnityCG.cginc"

uniform sampler2D _MainTex;
uniform float _Darkening;
uniform float4 _Color;

half4 frag( v2f_vertex_lit i ) : COLOR
{
    // texture
    half4 texcol = tex2D( _MainTex, i.uv ) * _Color;
    half unlit = Luminance( texcol.xyz ) * (1.0 - _Darkening);
    texcol.xyz = unlit;
    return texcol;
}
ENDCG
            SetTexture [_MainTex] {}
        }
        
        // Vertex lit pass
        Pass {
            Name "BASE"
            Tags {"LightMode" = "Vertex"}
            Material {
                Diffuse [_Color]
                Ambient (0,0,0,0)
            }
            Lighting On

CGPROGRAM
// profiles arbfp1
// fragment frag
// fragmentoption ARB_fog_exp2
// fragmentoption ARB_precision_hint_fastest

#include "UnityCG.cginc"

uniform sampler2D _MainTex;
uniform float _Darkening;
uniform float4 _Color;

half4 frag( v2f_vertex_lit i ) : COLOR
{
    // texture
    half4 texcol = tex2D( _MainTex, i.uv );

    // intensity of the lighting
    half brightness = saturate(Luminance( i.diff.xyz ) * 2);
    
    // color of completely unlit & desaturated areas
    half unlit = Luminance(
        lerp( texcol.xyz, texcol.xyz * i.diff.xyz, _Darkening ) );
    
    // final color based on lighting intensity
    half4 c;
    c.xyz = lerp( half3(unlit), texcol.xyz * i.diff.xyz * 2.0, brightness );
    
    c.w = texcol.w * i.diff.w;
    return c;
}
ENDCG

            SetTexture [_MainTex] {}
        }
        
        // Pixel lit pass
        Pass {
            Name "PPL"
            Tags { "LightMode" = "Pixel" }
            // This lighting is not additive, instead it must
            // blend over existing grayscale into saturated.
            // So we output light's intensity into alpha
            // and blend.
            Blend SrcAlpha OneMinusSrcAlpha
            ColorMask RGB
            
CGPROGRAM
// profiles arbfp1
// vertex vert
// fragment frag
// autolight 7
// fragmentoption ARB_fog_exp2
// fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"
#include "AutoLight.cginc"

struct v2f {
    float4 pos : SV_POSITION;
    float2    uv            : TEXCOORD0;
    float3    normal        : TEXCOORD1;
    float3    lightDir    : TEXCOORD2;
    V2F_LIGHT_COORDS(TEXCOORD3);
};
struct v2f2 { 
    float4 pos : SV_POSITION;
    float2    uv            : TEXCOORD0;
    float3    normal        : TEXCOORD1;
    float3    lightDir    : TEXCOORD2;
};

v2f vert (appdata_base v)
{
    v2f o;
    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
    o.normal = v.normal;
    o.uv = TRANSFORM_UV(0);
    o.lightDir = ObjSpaceLightDir( v.vertex );    
    PASS_LIGHT_COORDS(1);
    return o;
}

uniform sampler2D _MainTex : register(s0);
uniform float _Darkening;
uniform float4 _Color;

half4 frag( v2f2 i, LIGHTDECL(TEXUNIT1) ) : COLOR
{
    // texture
    half4 texcol = tex2D( _MainTex, i.uv );
    
    // intensity of the lighting
    half brightness = Luminance( DiffuseLight( i.lightDir, i.normal, _ModelLightColor[0], LIGHTATT ).rgb );
    
    half4 c;
    c.rgb = texcol.rgb * _ModelLightColor[0].rgb;
    c.a = brightness;
    return c;
}
ENDCG
            SetTexture [_MainTex] {}
            SetTexture [_LightTexture0] {}
            SetTexture [_LightTextureB0] {}
        }
    }*/
}

Fallback " Diffuse", 1
}