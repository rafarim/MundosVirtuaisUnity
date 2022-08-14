Shader "Selner/Aula2/HSBtoRGB"
{
    Properties
    {
        _H ("Hue 0-360", Range(0.0, 360.0)) = 0.0
        _S ("Saturation 0-1", Range(0.0, 1.0)) = 0.0
        _B ("Brightness 0-1", Range(0.0, 1.0)) = 0.0
    }
    SubShader
    {
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float _H;
            float _S;
            float _B;

            float4 vert(float4 vertexPos:POSITION) :SV_POSITION
            {
                return UnityObjectToClipPos(vertexPos);
            }
            float4 frag() :Color
            {
                float C = (1 - abs(2 * _B) - 1) * _S;
                float H = _H/60;
                float X = C * (1 - abs(H % 2 - 1));
                float m = _B - C/2;
                if(0 < H && H < 1){
                    return float4(C+m, X+m, 0+m, 1);
                }; 
                if(1 <= H && H <= 2){
                    return float4(X+m, C+m, 0+m, 1);
                }; 
                if(2 <= H && H <= 3){
                    return float4(0+m, C+m, X+m, 1);
                }; 
                if(3 <= H && H <= 4){
                    return float4(0+m, X+m, C+m, 1);
                }; 
                if(4 <= H && H <= 5){
                    return float4(X+m, 0+m, C+m, 1);
                } else{
                    return float4(C+m, 0+m, X+m, 1);
                }
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}