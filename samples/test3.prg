#include "FiveWin.ch"
#include "trating.ch"

// test with png files

Function Test()

   LOCAL oDlg, oRating, oFont, oSay,oReset, oBrush

   DEFINE FONT oFont NAME "Tahoma" SIZE 0, -14

    DEFINE BRUSH oBrush FILENAME ".\bitmaps\backgrnd\paper2.bmp"


   define dialog oDlg size 300,100  BRUSH oBrush  TITLE "New Rating Class"

   @ 24, 3 say   "My Rating :"  SIZE 59, 10 OF oDlg  PIXEL  FONT oFont  TRANSPARENT
   @ 22, 130 say oSay PROMPT "  "  SIZE 20, 10 OF oDlg  PIXEL  FONT oFont TRANSPARENT


         @ 21,65 RATING oRating ;
             OF oDlg ;
              EMPTY ".\bitmaps\png\empty.png" ;
              HALF ".\bitmaps\png\half.png";
              FULL ".\bitmaps\png\full.png" ;
              INITIAL      10       ;
              MAXVALUE     100      ;
              ON CHANGE  oSay:SetText(str(oRating:nSelectedValue,3)+"%")



  oRating:oCursor := TCursor():New(,'HAND')





   oReset := TUrlLink():New( 24, 39,oDlg , .T., .F., oFont, "", "("+"Reset"+")" )
   oReset:SetColor(  oReset:nClrText, oReset:nClrPane )
   oReset:nClrOver = CLR_RED
   oReset:bAction =  { || (oRating:Reset(),oRating:refresh()) }

   activate dialog oDlg center


return 0
