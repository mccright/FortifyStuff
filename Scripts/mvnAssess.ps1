param([String]$v='18.20')
# These are the most volatile parameters
$buildId = '"<enterTheBuildID>"'
$fprFileName = "<enterTheFPRFileName>.fpr"

# These are the less volatile parameters
# Executables/Commands:
$sca = "C:\PROGRA~1\Fortify\Fortify_SCA_and_Apps_"+$v+"\bin\sourceanalyzer.exe"
$mvn352 = "C:\Tools\apache-maven-3.5.2\bin\mvn.cmd"

# Passed Parameters used by the commands above, for various purposes:
$chkVersionParams = '--version'
$cleanParms = '-b', 'randTesting', '-clean'
$mvnCleanParms = 'clean'
$scaPlugin = "com.fortify.sca.plugins.maven:sca-maven-plugin:"+$v.trim()+":translate"
$translateParams = '-b', $buildId, '-jdk', '1.8', 'mvn', $scaPlugin, '"-DskipTests=true"', '"-Denforcer.skip=true"', '"-Dmaven.javadoc.skip=true"', '"-Dmaven.test.skip=true"' 
$scanParams =  '-b', $buildId, '-jdk', '1.8', '-scan', '-f', $fprFileName
$mvnInstallParams = 'compile', 'install', '"-DskipTests=true"', '"-Denforcer.skip=true"', '"-Dmaven.javadoc.skip=true"', '"-Dmaven.test.skip=true"'
$separator = "= = = = = = = = = = = = = = = = = = = = = = = = = = = ="
# Emit the sca and Java versions
$t = $host.ui.RawUI.ForegroundColor
$b = $host.ui.RawUI.BackgroundColor
$host.ui.RawUI.BackgroundColor = "White"
$host.ui.RawUI.ForegroundColor = "Blue"
& $sca $chkVersionParams
Write-Output ($separator)
Write-Output ($separator)
$host.ui.RawUI.ForegroundColor = $t
$host.ui.RawUI.BackgroundColor = $b

$start = Get-Date
$mvncleanStart = Get-Date
Write-Output ('Start mvn clean compile install stage at: ' + (Get-Date).ToString()) 
# mvn clean compile
Write-Host ("Command: " +  $mvn352 + " " + $mvnCleanParms) -foregroundcolor DarkBlue -backgroundcolor Yellow
& $mvn352 $mvnCleanParms

Write-Output ('Completed mvn clean at: ' + (Get-Date).ToString()) 
& $mvn352 $mvnInstallParams
Write-Output ('Completed mvn compile install at ' + (Get-Date).ToString()) 
$mvncleanEnd = Get-Date
$mvncleanDuration = $mvncleanEnd-$mvnstart
$t = $host.ui.RawUI.ForegroundColor
$b = $host.ui.RawUI.BackgroundColor
$host.ui.RawUI.BackgroundColor = "White"
$host.ui.RawUI.ForegroundColor = "Blue"
Write-Output ('Maven Clean/compile/install duration: ' + $mvncleanDuration.ToString() + " or " + $mvncleanDuration.TotalSeconds + ' seconds.') 
Write-Output ($separator)
Write-Output ($separator)
$host.ui.RawUI.ForegroundColor = $t
$host.ui.RawUI.BackgroundColor = $b

Write-Output ('Start sca clean at ' + (Get-Date).ToString()) 
$scacleanStart = Get-Date
# sca clean
Write-Hosst ("Command: " +  $sca + " " + $cleanParms) -foregroundcolor DarkBlue -backgroundcolor Yellow
& $sca $cleanParms

Write-Output ('Finished sca clean at ' + (Get-Date).ToString()) 
$scacleanEnd = Get-Date
$scacleanDuration = $scacleanEnd-$scacleanstart
$cleanEnd = Get-Date
$cleanDuration = $cleanEnd-$start
$t = $host.ui.RawUI.ForegroundColor
$b = $host.ui.RawUI.BackgroundColor
$host.ui.RawUI.BackgroundColor = "White"
$host.ui.RawUI.ForegroundColor = "Blue"
Write-Output ('sca clean duration: ' + $scacleanDuration.ToString() + " or " + $scacleanDuration.TotalSeconds + ' seconds.') 
Write-Output ('Total cleaning stages duration: ' + $cleanDuration.ToString() + " or " + $cleanDuration.TotalSeconds + ' seconds.') 
Write-Output ($separator)
Write-Output ($separator)
$host.ui.RawUI.ForegroundColor = $t
$host.ui.RawUI.BackgroundColor = $b

# Start translation
$transStart = Get-Date
Write-Output ('Starting translation at ' + $transStart.ToString()) 
# sca translate
Write-Host ("Command: " +  $sca + " " + $translateParams) -foregroundcolor DarkBlue -backgroundcolor Yellow
& $sca $translateParams

$transEnd = Get-Date
$transDuration = $transEnd-$transStart
$t = $host.ui.RawUI.ForegroundColor
$b = $host.ui.RawUI.BackgroundColor
$host.ui.RawUI.BackgroundColor = "White"
$host.ui.RawUI.ForegroundColor = "Blue"
Write-Output ($separator)
Write-Output ($separator)
Write-Output ('Finished translation at ' + $transEnd.ToString() + ' for a total time of ' + $transDuration + " or " + $transDuration.TotalSeconds + ' seconds.') 
Write-Output ($separator)
Write-Output ($separator)
$host.ui.RawUI.ForegroundColor = $t
$host.ui.RawUI.BackgroundColor = $b

$scanStart = Get-Date
Write-Output ('Starting scan at ' + $scanStart.ToString()) 

# sca scan
Write-Host ("Command: " +  $sca + " " + $scanParams) -foregroundcolor DarkBlue -backgroundcolor Yellow
& $sca $scanParams

Write-Output ('Finished scan at ' + (Get-Date).ToString()) 

$scanEnd = Get-Date

$end = Get-Date
# calc scan time and total run time of the entire process.  
$scanDuration = $scanEnd-$scanStart
Write-Output ('Scan duration: ' + $scanDuration + " or " + $scanDuration.TotalSeconds + " seconds")
$totalDuration = $scanEnd-$start

$t = $host.ui.RawUI.ForegroundColor
$b = $host.ui.RawUI.BackgroundColor
$host.ui.RawUI.BackgroundColor = "White"
$host.ui.RawUI.ForegroundColor = "Blue"
Write-Output ($separator)
Write-Output ($separator)
Write-Output ('Total clean duration: ' + $cleanDuration.ToString() + " or " + $cleanDuration.TotalSeconds + ' seconds.')
Write-Output ('Maven Clean/compile/install duration: ' + $mvncleanDuration.ToString() + " or " + $mvncleanDuration.TotalSeconds + ' seconds.') 
Write-Output ('Fortify clean duration: ' + $scacleanDuration.ToString() + " or " + $scacleanDuration.TotalSeconds + ' seconds.') 
Write-Output ("Command: " +  $sca + " " + $cleanParms)
Write-Output ('Fortify translation duration: ' +$transDuration + " or " + $transDuration.TotalSeconds + " seconds")
Write-Output ("Command: " +  $sca + " " + $translateParams)
Write-Output ('Fortify scan duration: ' + $scanDuration + " or " + $scanDuration.TotalSeconds + " seconds")
Write-Output ("Command: " +  $sca + " " + $scanParams)
Write-Output ('Total duration.....' + $totalDuration + " or " + $totalDuration.TotalSeconds)
$host.ui.RawUI.ForegroundColor = $t
$host.ui.RawUI.BackgroundColor = $b
