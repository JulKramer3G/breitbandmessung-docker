    current_time=$(date +"%H:%M")
    current_hour=${current_time:0:2}
    current_minute=${current_time:3:2}
    current_hour=${current_hour#0}
    current_minute=${current_minute#0}
    # Convert the start and end times to minutes for easier comparison
    start_time_minutes=$(( 7 * 60 + 30 ))
    end_time_minutes=$(( 21 * 60 ))
    echo "$current_hour min: $current_minute"
let "current_time_minutes=$current_hour * 60 + $current_minute"
# Check if the current time is within the specified range
    if (( current_time_minutes >= start_time_minutes && current_time_minutes <= end_time_minutes )); then
        echo "The current time is between 07:30 AM and 09:00 PM."
    fi