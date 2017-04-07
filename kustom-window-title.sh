#!/usr/local/bin/fish

# this block is so you can use it from the command line with -t and -w
if test "$argv" != "" -a (math (count $argv)%2 == 0)
    for i in (seq 1 (count $argv))
        if test $argv[$i] = '-t'
            set title_i_want $argv[(math 1 + $i)]
        else if test $argv[$i] = '-w'
            set window_id $argv[(math 1 + $i)]
        end
    end
    if not test $window_id
        echo "YOU DIDN'T ENTER A `window_id` WITH `-w`,
SO MAKE SURE THE WINDOW YOU WANT HAS FOCUS
TWO SECONDS FROM NOW!"
        sleep 2
    end
end

# get the id of the currently focused window
if not test $window_id
    set window_id (xprop -root _NET_ACTIVE_WINDOW | grep -P -o "0x\w+")
end

# get the title to force on that window

if not test $title_i_want
    set title_i_want (kdialog --title "entitled" --inputbox "type the title you want and hit enter.
to stop renaming,
just enter nothing and hit esc")
end

# this bit is needed for a kludge that allows window renaming
set has_renamed_before "FALSE"
set interrupt_message "WAIT WAIT I WANT A TURN BLOO BLOO BLEE BLUH BLOO" # hopefully i never want to actually use that as a title xD
xprop -f _NET_WM_NAME 8u -set _NET_WM_NAME $interrupt_message -id $window_id

# take the output of xprop
# pipe it into a while loop
# everytime it outputs a new line
# stuff it into a variable named "current_title"
xprop -spy _NET_WM_NAME -id $window_id | while read current_title

    # cut off extraneous not-the-title bits of that string
    set current_title (echo $current_title | grep -P -o '(?<=_NET_WM_NAME\(UTF8_STRING\) = ").*(?="\z)')

    # if the current title is the interrupt message
    # AND
    # this script has renamed the window at least once before
    # then we wanna let the new name take over
    if test $current_title = $interrupt_message -a $has_renamed_before = "TRUE"
        exit
    # if title_i_want is an empty string, exit
    else if test $title_i_want = ""
        xprop -f _NET_WM_NAME 8u -set _NET_WM_NAME "WIDNOW WILL START RENAMING ITSELF AS NORMAL" -id $window_id
        exit
    # otherwise just change the title to what i want
    else if test $current_title != $title_i_want
        xprop -f _NET_WM_NAME 8u -set _NET_WM_NAME "$title_i_want" -id $window_id
        set has_renamed_before "TRUE"
    end
end