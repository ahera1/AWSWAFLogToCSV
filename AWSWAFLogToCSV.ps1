# ------------------------------------------------------------------------
# AWS WAF Log To CSV PowerShell Script
# by ahera
#
# Generate a single CSV file by concatenating multiple xxxxxxxx.log 
# ------------------------------------------------------------------------
Param([string]$InputDir, [string]$OutputFile)
function Main($InputDir, $OutputFile)
{
    # Any header 
    #$header = "timestamp,webaclId"
    #Out-File -FilePath $OutputFile -InputObject $header -Encoding UTF8

    # Recursively retrieve files
    $logFiles = Get-ChildItem $InputDir -Filter *.log -Recurse

    # Process log files one at a time
    foreach($logFile in $logFiles)
    {
        $logData = Get-Content $logFile | ConvertFrom-Json
        Convert-JsonLog $logData
    }
}

function Convert-JsonLog ($jsonlog)
{
    $jsonlog | ForEach-Object {
        $timestamp = Get-Date -UnixTime ($_.timestamp/1000) 
        $webaclId = $_.webaclId
        $terminatingRuleId = $_.terminatingRuleId
        $terminatingRuleType = $_.terminatingRuleType
        $action = $_.action
        $clientIp = $_.httpRequest.clientIp
        $country = $_.httpRequest.country
        $uri = $_.httpRequest.uri
        $args2 = $_.httpRequest.args
        $httpMethod = $_.httpRequest.httpMethod
        $httpVersion = $_.httpRequest.httpVersion
    
        # $headers = $_.httpRequest.headers | ForEach-Object {
        #     "$($_.name):$($_.value)"
        # } | Select-Object -Unique
    
        #$headers_str = $headers -join "`r`n"

        # $ruleGroupList = $_.ruleGroupList.ruleGroupList | ForEach-Object {
        #     "$($_.terminatingRule.ruleId):$($_.terminatingRule.action)"
        # } | Select-Object -Unique
    
        #$ruleGroupList_str = $ruleGroupList -join "`r`n"

        $labels = $_.labels | ForEach-Object {
            "$($_.name)"
        } | Select-Object -Unique

        $row = [PSCustomObject] @{
            "timestamp" = $timestamp
            "webaclId" = $webaclId
            "terminatingRuleId" = $terminatingRuleId
            "terminatingRuleType" = $terminatingRuleType
            "action" = $action
            "clientIp" = $clientIp
            "country" = $country
            "uri" = $uri
            "args" = $args2
            "httpMethod" = $httpMethod
            "httpVersion" = $httpVersion
            "labels" = $labels
        }

#        "headers" = $headers_str
#        "ruleGroupList" = $ruleGroupList_str


        # Export to CSV
        $row | Export-Csv -Path $OutputFile -Append -NoTypeInformation -Force
    }
}

Main $InputDir $OutputFile
