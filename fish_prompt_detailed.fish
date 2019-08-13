function fish_prompt_detailed -d "Turns on/off fish_detailed_prompt"
    if test "$fish_prompt_detailed"
        set -e fish_prompt_detailed
    else
        set -xU fish_prompt_detailed true
    end
end