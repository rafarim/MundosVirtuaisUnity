Shader "Selner/Aula2/CMYKtoRGB"
{
    Properties
    {
        _C ("Cyan 0-1", Range(0.0, 1.0)) = 0.0
        _M ("Magenta 0-1", Range(0.0, 1.0)) = 0.0
        _Y ("Yellow 0-1", Range(0.0, 1.0)) = 0.0
        _K ("Key 0-1", Range(0.0, 1.0)) = 0.0
    }
    SubShader
    {
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float _C;
            float _M;
            float _Y;
            float _K;

            float4 vert(float4 vertexPos:POSITION) :SV_POSITION
            {
                return UnityObjectToClipPos(vertexPos);
            }
            float4 frag() :Color
            {
                return float4(1.0 * (1.0 - _C) * (1 - _K) , 
                            1.0 * (1.0 - _M) * (1 - _K), 
                            1.0 * (1.0 - _Y) * (1 - _K),
                            1);
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}