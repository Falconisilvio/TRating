#include "FiveWin.ch"

// test on Window with faces




Function Test()
    LOCAL oWnd, oRating, oFont, oSay, oReset
    local oSaytext,oFontbig
     SetBalloon( .T. )
   DEFINE FONT oFont NAME "Tahoma" SIZE 0, -24
   DEFINE FONT oFontbig NAME "Tahoma" SIZE 0, -96
   define window  oWnd TITLE "New Rating Class"

   @ 23, 5 say   "My Rating :"  SIZE 120, 40 OF  oWnd  PIXEL  FONT oFont
   @ 22, 535 say oSay PROMPT "  "  SIZE 90, 26 OF  oWnd PIXEL  FONT oFont
   @ 122, 5 say oSaytext  PROMPT "              "  SIZE 800, 200 OF  oWnd PIXEL  FONT oFontbig  color CLR_RED
   oRating:= TRating():New(22,205, oWnd,,,10,".\bitmaps\png\empty_face.png" ,".\bitmaps\png\half_face.png", ".\bitmaps\png\full_face.png" )
     oRating:nCurrentValue := 100
              oRating:nPercentual:= 100
   oRating:ltransparent:=.t.
   oRating:oCursor := TCursor():New(,'HAND')
   oRating:bChanged := {|val| (oSay:SetText(str(val,3)+"%"), oSaytext:SetText( Explanation( oRating ))) }
  * oRating:lBorder:=.t.
   oRating:ctooltip:="Click to set value"
  // oRating:nImages := 10

   oReset := TUrlLink():New( 24, 120, oWnd , .T., .F., oFont, "", "("+"Reset"+")" )
   oReset:SetColor(  oReset:nClrText, oReset:nClrPane )
   oReset:nClrOver = CLR_RED
   oReset:bAction =  { || (oRating:Reset(),oRating:refresh()) }

 activate window oWnd
 return nil


Function Explanation( oRating )
   Local cText
   do case
        case  oRating:nSelectedValue= 10
           cText :="I'm initiating now"
        case  oRating:nSelectedValue= 20
           cText :="I am on first part"
        case  oRating:nSelectedValue= 30
           cText :="Don't finish"
        case  oRating:nSelectedValue= 40
           cText :="Wasn't great"
        case  oRating:nSelectedValue= 50
           cText :="So and so"
        case  oRating:nSelectedValue= 60
           cText :="Ok book"
        case  oRating:nSelectedValue= 70
           cText :="Good"
        case  oRating:nSelectedValue= 80
           cText :="Really good"
        case  oRating:nSelectedValue= 90
           cText :="Fantastic"
        case  oRating:nSelectedValue= 100
           cText :="Amazing"
           endcase
   return cText
