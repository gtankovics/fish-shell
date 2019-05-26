function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # detauled prompt

    if test -n "$fish_detailed_prompt"

        # collect data for fish prompt

        if not test -n "$prompt_counter"
            set -U $prompt_counter 0
        end

        if test -n "$reset_fish_detailed_prompt"
            set $prompt_counter 100
            set -e $reset_fish_detailed_prompt
        end

        if test "$prompt_counter" -gt 14
            set -U prompt_counter 0
            set_color -b magenta -i
            echo -n " Reload NVM_CURRENT_VERSION, GOOGLE_CONFIG_NAME, GOOGLE_PROJECT, K8S_CLUSTER, K8S_CLUSTER_VERSION "
            set_color normal
            echo
            set -xU GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
            set -xU GOOGLE_CONFIG_NAME (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
            set -xU K8S_CLUSTER (kubectl config current-context 2>&1)
            if test $K8S_CLUSTER != "error: current-context is not set"
                set -xU K8S_CLUSTER_VERSION (kubectl version --short | awk '/Server/{print$3}')
            else
                set -xU K8S_CLUSTER_VERSION "n/a"
            end
            if test (node -v)
                if test (npm -v)
                    set -xU NVM_CURRENT_VERSION (node -v)'/'(npm -v)
                else
                    set -xU NVM_CURRENT_VERSION (node-v)'/ undefined'
                end
            else
                set -xU NVM_CURRENT_VERSION 'undefined / undefined'
            end
        else
            set -U prompt_counter (math "$prompt_counter+1")
        end

        # check Google Config Name
        if not test -n "$GOOGLE_CONFIG_NAME"
            set -xU GOOGLE_CONFIG_NAME (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
        end

        # check GOOGLE PROJECT
        if not test -n "$GOOGLE_PROJECT"
            set -xU GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
        end

        if not test -n "$K8S_CLUSTER"
            set -xU K8S_CLUSTER (kubectl config current-context)
        end

        # set -l IFS "_"; echo -n "$K8S_CLUSTER" | read -la ARRAY
        # if not contains $ARRAY[2] $GOOGLE_PROJECT; and [ $K8S_CLUSTER != "n/a" ]; 
        #         set_color red
        #         echo 'Google Project does NOT match kubernetes cluster !!!'
        # end

        # node/npm version
        if test -n "$NVM_CURRENT_VERSION"
            set_color brgreen
            echo -n '⎔ '
            set_color yellow
            echo 'nvm:' $NVM_CURRENT_VERSION
        end

        set_color brblue
        echo -n '⎔ '
        set_color yellow
        echo 'conf:' $GOOGLE_CONFIG_NAME 'project:' $GOOGLE_PROJECT
        if test -n "$GOOGLE_APPLICATION_CREDENTIALS"
            echo '  GOOGLE_APPLICATION_CREDENTIALS='$GOOGLE_APPLICATION_CREDENTIALS
        end
        set_color brblue
        echo -n '⎈ '
        set_color yellow
        if test "$K8S_CLUSTER" != "error: current-context is not set"
            echo -n $K8S_CLUSTER
            set_color -i bryellow
            echo -n " "$K8S_CLUSTER_VERSION
        end
        set_color normal
        echo
    end

    # User
    set_color $fish_color_user
    echo -n (whoami)
    set_color normal

    echo -n ' @ '

    # Host
    set_color $fish_color_host
    echo -n (prompt_hostname)
    set_color normal

    echo -n ': '

    # PWD
    set_color $fish_color_cwd
    echo -n  (prompt_pwd)
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '➤ '
    set_color normal
end
