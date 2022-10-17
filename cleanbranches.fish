function cleanbranches -d "Removes local branches which does not have remote"
    for branch in (git branch -vv | awk '/gone/{print$1}')
        git branch -D $branch
    end
end