# AWSWAFLogToCSV

## Description
* Convert from AWS WAF Log to CSV.

## Require
* PowerShell 7.3.3 or above
* Supported `UnixTime` parameter in `Get-Date`.

## Usage
```shell
.\AWSWAFLogToCSV.ps1 {Input AWS WAF log directory} {Output CSV Filename}
```

For example:
```shell
.\AWSWAFLogToCSV.ps1 C:\work\awswaflog C:\work\awswaflog.csv 
```

## Sample

### Input: AWS WAF Logs

```json
{"timestamp":1678254945919,"formatVersion":1,"webaclId":"arn:aws:wafv2:us-east-1:000000000000:global/webacl/hogehoge/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx","terminatingRuleId":"AWS-AWSManagedRulesWindowsRuleSet","terminatingRuleType":"MANAGED_RULE_GROUP","action":"BLOCK","terminatingRuleMatchDetails":[],"httpSourceName":"CF","httpSourceId":"xxxxxxxxxxxx","ruleGroupList":[{"ruleGroupId":"AWS#AWSManagedRulesCommonRuleSet","terminatingRule":null,"nonTerminatingMatchingRules":[],"excludedRules":null,"customerConfig":null},{"ruleGroupId":"AWS#AWSManagedRulesSQLiRuleSet","terminatingRule":null,"nonTerminatingMatchingRules":[],"excludedRules":null,"customerConfig":null},{"ruleGroupId":"AWS#AWSManagedRulesWindowsRuleSet","terminatingRule":{"ruleId":"WindowsShellCommands_BODY","action":"BLOCK","ruleMatchDetails":null},"nonTerminatingMatchingRules":[],"excludedRules":null,"customerConfig":null}],"rateBasedRuleList":[],"nonTerminatingMatchingRules":[],"requestHeadersInserted":null,"responseCodeSent":null,"httpRequest":{"clientIp":"xxx.xxx.xxx.xxx","country":"US","headers":[{"name":"Host","value":"example.com"},{"name":"Connection","value":"keep-alive"}],"uri":"/example/path","args":"?args","httpVersion":"HTTP/1.1","httpMethod":"POST","requestId":"example"},"labels":[{"name":"awswaf:managed:aws:windows-os:WindowsShellCommands_Body"}]}
```

### Output: CSV

```csv
"timestamp","webaclId","terminatingRuleId","terminatingRuleType","action","clientIp","country","uri","args","httpMethod","httpVersion","labels"
"2023/03/08 14:55:46","arn:aws:wafv2:us-east-1:000000000000:global/webacl/hogehoge/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx","AWS-AWSManagedRulesWindowsRuleSet","MANAGED_RULE_GROUP","BLOCK","xxx.xxx.xxx.xxx","US","/example/path","?args","POST","HTTP/1.1","awswaf:managed:aws:windows-os:WindowsShellCommands_Body"
```
