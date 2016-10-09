; AUTOHOTKEY DEFAULTS
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Set mode to zero, followed by default values and help-box

mode=0
sleeptimer= 1000
skipamount = 3

HelpMessage=NVivo Faster Attribute Input Script: This is a short script that enables keystroke input of attribute values within NVivo using the numpad. `n`nTo enable the hotkeys please press the windows key and p `n`nOnce active, rather than right-clicking on a participants case node and selecting node properties, please left-click on it once so it is selected then press win+p again. Please wait for the first part of the script to run, and importantly, please don't press any additional keys during this time.  The script will open the node properties, shift to the attributes tab, and select the value field for the first variable. `n`nEach number on the numpad will select the corresponding attribute value. For example, if after 'Not Applicable' and 'Unassigned' the second value is "Turner" then numpad 2 will set the value to "Turner" and move the selection to the next attribute value field `n`nPressing enter on the numpad will skip back up one attribute, handy if you accidently chose a wrong value. Additionally, pressing the plus on the numpad will skip to the next attribute. Pressing star on the numpad will set the attribute value to Not Applicable. Finally, pressing subtract on the numpad will return the attribute value back to unassigned. `n`nNVivo for binary attributes places the No value before the Yes value meaning that they are the opposite way around than you might expect. `n`nFor age and other integer values, please use the number keys on the top of the keyboard to enter the participant's age then press the plus on the numpad to move to the next attribute and resume using the numbers on the numpad- using the keys on the numpad for trying to input age will result in the script selecting a random age from those already inputted.  `n`nPressing the Windows key and enter on the Numpad together will exit the faster attribute input mode. `n`nPressing the Windows key and o together will bring up an options menu that can be used to set the sleep timer and the number of attributes to skip. The first is useful if NVivo is running slow to allow a wait period inbetween opening the node properties and moving  the selection focus to the attribute values. The second is useful if, for example, you are adding attributes for a second or third wave of interviews and you would like to skip all the attributes from the first wave when inputting the values for each participant.  `n`nPressing 'pause' at any time (located top right of the keyboard) will pause the script and stop the hotkeys from working and pressing it again will reactivate the script.  `n`nPressing the Windows key and q at any time (when the keys are not paused) will force the script to close.  `n`nNeed help?  Press F12 at any time to open this message box again. `n`nBy `nAlasdair B R Stewart `ne-mail: abe@constellations.scot `nhome page: constellations.scot
MsgBox, %HelpMessage%
F12::MsgBox, %HelpMessage%


;Conditional hotkey to activate faster input.
#if (mode=0)

#p::
mode=1
MsgBox, NVivo faster attribute input mode active, press F12 for help. Windows key + NumPad Enter exits this mode.
Return
#If


; Faster attribute input mode
#if (mode=1)

;To ensure that we are using the correct keys
SetNumLockState, On

;Hotkey to open node properties, switch to attributes, and, optionally, skip a set number of tabs
#p::
Send ^+p!v
sleep, %sleeptimer%
Send {Tab %skipamount%}
Return

;GUI for changing default variables
#o::
	vsleeptimer = %sleeptimer%
	vskipamount = %skipamount%
	Gui, -caption
	Gui, Color, B
	Gui, Font, S10 CWhite Bold, Verdana
	Gui, Add, Text,, Time to sleep in seconds:
	Gui, Add, Edit, vsleeptimer
	Gui, Add, Text,, Number of attributes to skip:
	Gui, Add, Edit, vskipamount
	Gui, Add, Button, Default, Submit
	Gui, Show
Return

;GUI submit
ButtonSubmit:
	Gui, Submit
	if sleeptimer is not integer
		MsgBox, Warning: Sleep timer needs to be an integer, will default to one second
	if sleeptimer is not integer
		sleeptimer:=1
	if skipamount is not integer
		MsgBox, Warning: Skip amount needs to be an integer, will default to zero
	sleeptimer:=(sleeptimer*1000)
	skipamount:=(skipamount*2+3)
	Gui, Destroy
Return

Numpad1::
Send {Down 3}{Tab 2}
return

Numpad2::
Send {Down 4}{Tab 2}
return

Numpad3::
Send {Down 5}{Tab 2}
return

Numpad4::
Send {Down 6}{Tab 2}
return

Numpad5::
Send {Down 7}{Tab 2}
return

Numpad6::
Send {Down 8}{Tab 2}
return

Numpad7::
Send {Down 9}{Tab 2}
return

Numpad8::
Send {Down 10}{Tab 2}
return

Numpad9::
Send {Down 11}{Tab 2}
return

Numpad0::
Send {Down 12}{Tab 2}
return

+Numpad1::
Send {Down 13}{Tab 2}
return

+Numpad2::
Send {Down 14}{Tab 2}
return

+Numpad3::
Send {Down 15}{Tab 2}
return

+Numpad4::
Send {Down 16}{Tab 2}
return

+Numpad5::
Send {Down 17}{Tab 2}
return

;Not Applicable
NumpadSub::
Send {Down 2}{Tab 2}
return

;Unasssigned
NumpadMult::
Send, {Down}{Tab 2}
Return

;Skip an attribute
NumpadAdd::
Send {Tab 2}
return

;Skip back an attribute
NumpadEnter::
Send +{Tab 2}
return

;Switch back to mode 0 so that numpad keys are no longer hotkeys
#NumpadEnter::
mode=0
MsgBox, Exited attribute mode, Numpad keys will work as usual again.
Return

#if 

; control of app

#q::ExitApp
pause::suspend