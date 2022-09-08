Shader "Hidden/Selner/Pixelate"
{
    HLSLINCLUDE

        #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

        TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
        float4 _MainTex_TexelSize;
        float _PXStr;

        float4 Frag(VaryingsDefault i) : SV_Target
        {
            _PXStr = pow(abs(_PXStr - 1.025), 2);
            i.texcoord[0] = round(i.texcoord[0] * (_PXStr * _MainTex_TexelSize[2]))/ (_PXStr * _MainTex_TexelSize[2]);
            i.texcoord[1] = round(i.texcoord[1] * (_PXStr * _MainTex_TexelSize[3]))/ (_PXStr * _MainTex_TexelSize[3]);
            return SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
        }

    ENDHLSL

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM

                #pragma vertex VertDefault
                #pragma fragment Frag

            ENDHLSL
        }
    }
}