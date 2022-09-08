using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(BinMaskRenderer), PostProcessEvent.AfterStack, "Selner/BinMask")]
public sealed class BinMask : PostProcessEffectSettings
{
    [Tooltip("The binary mask to apply to the rendered image."), DisplayName("Mask")]
    public TextureParameter Mask = new TextureParameter { value = null };
}

public sealed class BinMaskRenderer : PostProcessEffectRenderer<BinMask>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("Hidden/Selner/BinMask"));
        var mask = settings.Mask.value == null
                ? RuntimeUtilities.whiteTexture
                : settings.Mask.value;
        sheet.properties.SetTexture("_Mask", mask);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}