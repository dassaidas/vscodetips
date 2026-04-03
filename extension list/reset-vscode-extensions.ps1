# =========================================================
# VS Code Full Reset + Curated Reinstall
# =========================================================

$backupFile = "vscode-extensions-backup.txt"

$extensions = @(
    # Existing / requested
    "afractal.node-essentials",
    "be5invis.vscode-icontheme-nomo-dark",
    "christian-kohler.npm-intellisense",
    "christian-kohler.path-intellisense",
    "dbaeumer.vscode-eslint",
    "dsznajder.es7-react-js-snippets",
    "ducphamngoc.codevisualizer",
    "eamodio.gitlens",
    "ecmel.vscode-html-css",
    "editorconfig.editorconfig",
    "esbenp.prettier-vscode",
    "formulahendry.auto-rename-tag",
    "github.copilot-chat",
    "github.vscode-pull-request-github",
    "mikestead.dotenv",
    "ms-azure-load-testing.microsoft-testing",
    "ms-azuretools.azure-dev",
    "ms-azuretools.vscode-azure-github-copilot",
    "ms-azuretools.vscode-azure-mcp-server",
    "ms-azuretools.vscode-azureappservice",
    "ms-azuretools.vscode-azurecontainerapps",
    "ms-azuretools.vscode-azurefunctions",
    "ms-azuretools.vscode-azureresourcegroups",
    "ms-azuretools.vscode-azurestaticwebapps",
    "ms-azuretools.vscode-azurestorage",
    "ms-azuretools.vscode-azurevirtualmachines",
    "ms-azuretools.vscode-containers",
    "ms-azuretools.vscode-cosmosdb",
    "ms-dotnettools.csdevkit",
    "ms-dotnettools.csharp",
    "ms-dotnettools.vscode-dotnet-runtime",
    "ms-kubernetes-tools.vscode-kubernetes-tools",
    "ms-mssql.data-workspace-vscode",
    "ms-mssql.mssql",
    "ms-mssql.sql-bindings-vscode",
    "ms-mssql.sql-database-projects-vscode",
    "ms-vscode-remote.remote-containers",
    "ms-vscode.vscode-node-azure-pack",
    "ms-vsliveshare.vsliveshare",
    "ms-windows-ai-studio.windows-ai-studio",
    "msjsdiag.debugger-for-chrome",
    "orta.vscode-jest",
    "pkief.material-icon-theme",
    "rangav.vscode-thunder-client",
    "redhat.fabric8-analytics",
    "redhat.vscode-yaml",
    "ritwickdey.liveserver",
    "rvest.vs-code-prettier-eslint",
    "steoates.autoimport",
    "teamsdevapp.vscode-ai-foundry",
    "vscode-icons-team.vscode-icons",
    "wallabyjs.quokka-vscode",
    "wix.vscode-import-cost",
    "wscats.cors-browser",

    # Added for your stack
    "angular.ng-template",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-python.debugpy",
    "ms-toolsai.jupyter",
    "ms-azuretools.vscode-docker",
    "hashicorp.terraform",
    "ms-vscode.powershell",
    "NicolasVuillamy.vscode-groovy-lint",
    "humao.rest-client",
    "mongodb.mongodb-vscode",
    "Oracle.oracledevtools",
    "usernamehw.errorlens",
    "streetsidesoftware.code-spell-checker"
)

Write-Host "Checking VS Code CLI..." -ForegroundColor Cyan
try {
    $null = code --version
}
catch {
    Write-Host "VS Code command line 'code' is not available." -ForegroundColor Red
    Write-Host "Open VS Code, press Ctrl+Shift+P, and run: Shell Command: Install 'code' command in PATH" -ForegroundColor Yellow
    exit 1
}

$extensions = $extensions | Sort-Object -Unique

Write-Host ""
Write-Host "Backing up current extensions to $backupFile ..." -ForegroundColor Green
code --list-extensions --show-versions | Out-File -FilePath $backupFile -Encoding utf8

$installedExtensions = code --list-extensions

Write-Host ""
Write-Host "Uninstalling all currently installed extensions..." -ForegroundColor Yellow
foreach ($ext in $installedExtensions) {
    if (![string]::IsNullOrWhiteSpace($ext)) {
        Write-Host "Uninstalling $ext" -ForegroundColor Red
        code --uninstall-extension $ext
    }
}

Write-Host ""
Write-Host "Installing curated extension set..." -ForegroundColor Green
foreach ($ext in $extensions) {
    Write-Host "Installing $ext" -ForegroundColor Cyan
    code --install-extension $ext --force
}

Write-Host ""
Write-Host "Final installed extensions:" -ForegroundColor Green
code --list-extensions

Write-Host ""
Write-Host "Completed." -ForegroundColor Green
Write-Host "Backup saved at: $backupFile" -ForegroundColor Green