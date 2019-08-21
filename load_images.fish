function load_images --description 'Load docker images from folder'
    set -l PRODUCT_VERSION (cat ../ProductVersion.xml | sed -ne '/prefspostfix/p' | sed 's/\\(.*\\>\\)\\(.*\\)\\(\\<.*\\)/\\2/g; s/ /\\_/g')
    echo $PRODUCT_VERSION
    # Load twportal image
    echo "Loading twportal..."
    docker load -i pspackage.tar

    # Load twmodel image
    echo "Loading twmodel..."
    docker load -i mspackage.tar

    if test -n "$argv" && test "$argv" = "--push" 

        echo "tag and push $argv"
        # # Tag twportal image and push
        docker tag twportal:$PRODUCT_VERSION gcr.io/bc-saas-images/twportal:$PRODUCT_VERSION 
        docker push gcr.io/bc-saas-images/twportal:$PRODUCT_VERSION 

        # # Tag twmodel image and push
        docker tag twmodel:$PRODUCT_VERSION gcr.io/bc-saas-images/twmodel:$PRODUCT_VERSION
        docker push gcr.io/bc-saas-images/twmodel:$PRODUCT_VERSION 
    else
        echo "Invalid argument(s): $argv"
    end

end