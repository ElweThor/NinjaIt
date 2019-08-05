#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\..\..\Program Files (x86)\AutoIt3\Aut2Exe\Icons\AutoIt_Main_v10_256x256_RGB-A.ico
#AutoIt3Wrapper_Outfile_x64=NinjaIt.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author: Elwe Thor

 Script Function: allow to have "external macro" of Final Fantasy XIV Ninja
	ninjutsu special moves/spells.
	 As the minimum allowed Wait time, in FF, is 1 second, it's a waste of time
	to make an FF macro to cast ninjutsu (e.g. 3 whole seconds to cast Suiton).
	 As Autoit doesn't have such limitation, it can be used instead: every mudra
	element, Ten, Chi, and Jin, have a cast time of 0.5s (up to FFXIV 5.0)

		Elwe Thor,	August 2019

#ce ----------------------------------------------------------------------------

#pragma compile(FileVersion, 1.0.2.9_20190805)
#pragma compile(InternalName, "NinjaIt")
#pragma compile(LegalCopyright, "(C)2019 Elwe Thor")
#pragma compile(ProductName, NinjaIt)
#pragma compile(ProductVersion, 1.2.3.4, 1.0.2.9_20190805)

#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIProc.au3>
#include <WinAPISysWin.au3>




;	___Global Init___
Global $isActive = False							; let's start INactive
Global Const $recast = 550							; 0.55", 550 ms
Global $splash = True								; True: show a splash screen at start | False: don't
;Global Const $togKeys = "ctrl+alt+F5"
Global $togKeysShort = "^!{F5}"
Global $fumaKeyShort = "^1"
Global $katonKeyShort = "^2"
Global $raitonKeyShort = "^3"
Global $hyotonKeyShort = "^4"
Global $hutonKeyShort = "^5"
Global $dotonKeyShort = "^6"
Global $suitonKeyShort = "^7"
Global $splashFile = "NinjaIt.jpg"
Global $splashWidth = 870
Global $splashHeight = 870
Global Const $configFile = "NinjaIt.config.txt"		; config file's name
;	Randomizer
;
;  It seems that FF counts the time interval between mudras, excluding the Ninjutsu (last) one.
;  So, if a player casts Fuma, a fixed delay between Ten and Ninjutsu is acceptable (and the combo succeedes)
; but, if a player tries casting Raiton, which requires Ten + Chi + Ninjutsu, there are TWO "gaps" to measure
; the system can compare them... and temporarily "locks" Ninjutsu
;  A solution is to add a random delta to make the delays all different
Global $rmin = 10, $rMAX = 150, $giveInt = 1		; randomizer's values: min time to add 10 ms, max 150 ms, give an int, not a float
if(not ReadConfig()) Then Exit						; try reading the config files for (possible) overrides

SplashImageOn("", _WinAPI_GetProcessWorkingDirectory & $splashFile, $splashWidth, $splashHeight, (_WinAPI_GetWindowWidth/2-$splashWidth/2), (_WinAPI_GetWindowHeight/2-$splashHeight/2),$DLG_NOTITLE)
ToolTip("Ninjutsu helper READY" & @CRLF & " press " & $togKeysShort & " keys to activate")

#cs
	___INPUT___

	As ninjutsu mudras are 7, I can use ^1..^7 with ctrl+alt+F5 to toggle the helper

	_input keys_
	^1	Fuma
	^2	Katon
	^3	Raiton
	^4	Hyoton
	^5	Houton
	^6	Doton
	^7	Suiton

	___OUTPUT___

	The above keys, to work, must "press" the T, C, J, and M keys, which must be present in the hotbars as well
	So the logic is:
		1) the player presses an "input key" (^1...^7)
		2) this automation selects the right sequence and presses the T,C,J needed keys, ending with M one
		prerequisite is to activate the automation before (if inactive, the automation does nothing at all)
#ce

HotKeySet($togKeysShort, "toggle")
HotKeySet($fumaKeyShort, "NinjaIt")
HotKeySet($katonKeyShort, "NinjaIt")
HotKeySet($raitonKeyShort, "NinjaIt")
HotKeySet($hyotonKeyShort, "NinjaIt")
HotKeySet($hutonKeyShort, "NinjaIt")
HotKeySet($dotonKeyShort, "NinjaIt")
HotKeySet($suitonKeyShort, "NinjaIt")

Sleep(5000)
ToolTip("")											; clear any tooltip
SplashOff()

While 1
    Sleep(100)										; relaxed infinite loop, in the wait of the keys
WEnd

;
;	___TOGGLE___
;
Func toggle()
	if($isActive) Then
		ToolTip("Ninjutsu helper ready/idle @CRLF press " & $togKeysShort & " keys to re-activate")
		$isActive = False
	Else
		ToolTip("Ninjutsu helper ACTIVE @CRLF press " & $togKeysShort & " keys to de-activate")
		$isActive = True
	EndIf
	Sleep(2000)
	ToolTip("")										; clear any tooltip
EndFunc


#cs

 The mudra elements: Ten, Chi, Jin, and Ninjutsu "unleasher"

#ce
; ___TEN___
Func Ten()
	Send("{F5}", $SEND_DEFAULT)
	Sleep($recast + Random($rmin, $rMAX, $giveInt))
EndFunc

; ___CHI___
Func Chi()
	Send("{F6}", $SEND_DEFAULT)
	Sleep($recast + Random($rmin, $rMAX, $giveInt))
EndFunc

; ___JIN___
Func Jin()
	Send("{F7}", $SEND_DEFAULT)
	Sleep($recast + Random($rmin, $rMAX, $giveInt))
EndFunc

; ___Ninjutsu___
Func Ninjutsu()
	Send("{F8}", $SEND_DEFAULT)
EndFunc


#cs
	NinjaIt automation: converts the single keypress into a full ninjutsu mudra
#ce
;
;	___NINJUTSU___
;
func NinjaIt()
	if($isActive) Then
		Switch @HotKeyPressed
			Case "^1"								; Fuma
				ToolTip("FUMA")
				Ten()

			Case "^2"								; Katon
				ToolTip("KATON")
				Chi()
				Ten()

			Case "^3"								; Raiton
				ToolTip("RAITON")
				Ten()
				Chi()

			Case "^4"								; Hyoton
				ToolTip("HYOTON")
				Chi()
				Jin()

			Case "^5"								; Houton
				ToolTip("HOUTON")
				Jin()
				Chi()
				Ten()

			Case "^6"								; Doton
				ToolTip("DOTON")
				Jin()
				Ten()
				Chi()

			Case "^7"								; Suiton
				ToolTip("SUITON")
				Ten()
				Chi()
				Jin()

		EndSwitch
		Ninjutsu()									; unleash the power ;)
		ToolTip("")									; clear any tooltip
	EndIf
EndFunc


;
; Read the config file
;
; Exit with False if problem arose, or True if all went well
;
;			   /-> #
; config lines --> 	 <-- only blanks or CRLF
;			   \-> element = value <- this is the whole content after the "="
;
Func ReadConfig()
	Local $fline = ""								; a text line from file
	Local $pline									; a text array from the parser
	Local $element = ""								; parsed element name
	Local $value = ""								; parsed value
	Local $hFO										; fileOpen handler

	ToolTip("INIT > reading config")
	if(FileGetSize($configFile) > 0) Then			; test if config file is present
		$hFO = FileOpen($configFile, $FO_READ)		; open the config
		If $hFO = -1 Then
			ToolTip("INIT > reading config > An error occurred when reading the file.")
			Return False
		Else
			while(Not @error)						; read 'till EoF
				$fline = FileReadLine($hFO)			; read 1 (next) line from line 1
				ToolTip("INIT > read > " & $fline)
				$fline = StringStripWS($fline, 8)
				if(StringLeft($fline, 1) = "#" or $fline = "") Then ; comment or empty line
				Else
					$pline = StringSplit($fline, "=")
					if(not @error And $pline[0] = 2) Then	; if there is no error, splitting, and elements are 2
						$element = $pline[1]
						$value = $pline[2]
						Select
							Case $element = "toggleKey"
								$togKeysShort = $value
							Case $element = "fuma"
								$fumaKeyShort = $value
							Case $element = "katon"
								$katonKeyShort = $value
							Case $element = "raiton"
								$raitonKeyShort = $value
							Case $element = "hyoton"
								$hyotonKeyShort = $value
							Case $element = "huton"
								$hutonKeyShort = $value
							Case $element = "doton"
								$dotonKeyShort = $value
							Case $element = "suiton"
								$suitonKeyShort = $value
							Case $element = "splash"
								$splash = $value
							Case $element = "splashFile"
								$splashFile = $value
							Case $element = "splashWidth"
								$splashWidth = Number($value)
							Case $element = "$splashHeight"
								$splashHeight = Number($value)
							Case $element = "endconfig"
								Return True
						EndSelect
						Else
						MsgBox($MB_SYSTEMMODAL, "", "INIT > read > An error occurred when parsing config line@CRLF" & $fline)
						Return False
					EndIf
				EndIf
			WEnd
			FileClose($hFO)
		EndIf
	Else
		ToolTip("INIT > reading config > An error occurred when testing the file presence.@CRLF Working with defaults only")
		Return False
    EndIf
	Return True
EndFunc
