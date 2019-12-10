function fish_prompt_detailed_show_datetime -d "Turns on/off date/time in fish_prompt_detailed"
    if test "$fish_prompt_detailed_show_datetime"
        set -e fish_prompt_detailed_show_datetime
        echo 'Date/time in detailed prompt turned OFF.'
    else
        set -xU fish_prompt_detailed_show_datetime true
        echo 'Date/time in detailed prompt turned ON.'
    end
end