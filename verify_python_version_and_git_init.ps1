# Obtient le chemin actuel
$modified_path = (Get-Location).Path

function git_init_in_repo {
        $gitDirectories = Get-ChildItem -Path $rootDirectory -Directory -Recurse -Filter ".git" -Force | Where-Object {$_.PSIsContainer}
        foreach ($repo in $gitDirectories) {
            # Actuellement $repo se situe à l'intérieur du .git. 
            # Grace au ().Parent, nous pouvons remonter au dossier du dessus et stocker le chemin dans la variable $repo_directory
            $repo_directory = ($repo).Parent

            # On se déplace derrière le .git et nouds faisons un git iddnit. dCefla permet la ré-initialisation du .git. 
            Set-Location $repo_directory
            git init
        }
}

function GetPowershell_Version {
    param([string[]]$powershell_param_for_function)
    # Obtient la version de Powershell
    $powershell_version = $powershell_param_for_function
    if ($powershell_version -le 4) {
        Write-Host "$powershell_version is your powershell version. Upgrade to 5 or greater: "
    }
}

GetPowershell_Version($($PSVersionTable.PSVersion.Major))
function GetPython_version {
    param (
        [string]$pythonVersion
    )
    $justNumber3 = $pythonVersion.Substring($pythonVersion.Length - 6, 1)

    if ($justNumber3 -ne '3') {
        Write-Host "Please upgrade your Python to version 3. Your version $pythonVersion"
    } else{
        Set-Location ~
        $templatesDirectory = '.git-templates\hooks'
        mkdir -Force $templatesDirectory

        $currentDirectory = Get-Location
        Copy-Item "$modified_path\commit-msg" -Destination "$templatesDirectory\commit-msg"
        git config --global init.templatedir "$currentDirectory\.git-templates\"

        # Afficher les informations de saisie pour le bon fonctionnement du programme.
        Write-Host "Veuillez renseigner un chemin pour que le script re-initialise la configuration des .git de chacun de vos repo clones\n(Il se lance dans le dossier parent duquel il se trouve)"
        Write-Host "Par defaut, le script se lance a partir du repertoire ou il se trouve, avec un n-1"
        Write-Host "Exemple de chemin attendu par Windows : C:\Users\ValentinBRISON\PROJETS\exemple_projet"
        $rootDirectory = Read-Host "Saisir 'no' pour la valeur par defaut "
        Set-Location $modified_path
        if ($rootDirectory -eq "no") {
            $rootDirectory = (Get-Item $modified_path).Parent.FullName
            git_init_in_repo
        } else {
            $rootDirectory = (Get-Item $rootDirectory).FullName
            git_init_in_repo
        }   
    }
}

# Exemple d'utilisation de la fonction
GetPython_version (python3 --version)
