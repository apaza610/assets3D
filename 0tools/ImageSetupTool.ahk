#Requires AutoHotkey v2.0
#SingleInstance Force

/*************************************************************************
 * proposito: Crear una GUI para estandarizar los nombres de fotos de los assets
 *              convertir todas las imagenes a .jpg
 *              descargar en batch nuevas fotos para nuevos assets
*************************************************************************/
global MiGui := ""

#o::{
    JPGpathFull   := A_Clipboard                                ; E:\assets3D\main\G8_YOGACouplesPosesForMaleAndFemale\poses_G8_00.jpg
    JPGpathName   := StrSplit(JPGpathFull, "\")[-1]             ; poses_G8_00.jpg
    JPGbaseName   := StrSplit(JPGpathName, ".")[1]              ; poses_G8_00
    JPGpathFolder := StrReplace(JPGpathFull, JPGpathName, "")   ; E:\assets3D\main\G8_YOGACouplesPosesForMaleAndFemale
    JPGpathFixed  := ""

    global MiGui            ; borrar instancias viejas
    if IsObject(MiGui){
        MiGui.Destroy()
        MiGui := ""
    }
    
    MiGui := Gui()          ; "+AlwaysOnTop"

    pathIMG := MiGui.AddEdit("-Multi w220 h20", StrReplace(JPGbaseName, " "))
    MiGui.Add("Text",, "tipoDeAsset:")

    rbCH := MiGui.AddRadio("vTipoGroup", "character")
    rbCR := MiGui.AddRadio(, "creature")
    rbCL := MiGui.AddRadio(, "clothes")
    rbH  := MiGui.AddRadio(, "hair")
    rbP  := MiGui.AddRadio("Checked", "poses")
    rbPR := MiGui.AddRadio(, "props")
    rbE  := MiGui.AddRadio(, "environments")
    rbVE := MiGui.AddRadio(, "vehicles")
    rbM  := MiGui.AddRadio(, "materials")
    rbT  := MiGui.AddRadio(, "tools")

    MiGui.Add("Text", "x120 y30", "Generacion:")

    rbG3  := MiGui.AddRadio("vGeneracionGroup", "G3")
    rbG3M := MiGui.AddRadio(, "G3M")
    rbG3F := MiGui.AddRadio(, "G3F")
    rbG8  := MiGui.AddRadio(, "G8")
    rbG8M := MiGui.AddRadio(, "G8M")
    rbG8F := MiGui.AddRadio(, "G8F")
    rbG9  := MiGui.AddRadio("Checked", "G9")
    rbG9M := MiGui.AddRadio(, "G9M")
    rbG9F := MiGui.AddRadio(, "G9F")

    boton := MiGui.Add("Button","x10 y240 w75","Single")
    boton.OnEvent("Click", RenombrarUnaFoto)

    boton := MiGui.Add("Button","x100 y240 w75","Batch")
    boton.OnEvent("Click", RenombrarBatchFotos)

    MiGui.Show("w250")
    MiGui.Title := "IMGsetupTool"

    RenombrarUnaFoto(*){
        selectedTipo := ""
        selectedGene := ""
        for radio in [rbCH, rbCR, rbCL, rbH, rbP, rbPR, rbE, rbVE, rbM, rbT]{
            if radio.Value {
                selectedTipo := radio.Text
                break
            }
        }
        for radio in [rbG3, rbG3F, rbG3M, rbG8, rbG8F, rbG8M, rbG9, rbG9F, rbG9M,]{
            if radio.Value {
                selectedGene := radio.Text
                break
            }
        }
        JPGpathFixed := JPGpathFolder . selectedTipo . "_" . selectedGene . "_" . pathIMG.Text . ".jpg"
        FileMove(JPGpathFull, JPGpathFixed)
    }

    RenombrarBatchFotos(*){
        selectedTipo := ""
        selectedGene := ""
        for radio in [rbCH, rbCR, rbCL, rbH, rbP, rbPR, rbE, rbVE, rbM, rbT]{
            if radio.Value {
                selectedTipo := radio.Text
                break
            }
        }
        for radio in [rbG3, rbG3F, rbG3M, rbG8, rbG8F, rbG8M, rbG9, rbG9F, rbG9M,]{
            if radio.Value {
                selectedGene := radio.Text
                break
            }
        }
        SelectedFOTOS := FileSelect("M3", JPGpathFolder)
        n := 1
        for foto in SelectedFOTOS {
            JPGpathFixed := JPGpathFolder . selectedTipo . "_" . selectedGene . "_" . pathIMG.Text . n . ".jpg"
            FileMove(foto, JPGpathFixed)
            ; MsgBox(foto)
            n := n + 1
        }
    }
}