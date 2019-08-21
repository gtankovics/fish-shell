function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # detailed prompt

    if test -n "$fish_prompt_detailed"

        if not test -n "$fish_prompt_detailed_last_check"
            set -U fish_prompt_detailed_last_check (date +%s)
        end

        # reload environment in every X minutes (fish_prompt_detailed_reload_interval, default=600 sec=10 min) or in case of `chenv`
        
        set -q fish_prompt_detailed_reload_interval; or set -xU fish_prompt_detailed_reload_interval 600

        if test (date +%s) -gt (math "$fish_prompt_detailed_last_check + $fish_prompt_detailed_reload_interval") || test $fish_detailed_prompt_reset -eq 1
            # set -U prompt_counter 0
            set -U fish_prompt_detailed_last_check (date +%s)
            set_color -b magenta -i
            echo -n " Reload NVM_CURRENT_VERSION, GOOGLE_CONFIG_NAME, GOOGLE_PROJECT, K8S_CLUSTER, K8S_CLUSTER_VERSION "
            set_color normal
            echo
            set -xU GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
            set -xU GOOGLE_CONFIG_NAME (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
            set -xU K8S_CLUSTER (kubectl config current-context 2>&1)
            if test $fish_detailed_prompt_reset -eq 0
                chenv reset
            end
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
            set -U fish_detailed_prompt_reset 0
        end

        # check Google Config Name
        if not test -n "$GOOGLE_CONFIG_NAME"
            set -xU GOOGLE_CONFIG_NAME (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
        end

        # check GOOGLE PROJECT
        if not test -n "$GOOGLE_PROJECT"
            set -xU GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
        end

        if not test -n "$GOOGLE_REGION"
            set -xU GOOGLE_REGION (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.region)')
        end
        
        if not test -n "$GOOGLE_ZONE"
            set -xU GOOGLE_ZONE (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.zone)')
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
        echo 'conf:' $GOOGLE_CONFIG_NAME 'project:' $GOOGLE_PROJECT 'region:' $GOOGLE_REGION 'zone:' $GOOGLE_ZONE
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
