Shader "Custom/HsvShader"
{
    Properties
    {
        _Hue("Hue",Range(0,360)) = 0
        _Saturation("Saturation",Range(0,1)) = 1
        _Value("Value",Range(0,1)) = 1
    }
    SubShader
    {
    Pass{
        CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag

        float _Hue;
        float _Saturation;
        float _Value;

        struct VertexOutput
        {
            float4 pos : SV_POSITION;
            float4 color : TEXCOORD0;
        };

        VertexOutput vert(float4 vertexPos:POSITION) 
        {
            VertexOutput output;

            float4 colorRGB = float4(1.0,1.0,1.0,1.0);
            if(_Saturation == 0.0)
            {
                colorRGB.rgb = _Value;
            }else
            {
                int hi;
                float hue,f,p,q,t;
                if(_Hue >=360.0)
                {
                    _Hue -= 360;
                }
                hue = _Hue/60.0;
                hi = int(hue);
                f = hue - hi;
                p = _Value * (1.0 - _Saturation);
                q = _Value * (1.0 - f * _Saturation);
                t = _Value * (1.0 - (1.0 - f) * _Saturation);

                if(hi == 0)
                {
                    colorRGB.r = _Value;
                    colorRGB.g = t;
                    colorRGB.b = p;
                }else if(hi == 1)
                {
                   colorRGB.rgb = float3(q,_Value,p); 
                }else if(hi == 2)
                {
                    colorRGB.rgb = float3(p,_Value,t); 
                }else if(hi == 3)
                {
                    colorRGB.rgb = float3(p,q,_Value); 
                }else if(hi == 4)
                {
                    colorRGB.rgb = float3(t,p,_Value); 
                }else if(hi == 5)
                {
                    colorRGB.rgb = float3(_Value,p,q);
                }
            }
            output.color = colorRGB;
            output.pos = UnityObjectToClipPos(vertexPos);

            return output;
        }
        float4 frag(VertexOutput input) : COLOR
        {
            return input.color;
        }

        ENDCG
            
        }
    }
}
