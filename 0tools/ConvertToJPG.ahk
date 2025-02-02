#Requires AutoHotkey v2.0
#SingleInstance Force

/*************************************************************************
 * proposito: Convertir .webp en .jpg rapidamente
 * requisito: FFMPEG debe estar instalado y en el path de windows
 *              copiar al clipboard el path del .webp  CTRL + SHIFT + C en DoubleCommander
 * shortcut: la tecla F16 esta mapeada a "-" en mi teclado numpad secundario
*************************************************************************/


F16:: {
    ;MsgBox(A_Clipboard)     ;E:\assets3D\main\G9_BrennSciFiBundleG9andG8\G9_clothes_arcaneShot.jpg
    fotoPATH := A_Clipboard
    SplitPath fotoPATH,,,&extension
    
    fotoJPG  := StrReplace(fotoPATH,extension,"jpg")
    
    RunWait Format('ffmpeg -i {1} {2}', fotoPATH, fotoJPG)
    FileDelete(fotoPATH)
}

F20:: {                 ;boton - en teclado numerico extra
    Send "FanLing8"
}