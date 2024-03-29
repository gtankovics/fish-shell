function fish_prompt_detailed -d "Turns on/off fish_prompt_detailed"
    if test "$fish_prompt_detailed"
        set -e fish_prompt_detailed
        set -xU LAST_GOOGLE_CONFIG $GOOGLE_CONFIG
        fchenv clear
        if which starship > /dev/null
            starship toggle gcloud
        end
        echo 'Detailed prompt turned OFF. `gcloud` and `kubectl` unset.'
    else
        set -xU fish_prompt_detailed true
        if which starship > /dev/null
            starship toggle gcloud
        end
        fchenv set $LAST_GOOGLE_CONFIG
        echo 'Detailed prompt turned ON.'
    end
end