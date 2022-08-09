Shader "Selner/Aula2/CMYKtoRGB"
{
    Properties
    {
        _Col1 ("C", Range(0.0, 1.0)) = 0.0
        _Col2 ("M", Range(0.0, 1.0)) = 0.0
        _Col3 ("Y", Range(0.0, 1.0)) = 0.0
        _Col4 ("K", Range(0.0, 1.0)) = 0.0
    }
    SubShader
    {
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float _Col1;
            float _Col2;
            float _Col3;
            float _Col4;

            float4 vert(float4 vertexPos:POSITION) :SV_POSITION
            {
                return UnityObjectToClipPos(vertexPos);
            }
            float4 frag() :Color
            {
                float r = 1.0 * (1.0 - _Col1) * (1 - _Col4);
                float g = 1.0 * (1.0 - _Col2) * (1 - _Col4);
                float b = 1.0 * (1.0 - _Col3) * (1 - _Col4);
                float4 col = float4(r,g,b,1); 
                return col;
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}