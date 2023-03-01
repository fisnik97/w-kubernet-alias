
function cx {
    param(
        [string]$context = $null
    )

    if ($context) {
        switch ($context) {
            'dev' { $context = 'dev-env-context' }
            'prod' { $context = 'prod-env-context' }
            Default { throw "Invalid context value: $context" }
        }
        kubectl config use-context $context
    }
    else {
        kubectl config current-context
    }
}


function pods {
    param(
        [string]$filter = $null
    ) 

    if ($filter) {
        kubectl get pods | findstr $filter
    } 
    else {
        kubectl get pods
    }  
}


function logs {
    param(
        [string]$podName,
        [switch]$follow
    )
    
    $args = @($podName, '--timestamps')
    if ($follow) {
        $args += '-f'
    }
    
    & kubectl logs $args
}

