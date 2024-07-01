$OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')
Set-Item env:LANG-Value ja_JP.UTF-8

set-alias vi 'E:\apps\vim\vim.exe'
set-alias vim 'E:\apps\vim\vim.exe'
set-alias touch New-Item
set-alias ll Get-ChildItem -Force
set-alias df Get-DirectoryVolume 
set-alias du Get_FileSize
set-alias py Python
set-alias robokssay RobokssayWord


function prompt() {
    # show only current path in terminal
    (Split-Path (Get-Location) -Leaf) + " > "
}

function Get_FileSize(){
    param($Path)
    $size = 0
    Get-ChildItem $Path -Recurse | ForEach-Object {
        $size += $_.Length
    }
    Write-Host "Total size of files in $Path $($size/1MB) MB"
}

# https://github.com/guitarrapc/PowerShellUtil/blob/master/Get-DirecotryVolume/Get-DirectoryVolume.ps1
function Get-DirectoryVolume 
{

    [CmdletBinding()]
    param
    (
        [parameter(
            position = 0,
            mandatory = 1,
            valuefrompipeline = 1,
            valuefrompipelinebypropertyname = 1)]
        [string[]]
        $Path = $null,

        [parameter(
            position = 1,
            mandatory = 0,
            valuefrompipelinebypropertyname = 1)]
        [validateSet("KB", "MB", "GB")]
        [string]
        $Scale = "KB",

        [parameter(
            position = 2,
            mandatory = 0,
            valuefrompipelinebypropertyname = 1)]
        [switch]
        $Recurse = $false,

        [parameter(
            position = 3,
            mandatory = 0,
            valuefrompipelinebypropertyname = 1)]
        [switch]
        $Ascending = $false,

        [parameter(
            position = 4,
            mandatory = 0,
            valuefrompipelinebypropertyname = 1)]
        [switch]
        $OmitZero
    )

    process
    {
        $path `
        | %{
            Write-Verbose ("Checking path : {0}. Scale : {1}. Recurse switch : {2}. Decending : {3}" -f $_, $Scale, $Recurse, !$Ascending)
            if (Test-Path $_)
            {
                $result = Get-ChildItem -Path $_ -Recurse:$Recurse `
                | where PSIsContainer `
                | %{
                    $subFolderItems = (Get-ChildItem $_.FullName | where Length | measure Length -sum)
                    [PSCustomObject]@{
                        Fullname = $_.FullName
                        $scale = [decimal]("{0:N4}" -f ($subFolderItems.sum / "1{0}" -f $scale))
                    }} `
                | sort $scale -Descending:(!$Ascending)

                if ($OmitZero)
                {
                    return $result | where $Scale -ne ([decimal]("{0:N4}" -f "0.0000"))
                }
                else
                {
                    return $result
                }
            }
        }
    }
}

# Function to print colored text
function Write-ColoredText {
    param(
        [string]$text,
        [string]$color
    )

    Write-Host -NoNewline -ForegroundColor $color $text
}

# Function to print the bubble
function Say-Bubble {
    param(
        [string]$str
    )

    $len = $str.Length

    # Define colors
    $colors = @{
        "c" = "Cyan";
        "y" = "Yellow";
        "w" = "White";
        "r" = "Red";
        "g" = "Green";
        "b" = "Blue";
        "d" = "Default";
        "m" = "Magenta" 
    }

    Write-Host ("  " + "-" * ($len + 2))
    Write-ColoredText "＜ $str ＞`n" $colors["w"]
    Write-Host ("  " + "-" * ($len + 2))
}

# Main function
function RobokssayWord {
    param(
        [string]$str = "踏めば助かるのに..."
    )

    Say-Bubble $str

    # Define colors
    $colors = @{
        "c" = "Cyan";
        "y" = "Yellow";
        "w" = "White";
        "r" = "Red";
        "g" = "Green";
        "b" = "Blue";
        "d" = "Default";
        "m" = "Magenta" 
    }

    $roboks = @"
   w＼
     w＼              y>/一<ヽ
       w＼            y/ヽ_ノヽ 
         w＼             yﾊ 
           w＼        c————————— 
             w＼.  c／           ＼
                ／   w●        ●  c＼ 
               /      w❘ニニニ❘    cヽ 
              / |——————————————————|＼ 
            / / |     g○  y○  m○      c|＼＼ 
          r(一)  c|                  | r(一) 
                c|      y／一＼      c|
                |      y| ?  |      c|
                |      y＼一／      c|
                |_  ___________ ___|
                   Π           Π   
              r(ニニ|           |ニニ)w)
"@

$color = $colors["w"]
    $roboks.ToCharArray() | ForEach-Object {
        $char = $_
        switch -Wildcard ($char) {
            "c" { $color = $colors["c"] }
            "y" { $color = $colors["y"] }
            "w" { $color = $colors["w"] }
            "r" { $color = $colors["r"] }
            "g" { $color = $colors["g"] }
            "b" { $color = $colors["b"] }
            "m" { $color = $colors["m"] }
            default {$color = $color}
        }
        if ($_ -eq "c" -or $_ -eq "y" -or $_ -eq "w" -or $_ -eq "r" -or $_ -eq "g" -or $_ -eq "b" -or $_ -eq "m"){
            $char = ""
        }
        Write-ColoredText $char $color
    }
}
