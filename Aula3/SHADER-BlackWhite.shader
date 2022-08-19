Shader "Selner/Aula3/BlackWhite"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [KeywordEnum(R copied to GB, Average, Multiplication, None)] _BWMethod ("BlacknWhite Method", Int) = 3
        _Intensity ("Intensity", Range(0.0, 10.0)) = 1.0
        _Threshold ("Threshold", range(0.0, 1.0)) = 0.0
    }
    SubShader
    {Pass{
        CGPROGRAM
        #pragma vertex vert;
        #pragma fragment frag;

        uniform sampler2D _MainTex;
        int _BWMethod;
        float _Intensity;
        float _Threshold;

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
        float4 frag(VertexOutput input) : COLOR
        {
            float4 color = tex2D(_MainTex,input.texCoord.xy)*_Intensity;
            if(_BWMethod == 0){
                float4 col;
                if(color[0] >= _Threshold){
                    col = float4(color[0], color[0], color[0], 1);
                } else{
                    col = float4(0, 0, 0, 1);
                }
                return col;
            }
            if(_BWMethod == 1){
                float avg = (color[0] + color[1] + color[2])/3;
                if(avg < _Threshold){
                    avg = 0;
                }
                return float4(avg, avg, avg, 1);
            }
            if(_BWMethod == 2){
                float calc = 0.3*color[0] + 0.59*color[1] + 0.11*color[2];
                if(calc < _Threshold){
                    calc = 0;
                }
                return float4(calc, calc, calc, 1);
            } else{
                if(color[0] < _Threshold){
                    color[0] = 0;
                } if(color[1] < _Threshold){
                    color[1] = 0;
                } if(color[2] < _Threshold){
                    color[2] = 0;
                }
                return color;
            }
        }
        
        
        ENDCG
        }
    }
}
