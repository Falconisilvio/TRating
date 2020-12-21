#include "FiveWin.ch"

// test with bmp Hearth files

Function Test()

   LOCAL oDlg, oRating, oFont, oSay,oReset, oBrush

   DEFINE FONT oFont NAME "Tahoma" SIZE 0, -12

    DEFINE BRUSH oBrush FILENAME ".\bitmaps\backgrnd\paper2.bmp"

   define dialog oDlg size 400,200  BRUSH oBrush

   @ 10, 3 say   "My Rating :"  SIZE 59, 10 OF oDlg  PIXEL  FONT oFont
   @ 10, 150 say oSay PROMPT "    "  SIZE 59, 10 OF oDlg  PIXEL  FONT oFont

   oRating:= TRating():New(10,65,oDlg,,,,".\bitmaps\emptyh.bmp" ,".\bitmaps\halfh.bmp", ".\bitmaps\fullh.bmp" )
   oRating:ltransparent:=.t.
   oRating:oCursor := TCursor():New(,'HAND')
   oRating:bChanged := {|val| oSay:SetText(str(val,3)+"%")}
   
   oReset := TUrlLink():New( 10, 39,oDlg , .T., .F., oFont, "", "("+"Reset"+")" )
   oReset:SetColor(  oReset:nClrText, oReset:nClrPane )
   oReset:nClrOver = CLR_RED
   oReset:bAction =  { || (oRating:Reset(),oRating:refresh()) }

   activate dialog oDlg center
return 0
