#Requires AutoHotkey v2.0
#SingleInstance Force

/*************************************************************************
 * proposito: Crear una GUI para estandarizar los nombres de fotos de los assets
 *              convertir todas las imagenes a .jpg
 *              descargar en batch nuevas fotos para nuevos assets
*************************************************************************/
; global MiGui := ""

; #o::{
;     JPGpathFull   := A_Clipboard                                ; E:\assets3D\main\G8_YOGACouplesPosesForMaleAndFemale\poses_G8_00.jpg
;     JPGpathName   := StrSplit(JPGpathFull, "\")[-1]             ; poses_G8_00.jpg
;     JPGbaseName   := StrSplit(JPGpathName, ".")[1]              ; poses_G8_00
;     JPGpathFolder := StrReplace(JPGpathFull, JPGpathName, "")   ; E:\assets3D\main\G8_YOGACouplesPosesForMaleAndFemale
;     JPGpathFixed  := ""

;     global MiGui            ; borrar instancias viejas
;     if IsObject(MiGui){
;         MiGui.Destroy()
;         MiGui := ""
;     }
    
;     MiGui := Gui()          ; "+AlwaysOnTop"

;     pathIMG := MiGui.AddEdit("-Multi w220 h20", StrReplace(JPGbaseName, " "))
;     MiGui.Add("Text",, "tipoDeAsset:")

;     rbCH := MiGui.AddRadio("vTipoGroup", "character")
;     rbCR := MiGui.AddRadio(, "creature")
;     rbCL := MiGui.AddRadio(, "clothes")
;     rbH  := MiGui.AddRadio(, "hair")
;     rbP  := MiGui.AddRadio("Checked", "poses")
;     rbPR := MiGui.AddRadio(, "props")
;     rbE  := MiGui.AddRadio(, "environments")
;     rbVE := MiGui.AddRadio(, "vehicles")
;     rbM  := MiGui.AddRadio(, "materials")
;     rbT  := MiGui.AddRadio(, "tools")

;     MiGui.Add("Text", "x120 y30", "Generacion:")

;     rbG3  := MiGui.AddRadio("vGeneracionGroup", "G3")
;     rbG3M := MiGui.AddRadio(, "G3M")
;     rbG3F := MiGui.AddRadio(, "G3F")
;     rbG8  := MiGui.AddRadio(, "G8")
;     rbG8M := MiGui.AddRadio(, "G8M")
;     rbG8F := MiGui.AddRadio(, "G8F")
;     rbG9  := MiGui.AddRadio("Checked", "G9")
;     rbG9M := MiGui.AddRadio(, "G9M")
;     rbG9F := MiGui.AddRadio(, "G9F")

;     boton := MiGui.Add("Button","x10 y240 w75","Single")
;     boton.OnEvent("Click", RenombrarUnaFoto)

;     boton := MiGui.Add("Button","x100 y240 w75","Batch")
;     boton.OnEvent("Click", RenombrarBatchFotos)

;     MiGui.Show("w250")
;     MiGui.Title := "IMGsetupTool"

;     RenombrarUnaFoto(*){
;         selectedTipo := ""
;         selectedGene := ""
;         for radio in [rbCH, rbCR, rbCL, rbH, rbP, rbPR, rbE, rbVE, rbM, rbT]{
;             if radio.Value {
;                 selectedTipo := radio.Text
;                 break
;             }
;         }
;         for radio in [rbG3, rbG3F, rbG3M, rbG8, rbG8F, rbG8M, rbG9, rbG9F, rbG9M,]{
;             if radio.Value {
;                 selectedGene := radio.Text
;                 break
;             }
;         }
;         JPGpathFixed := JPGpathFolder . selectedTipo . "_" . selectedGene . "_" . pathIMG.Text . ".jpg"
;         FileMove(JPGpathFull, JPGpathFixed)
;     }

;     RenombrarBatchFotos(*){
;         selectedTipo := ""
;         selectedGene := ""
;         for radio in [rbCH, rbCR, rbCL, rbH, rbP, rbPR, rbE, rbVE, rbM, rbT]{
;             if radio.Value {
;                 selectedTipo := radio.Text
;                 break
;             }
;         }
;         for radio in [rbG3, rbG3F, rbG3M, rbG8, rbG8F, rbG8M, rbG9, rbG9F, rbG9M,]{
;             if radio.Value {
;                 selectedGene := radio.Text
;                 break
;             }
;         }
;         SelectedFOTOS := FileSelect("M3", JPGpathFolder)
;         n := 1
;         for foto in SelectedFOTOS {
;             JPGpathFixed := JPGpathFolder . selectedTipo . "_" . selectedGene . "_" . pathIMG.Text . n . ".jpg"
;             FileMove(foto, JPGpathFixed)
;             ; MsgBox(foto)
;             n := n + 1
;         }
;     }
; }

/*************************************************************************
 * proposito: Convertir .webp en .jpg rapidamente
 * requisito: FFMPEG debe estar instalado y en el path de windows
 *              copiar al clipboard el path del .webp  CTRL + SHIFT + C en DoubleCommander
 * shortcut: la tecla F16 esta mapeada a "-" en mi teclado numpad secundario
*************************************************************************/
; F16:: {
;     ;MsgBox(A_Clipboard)     ;E:\assets3D\main\G9_BrennSciFiBundleG9andG8\G9_clothes_arcaneShot.jpg
;     fotoPATH := A_Clipboard
;     SplitPath fotoPATH,,,&extension
    
;     fotoJPG  := StrReplace(fotoPATH,extension,"jpg")
    
;     RunWait Format('ffmpeg -i {1} {2}', fotoPATH, fotoJPG)
;     FileDelete(fotoPATH)
; }

; F20:: {                 ;boton + en teclado numerico extra
;     Send "Content"
; }

; CoordMode, Mouse, A_ScreenDPI

F16:: {                    ; es el boton -
    CoordMode("Mouse", "Screen")
    MouseGetPos(&mouseX, &mouseY)
    ; MsgBox("enX: " mouseX " enY: " mouseY)
    MiGui := Gui(,"path del ZIP to be fixed:")          ;
    ElScript := "arreglaZIPcontentFolder.ps1"       ;"D:\borrador2\arreglaZIP.ps1"

    EditPath := MiGui.AddEdit("w280")
    MiGui.AddButton("","Arreglar").OnEvent("Click", ArreglarElZIP)
    MiGui.Show("x" mouseX " y" mouseY)

    ArreglarElZIP(*) {
        PathZIP := EditPath.Text
        Run(Format('PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File {1} {2}', ElScript, PathZIP))
    }
}

; quitar espacios en blanco y guiones de nombres de files o folders
F20::ArreglarPath()

ArreglarPath() {
    oldPath := StrReplace(A_Clipboard, '"',)         ; evitar comillas dobles
    if FileExist(oldPath) {
        SplitPath(oldPath, &nombre, &folder, &extension, &nombreSinExt, &disco)
        
        nombreFix := RegExReplace(nombreSinExt, "\b(\w)", "$U1")  ; capitalizar each word
        nombreFix := RegExReplace(nombreFix,"[\s-_]",)       ; quitar espacios y rayas

        newPath := RegExReplace(oldPath,nombreSinExt,nombreFix)

        if InStr(FileExist(oldPath), "A"){                  ; si es un archive
            FileMove(oldPath, newPath)
        }else if InStr(FileExist(oldPath), "D"){            ; si es un directory
            DirMove(oldPath, newPath)
        }
    }
    else {
        MsgBox("previamente capturar path con: Ctrl+C")
    }

    ; cadena := "asi es-el phi 314"
    ; ej1 := RegExReplace(cadena,"\s+","")         ; asies-elphi314
    ; ej2 := RegExReplace(cadena,"[\s-]","")       ; asieselphi314
    ; ej3 := RegExReplace(cadena,"\s(\w)","$U1")   ; asiEs-elPhi314
    ; ej4 := RegExReplace(cadena,"\b(\w)","$U1")   ; Asi Es-El Phi 314
    ; MsgBox(ej4)
}
