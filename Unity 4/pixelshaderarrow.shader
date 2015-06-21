Shader "Custom/Lightbulbs-Arrows" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("Bump", 2D) = "bump" {}
        _NormalStrength ("Normal Strength", Float) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _LightColor ("Light Color", Color) = (1,1,1,1)
        _CenterY ("Center Y", Float) = 0
        _BufferY ("Buffer Y", Float) = 0
        _Slant ("Slant", Range(0,1)) = 1
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0 // shader model 3.0 as target for quality

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _NormalStrength;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _LightColor;
        float _CenterY;
        float _BufferY;
        float _Slant;


        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o) {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb*_Color;

            o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_MainTex));
            o.Normal=lerp(float3(0,0,1),o.Normal,_NormalStrength);

            // begin imaginary pixel shader

            // texture space to bulb-space
            // (1 unit=1 bulb=1 texture tile)
            float2 bulb=floor(IN.uv_MainTex);

            // bend the arrow
            float yOffset=abs(bulb.y-_CenterY)*_Slant;
            yOffset=max(0,yOffset-_BufferY);

            // draw two versions of the arrow and combine them
            float sinValue=sin(bulb.x-_Time.z*3.0+yOffset)*.5+.5;
            float sinValue2=sin(bulb.x-_Time.z*5.2+yOffset)*.5+.5;
            sinValue*=sinValue*sinValue*sinValue;
            sinValue2*=sinValue2*sinValue2;

            sinValue=max(sinValue,sinValue2);

            o.Emission=max(0,c-0.05)*_LightColor*sinValue;

            // end imaginary pixel shader

            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}