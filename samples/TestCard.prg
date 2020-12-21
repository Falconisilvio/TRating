#include "FiveWin.ch"

// test on Window

Function Test()
    LOCAL oWnd, oRating, oFont, oSay, oReset

   DEFINE FONT oFont NAME "Tahoma" SIZE 0, -24

   define window  oWnd TITLE "New Rating Class with Cards"

   @ 23, 5 say   "My Rating :"  SIZE 120, 40 OF  oWnd  PIXEL  FONT oFont
   @ 21, 455 say oSay PROMPT "  "  SIZE 90, 26 OF  oWnd PIXEL  FONT oFont

   oRating:= TRating():New(24,205, oWnd,,,5,".\bitmaps\png\empty_card.png" ,;
                                            ".\bitmaps\png\half_card.png", ;
                                            ".\bitmaps\png\full_card.png" )
   oRating:ltransparent:=.t.
   oRating:oCursor := TCursor():New(,'HAND')
   oRating:bChanged := {|val| oSay:SetText(str(val,3)+"%")}
 *  oRating:lBorder:=.t.
   oRating:ctooltip:="Click to set value"
  // oRating:nImages := 10

   oReset := TUrlLink():New( 24, 120, oWnd , .T., .F., oFont, "", "("+"Reset"+")" )
   oReset:SetColor(  oReset:nClrText, oReset:nClrPane )
   oReset:nClrOver = CLR_RED
   oReset:bAction =  { || (oRating:Reset(),oRating:refresh()) }

 activate window oWnd
 return nil