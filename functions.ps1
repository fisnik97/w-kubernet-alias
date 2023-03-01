
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

        if ($context -eq 'prod-env-context') {
            Write-Host "You are switching to a PRODUCTION environment. Please be careful." -ForegroundColor Magenta
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
        [string]$since,
        [switch]$follow
    )
    
    $args = @($podName, '--timestamps')

    if ($since) {
        $args += "--since=$since"
    }

    if ($follow) {
        $args += '-f'
    }
    
    & kubectl logs $args
}

function fwd {
    param(
        [string]$podName,
        [string]$hostPort = "80",
        [string]$podPort = "80"
    )

    Write-Warning "Forwarding $podName -> $hostPort : $podPort ..."

    kubectl port-forward $podName "${hostPort}:${podPort}"
}
