Shader "Selner/Aula4/KernelConvolution"
{
    Properties
    {
        _MainTex ("Image", 2D) = "white" {}
        [KeywordEnum(None, Blur, Edge Detection, Sharpening, Emboss)] _Effect ("BlacknWhite Method", Int) = 0
    }
    SubShader
    {Pass{
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag

        uniform sampler2D _MainTex;
        float4 _MainTex_TexelSize;
        int _Effect;

        struct VertexInput
        {
            float4 vertex : POSITION;
            float4 texCoord : TEXCOORD0;
        };

        struct VertexOutput
        {
            float4 pos : SV_POSITION;
            float4 texCoord : TEXCOORD0;
        };

        VertexOutput vert(VertexInput input)
        {
            VertexOutput output;
            output.pos = UnityObjectToClipPos(input.vertex);
            output.texCoord = input.texCoord;
            return output;
        }

        float4 applyEffect(float3x3 ker, sampler2D tex, float4 uvs, float4 size)
        {
            int i, a, b;
            float3x3 temp;
            float4 res = float4(0.0, 0.0, 0.0, 0.0);
            for(i = 0; i < 4; i++){
                for(a = -1; a < 2; a++){
                    for(b = -1; b < 2; b++){
                        temp[a+1][b+1] = tex2D(tex, uvs + float2(a*size.x, b*size.y))[i];
                    }
                }
                for(a = 0; a < 3; a++){
                    for(b = 0; b < 3; b++){
                        res[i] += temp[b][a] * ker[2-b][2-a];
                    }
                }
            }
            return res;
        }

        float4 frag(VertexInput input) : COLOR
        {
            if(_Effect == 0){
                return tex2D(_MainTex, input.texCoord.xy);
            }
            float3x3 kern;
            if(_Effect == 1){
                kern = float3x3(0.111, 0.111, 0.111,
                                0.111, 0.111, 0.111,
                                0.111, 0.111, 0.111);
            }
            if(_Effect == 2){
                kern = float3x3(0.5, 1, 0.5,
                                1, -6, 1,
                                 0.5, 1, 0.5);
            }
            if(_Effect == 3){
                kern = float3x3(0, -1, 0,
                                -1, 5, -1,
                                0, -1, 0);
            }
            if(_Effect == 4){
                kern = float3x3(-2, -1, 0,
                                -1, 0, 1,
                                0, 1, 2);
            }

            return applyEffect(kern, _MainTex, input.texCoord, _MainTex_TexelSize);
        }
        
        ENDCG
        }
    }
}
