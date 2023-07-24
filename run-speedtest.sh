#!/bin/bash

# this script is invoced every 6 minutes if clipboard is set to 'RUN', then a speedtest runs


while true
do

    # wait 65 seconds then try again
    sleep 10

    # check if /RUN File exists or clipboard set to RUN, and time is past 7:30
    # if [[ -f "/RUN" ]] && [[ $(date +%H:%M) > "07:30" ]]
    # if [[ "$clipboard" == *"$searchstring"* || -f "/RUN" ]] && [[ $(date +%H:%M) > "07:30" ]]
    # then
    # Get the current hour and minute in 24-hour format (e.g., 14:30)
    current_time=$(date +"%H:%M")

    # Extract the hour and minute components
    current_hour=${current_time:0:2}
    current_minute=${current_time:3:2}

    # Convert the start and end times to minutes for easier comparison
    start_time_minutes=$(( 7 * 60 + 30 ))
    end_time_minutes=$(( 21 * 60 ))

    # Convert the current time to minutes for comparison
    current_time_minutes=$(( current_hour * 60 + current_minute ))

    # Check if the current time is within the specified range
    if (( current_time_minutes >= start_time_minutes && current_time_minutes <= end_time_minutes )); then
        echo "The current time is between 07:30 AM and 09:00 PM."

        # check if clipboard is set to 'RUN' or file RUN in root exists
        clipboard="$(DISPLAY=:0 xclip -o)"
        searchstring="RUN"
        if [ "$clipboard" == *"$searchstring"* ] || [ -f "/RUN" ]; then
            echo "Tring to start speedtest..."
            
            # messung durchfuehren
            DISPLAY=:0 xdotool mousemove 531 510
            DISPLAY=:0 xdotool click 1


            # haeckchen
            DISPLAY=:0 xdotool mousemove 694 405
            DISPLAY=:0 xdotool click 1
            DISPLAY=:0 xdotool mousemove 694 479
            DISPLAY=:0 xdotool click 1
            DISPLAY=:0 xdotool mousemove 694 551
            DISPLAY=:0 xdotool click 1

            DISPLAY=:0 xdotool mousemove 1169 405
            DISPLAY=:0 xdotool click 1
            DISPLAY=:0 xdotool mousemove 1169 479
            DISPLAY=:0 xdotool click 1
            DISPLAY=:0 xdotool mousemove 1169 551
            DISPLAY=:0 xdotool click 1

            # messung starten
            DISPLAY=:0 xdotool mousemove 1091 668
            DISPLAY=:0 xdotool click 1


            # wait 5:05 minutes
            sleep 260
            echo "waiting 5 minutes..."

        else
            echo "#############################"
            echo "NOT STARTING. Waiting for 'RUN' set in clipboard or file '/RUN' being available."
            echo "DEBUG information:"
            echo "Value in clipboard currently is: $clipboard"
            if [ "$clipboard" == *"$searchstring"*]; then
                echo "Clipboard string exists."
            else 
                echo "Clipboard string does not exist."
            fi
            if [ -f "/RUN" ]; then
                echo "File 'RUN' exists in the root directory."
            else
                echo "File 'RUN' does not exist in the root directory."
            fi
        fi
    else
        echo "NOT STARTING. The current time is outside the specified range of 07:30 AM and 09:00 PM."
    fi
done


# xdotool getmouselocation

