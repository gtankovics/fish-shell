function mkcd -d "create a folder and enter it"
    if test -n "$argv[1]"
        mkdir $argv[1]
        cd $argv[1]
    else
        echo "Folder name is missing. Usage 'mkcd [FOLDER_NAME]'"
    end
end