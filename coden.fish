function coden --description 'Open new instance of VS Code from commandline.'
    if git rev-parse --show-toplevel > /dev/null 2>&1
        echo This is a git repo!
        code -n (git rev-parse --show-toplevel)
    else
        echo This is a simple folder.
        code -n .
    end
end