function fish_prompt_detailed -d "Turns on/off fish_prompt_detailed"
    if test "$fish_prompt_detailed"
        set -e fish_prompt_detailed
        echo 'Detailed prompt turned OFF.'
    else
        set -xU fish_prompt_detailed true
        echo 'Detailed prompt turned ON.'
    end
end