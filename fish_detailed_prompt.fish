function fish_detailed_prompt -d "Turns on/off fish_detailed_prompt"
    if test "$fish_detailed_prompt"
        set -e fish_detailed_prompt
    else
        set -xU fish_detailed_prompt true
    end
end