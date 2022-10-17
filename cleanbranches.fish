function cleanbranches -d "Removes local branches which does not have remote"
    git fetch --all --tags --prune
    for branch in (git branch -vv | awk '/gone/{print$1}')
        if test "$branch" != "*"
            git branch -D $branch
        end
    end
    echo Done.
end