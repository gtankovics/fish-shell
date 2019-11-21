function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # detailed prompt

    if test -n "$fish_prompt_detailed" && test "$TERM_PROGRAM" != "vscode" && test -n "SSH_TTY"

        if not test -n "$fish_prompt_detailed_last_check"
            set -U fish_prompt_detailed_last_check (date +%s)
        end

        # reload environment in every X minutes (fish_prompt_detailed_reload_interval, default=600 sec=10 min) or in case of `chenv`
        
        set -q fish_prompt_detailed_reload_interval || set -xU fish_prompt_detailed_reload_interval 600

        # update prompt values
        if test (date +%s) -gt (math "$fish_prompt_detailed_last_check + $fish_prompt_detailed_reload_interval") || test $fish_prompt_detailed_reset -eq 1
            set -U fish_prompt_detailed_last_check (date +%s)
            set_color -b magenta -i
            echo -n " Reload NVM_CURRENT_VERSION, GOOGLE_CONFIG, GOOGLE_PROJECT, K8S_CLUSTER, K8S_CLUSTER_VERSION "
            set_color normal
            echo
            set -xU GOOGLE_CONFIG (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
            set -xU GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
            set -xU K8S_CLUSTER (kubectl config current-context 2>&1)
            # if test $fish_detailed_prompt_reset -eq 0
            #     chenv reset
            # end
            if test $K8S_CLUSTER != "error: current-context is not set"
                set -xU K8S_CLUSTER_VERSION (kubectl version --short | awk '/Server/{print$3}')
            else
                set -xU K8S_CLUSTER_VERSION "n/a"
                set -xU K8S_CLUSTER_SHORT ''
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
            set -U fish_prompt_detailed_reset 0
            if test "$TERM_PROGRAM" = "iTerm.app"
                iterm2_update_user_vars
            end
        end

        # node/npm version
        if test -n "$NVM_CURRENT_VERSION"
            set_color brgreen
            echo -n '⎔ '
            set_color yellow
            echo 'nvm:' $NVM_CURRENT_VERSION
        end

        if test "$TERM_PROGRAM" = "iTerm.app"
            iterm2_prompt_mark
        end

        # set Google Cloud environment
        set_color brblue
        echo -n '⎔ '
        set_color yellow
        echo 'conf:' $GOOGLE_CONFIG 'project:' $GOOGLE_PROJECT 'region:' $GOOGLE_REGION 'zone:' $GOOGLE_ZONE
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

    # place iTerm prompt marker
    if test $TERM_PROGRAM = "iTerm.app"
        iterm2_prompt_mark
        # update iTerm user variables
        iterm2_update_user_vars
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
