#include "fivewin.ch"
#include "trating.ch"
#include "constant.ch"
function Main()

   local oDlg, oBrw, oLarge, oFont

   local aData    := { ;
      { "One",   2.5, 4.5, 3.5 }, ;
      { "Two",   1.5, 4.5, 2.5 }, ;
      { "Three", 4.5, 3.5, 1.5 }, ;
      { "Four",  3.5, 1.5, 4.5 }  }


     local Empty_Img:= ".\bitmaps\Empty.bmp"
     local  Full_Img:= ".\bitmaps\Full.bmp"
     local  Half_Img:=".\bitmaps\Half.bmp"



   DEFINE FONT oLarge NAME "VERDANA" SIZE 0,-48 BOLD
   DEFINE FONT oFont  NAME "TAHOMA"  SIZE 0,-15

   DEFINE DIALOG oDlg SIZE 800,260 PIXEL TRUEPIXEL FONT oFont ;
      TITLE "BOOK RATINGS"

   @ 20,20 XBROWSE oBrw SIZE -20,200 PIXEL OF oDlg ;
      DATASOURCE aData COLUMNS 1, 2, 3, 4 ;
      HEADERS "Book", "Design", "Content", "Global" ;
      LINES NOBORDER

   WITH OBJECT oBrw
      :AddBitmap( { Empty_Img, Full_Img, Half_Img } )
      :nWidths          := 140
      :nRowHeight       :=  50
      :lAllowSizings    := .f.
      :bPaintTexts      := { |oCol,hDC,cData,aRect| ShowRating( oCol, hDC, cData, aRect, oLarge ) }

      :aCols[ 1 ]:bPaintText  := nil

      WITH OBJECT :AddCol()
         :cHeader       := "Chart"
         :aChartCols    := { 2, 3, 4 }
         :nChartMaxVal  := 9
      END
      :SetGroupHeader( "Rating", 2, 4 )
      //
      :CreateFromCode()
   END


   @ 230,10 BUTTON "Nuovo" of  oDlg  PIXEL;
   SIZE 55,18 ACTION Edita(.t.,oBrw)

   @ 230,75 BUTTON "Modifica" of  oDlg  PIXEL;
   SIZE 55,18 ACTION Edita(.f.,oBrw)

   @ 230,145 BUTTON "Cancella" of  oDlg  PIXEL;
   SIZE 55,18 ACTION   DeleteRow( oBrw )

   ACTIVATE DIALOG oDlg CENTERED
   RELEASE FONT oLarge, oFont

   return nil



 /*
function ShowRating( oCol, hDC, cData, aRect, oLarge )

   local n, aBmpRect, aBitmap, nRating
   local nStars:= 5
   local nPercentual := 100

   nRating     := oCol:Value
   oCol:oBrw:SayText( nRating, aRect, nil, oLarge, CLR_HGRAY )
   aBmpRect    := { aRect[ 1 ], aRect[ 2 ] + 20, aRect[ 3 ], aRect[ 2 ] + 40 }


   for n := 1 to nStars

      aBitmap  := oCol:aBitmap( If( n > nRating, If(n < nRating, 3, 1 ), 2 ) )


      oCol:oBrw:SayPalBmp( aBitmap, aBmpRect )
      aBmpRect[ 2 ]  += 20
      aBmpRect[ 4 ]  += 20
   next

   return nil
    */
 //--------------------------------------------------------//

 function ShowRating( oCol, hDC, cData, aRect, oLarge )
   local n, aBmpRect, aBitmap, nRating
   local nStars:= 5
   local nPercentual := 5
   local vmax := 0, vmin
   local err  := nPercentual / (3*nStars)

   nRating     := oCol:Value
   oCol:oBrw:SayText( nRating, aRect, nil, oLarge, CLR_HGRAY )
   aBmpRect    := { aRect[ 1 ], aRect[ 2 ] + 20, aRect[ 3 ], aRect[ 2 ] + 40 }
   vmax := 0
    for n:=0 to nStars-1
     vmin := vmax
     vmax := (n+1) * nPercentual / nStars
       if nRating<vmin+err
            aBitmap  := oCol:aBitmap(1)
          elseif nRating>vmax-err
            aBitmap  := oCol:aBitmap(2)
         else
            aBitmap  := oCol:aBitmap(3)
         endif
      oCol:oBrw:SayPalBmp( aBitmap, aBmpRect )
      aBmpRect[ 2 ]  += 20
      aBmpRect[ 4 ]  += 20
   next

   return nil
 //--------------------------------------------------------//

Function edita(lNew,oBrw)
   Local oDlgNew
   Local nBottom   := 12
   Local nRight    := 62
   Local nWidth :=  Max( nRight * DLG_CHARPIX_W, 180 )
   Local nHeight := nBottom * DLG_CHARPIX_H
   local Empty_Img:= ".\bitmaps\Empty.bmp"
   local  Full_Img:= ".\bitmaps\Full.bmp"
   local  Half_Img:=".\bitmaps\Half.bmp"

   Local cBook
   Local nDesign
   Local nContent
   Local nGlobal
   Local aGet[4]
   Local oBtnOK,oBtnCan, nRecord, x


   If lNew

        cBook:= space(30)
        nDesign:= 0
        nContent:=0
        nGlobal:=0

     else

        nrecord:=  oBrw:nArrayAt
        cBook:= oBrw:aArrayData[nrecord][1]

        nDesign:= oBrw:aArrayData[nrecord][2]   //setValue ???
        nContent:=oBrw:aArrayData[nrecord][3]
        nGlobal:= oBrw:aArrayData[nrecord][4]

    Endif



  DEFINE DIALOG oDlgNew        ;
   TITLE "EDIT RATING"    ;
   SIZE nWidth, nHeight  PIXEL               ;
        STYLE nOr( DS_MODALFRAME, WS_POPUP, WS_CAPTION,  4 )

         @ 12,10 SAY "Book :" SIZE 45, 8 PIXEL OF oDlgNew
         @ 10,55 GET aGet[1] VAR cBook SIZE 100,11 PIXEL OF oDlgNew


         @ 26,10 SAY "Design :" SIZE 35,14 PIXEL OF oDlgNew
         @ 24, 55   RATING aGet[2] VAR nDesign;
             OF oDlgNew ;
              EMPTY Empty_Img ;
              HALF Half_Img;
              FULL Full_Img ;
              MAXVALUE     5

        @ 44,10 SAY "Content :" SIZE 35,14 PIXEL OF oDlgNew
       @ 42, 55 RATING aGet[3] VAR nContent;
             OF oDlgNew ;
              EMPTY Empty_Img ;
              HALF Half_Img;
              FULL Full_Img ;
              MAXVALUE     5

        @ 58,10 SAY "Global :" SIZE 35,14 PIXEL OF oDlgNew
        @ 56, 55 RATING aGet[4] VAR nGlobal;
             OF oDlgNew ;
              EMPTY Empty_Img ;
              HALF Half_Img;
              FULL Full_Img ;
              MAXVALUE     5

        IF lnew

        else
             nrecord:= oBrw:nArrayAt
         Endif

         for x= 2 to 4
             aGet[x]:lTransparent:= .t.
             aGet[x]:ocursor:= TCursor():New(,'HAND')

          next


   @ 63, 118 BUTTON oBtnOK PROMPT "&Conferma"  SIZE 55, 14 PIXEL ACTION ( oDlgNew:end( IDOK ) )
   @ 63, 182 BUTTON oBtnCan PROMPT "&Annulla"  SIZE 55, 14 PIXEL ACTION  ( oDlgNew:end( IDCANCEL ) )


   ACTIVATE DIALOG oDlgNew CENTERED

       IF oDlgNew:nresult == IDOK
          If lNew
             AAdd( oBrw:aArrayData,{cBook,nDesign,nContent,nGlobal})
          else
            nrecord:= oBrw:nArrayAt
            oBrw:aArrayData[nrecord][1]:=cBook
            oBrw:aArrayData[nrecord][2]:=nDesign
            oBrw:aArrayData[nrecord][3]:=nContent
            oBrw:aArrayData[nrecord][4]:=nGlobal
         Endif
      Endif


               oBrw:GoBottom()
               oBrw:SetFocus()

 return nil


static proc DeleteRow( oBrw )

   if ! Empty( oBrw:aArrayData )
      ADel( oBrw:aArrayData, oBrw:nArrayAt, .t. )
      oBrw:Refresh()
   endif







