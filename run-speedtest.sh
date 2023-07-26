#!/bin/bash

# Change this to your timezone. Currently set to Europe/Berlin since this tool will probably only be used in germany
export TZ=Europe/Berlin

# this script is invoced every 6 minutes if clipboard is set to 'RUN', then a speedtest runs

while true
do
    echo "#############################"
    echo "Waiting 15 seconds, starting $(date +"%H:%M.%S")"
    # wait 65 seconds then try again
    sleep 10

    # extract clipboard
    clipboard="$(DISPLAY=:0 xclip -o)"
    SUB='RUN'

    echo "GENERAL DEBUG INFORMATION:"
    if [[ "$clipboard" == *"$SUB"* ]]; then
        echo "Clipboard string 'RUN' is being found."
    else 
        echo "Clipboard string 'RUN' cannot be found, value in clipboard currently is: $clipboard"
    fi
    if [ -f "/RUN" ]; then
        echo "File 'RUN' exists in the root directory."
    else
        echo "File 'RUN' does not exist in the root directory."
    fi
    echo "Current time is $(date +"%H:%M.%S")"

    # Get the current hour and minute in 24-hour format (e.g., 14:30)
    current_time=$(date +"%H:%M")

    # Extract the hour and minute components
    current_hour=${current_time:0:2}
    current_minute=${current_time:3:2}
    current_hour=${current_hour#0}
    current_minute=${current_minute#0}
    # Convert the start and end times to minutes for easier comparison
    start_time_minutes=$(( 7 * 60 + 30 ))
    end_time_minutes=$(( 21 * 60 ))

    # Convert the current time to minutes for comparison
    let "current_time_minutes=$current_hour * 60 + $current_minute"

    # Check if the current time is within the specified range
    if (( current_time_minutes >= start_time_minutes && current_time_minutes <= end_time_minutes )); then
        echo "The current time is between 07:30 and 21:00."

        # check if clipboard is set to 'RUN' or file RUN in root exists
        if [[ "$clipboard" == *"$SUB"* ]] || [ -f "/RUN" ]; then
            echo "Tring to start speedtest..."
            
            # messung durchfuehren
            DISPLAY=:0 xdotool mousemove 531 510
            DISPLAY=:0 xdotool click 1
            sleep 1

            # haeckchen
            DISPLAY=:0 xdotool mousemove 694 405
            DISPLAY=:0 xdotool click 1
            sleep 1
            DISPLAY=:0 xdotool mousemove 694 479
            DISPLAY=:0 xdotool click 1
            sleep 1
            DISPLAY=:0 xdotool mousemove 694 551
            DISPLAY=:0 xdotool click 1
            sleep 1
            DISPLAY=:0 xdotool mousemove 1169 405
            DISPLAY=:0 xdotool click 1
            sleep 1
            DISPLAY=:0 xdotool mousemove 1169 479
            DISPLAY=:0 xdotool click 1
            sleep 1
            DISPLAY=:0 xdotool mousemove 1169 551
            DISPLAY=:0 xdotool click 1
            sleep 1

            # messung starten
            DISPLAY=:0 xdotool mousemove 1091 668
            DISPLAY=:0 xdotool click 1
            sleep 1

            # wait 5:05 minutes
            echo "Waiting 5 minutes, starting $(date +"%H:%M.%S")"
            sleep 260
        else
            echo "NOT STARTING. Waiting for 'RUN' set in clipboard or file '/RUN' being available."
        fi
    else
        echo "NOT STARTING. The current time is outside the specified range of 07:30 and 21:00."
    fi
done


# xdotool getmouselocation

