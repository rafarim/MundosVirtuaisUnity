using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(PixelateRenderer), PostProcessEvent.AfterStack, "Selner/Pixelate")]
public sealed class Pixelate : PostProcessEffectSettings
{
    [Range(0f, 1f), Tooltip("Pixelation Strength")]
    public FloatParameter PixStr = new FloatParameter { value = 0.0f };
}

public sealed class PixelateRenderer : PostProcessEffectRenderer<Pixelate>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("Hidden/Selner/Pixelate"));
        float pxx = settings.PixStr.value;
        sheet.properties.SetFloat("_PXStr", pxx);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}