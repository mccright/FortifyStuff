@ECHO OFF
@GOTO START
	First, ensure that the new FPR file is OK because
	we don't want to merge with a corrupted FPR file.
	Second, merge the new FPR file with the last audited FPR file.
	Then output the merge-product to a new FPR file.
	Finally, test by opening the new FPR with Audit Workbench.
	Requires Fortify SCA installed.  Uses FPRUtility.bat/FPRUtility
@REM
:START
@REM Project-Specific variables
IF .%1.==.. GOTO USAGE
IF .%2.==.. GOTO USAGE
IF .%3.==.. GOTO USAGE
IF .%4.==.. GOTO USAGE
SET newestFPRFILE=%1
SET myAuditedFPRFILE=%2
SET myNewlyAuditedFPRFILE=%3
SET fortifySCAVersion=%4
@REM The %fortifySCAVersion% will be something like 17.20. 18.10, 18.20, 19.10, etc.
SET sectionSeparator="---------------------------------------------------------"
@REM 
SET FPRUtil="C:\Progra~1\Fortify\Fortify_SCA_and_Apps_%fortifySCAVersion%\bin\FPRUtility.bat"
SET AUDITWORKBENCHCMD="C:\Progra~1\Fortify\Fortify_SCA_and_Apps_%fortifySCAVersion%\bin\auditworkbench.cmd"
SET CHECKSIGNATURE= -information -signature -project 
SET MERGEIT= -merge -project %newestFPRFILE% -source %myAuditedFPRFILE% -f %myNewlyAuditedFPRFILE% 
@REM
ECHO =========== %~f0 ===========
@REM First, ensure that the new FPR file is OK.
@REM Because we don't want to merge with a corrupted FPR file.
@ECHO %FPRUtil% %CHECKSIGNATURE% %newestFPRFILE%
CALL %FPRUtil% %CHECKSIGNATURE% %newestFPRFILE% 1>NULL
if %ERRORLEVEL%==6 goto :SIX
if %ERRORLEVEL%==5 goto :FPRFILEMISSINGORCORRUPT
if %ERRORLEVEL%==4 goto :FOUR
if %ERRORLEVEL%==3 goto :FPRNOTSIGNED
if %ERRORLEVEL%==2 goto :SIGNEDNOSIGSVALID
if %ERRORLEVEL%==1 goto :SIGNEDSOMESIGSVALID
if %ERRORLEVEL%==0 goto :SUCCESS
@REM If debugging doesn't matter, we could have used:
@REM       IF %ERRORLEVEL% NEQ 0 GOTO ERROR
@REM These exit codes are valid for the -signature action
@REM    0: FPR is fully signed and all signatures are valid
@REM    1: FPR is signed and some signatures are valid
@REM    2: FPR is signed and no signatures are valid
@REM    3: FPR is not signed
:SUCCESS
@ECHO Success!
@ECHO FPR %newestFPRFILE% is fully signed and all signatures are valid
GOTO MERGE
:SIGNEDSOMESIGSVALID
@ECHO FPR %newestFPRFILE% is signed and some signatures are valid.
GOTO END
:SIGNEDNOSIGSVALID
@ECHO FPR %newestFPRFILE% is signed and no signatures are valid.
GOTO END
:FPRNOTSIGNED
@ECHO PROBLEM!
@ECHO FPR %newestFPRFILE% is not signed.
GOTO END
:FOUR
@ECHO FOUR!
@ECHO FPR %newestFPRFILE% is not signed.
GOTO END
:FPRFILEMISSINGORCORRUPT
@ECHO FPR %newestFPRFILE% Missing or Corrupted Problem!
@ECHO FPR %newestFPRFILE% is missing or the name is wrong, or it is present by corrupted.
GOTO END
:SIX
@ECHO SIX!
@ECHO FPR %newestFPRFILE% is not signed.
GOTO END
:MERGE
@REM
ECHO %sectionSeparator%
@REM
@REM Second, since we got this far, 
@REM merge the new FPR file with the last audited FPR file.
@REM Then output the merge product to a new FPR file.
@ECHO %FPRUtil% %MERGEIT%
CALL %FPRUtil% %MERGEIT% 1>NULL
if %ERRORLEVEL%==6 goto :SIX
if %ERRORLEVEL%==5 goto :FPRMERGEWASUNSUCCESSFUL
if %ERRORLEVEL%==4 goto :FOUR
if %ERRORLEVEL%==3 goto :THREE
if %ERRORLEVEL%==2 goto :TWO
if %ERRORLEVEL%==1 goto :ONE
if %ERRORLEVEL%==0 goto :MERGESUCCESS
@REM
:MERGESUCCESS
@ECHO Merge Was Successful!
@ECHO New %newestFPRFILE% and Audited %myAuditedFPRFILE% were successfully merged.
@ECHO Merge output file: %myNewlyAuditedFPRFILE%
GOTO MERGESUCCEEDED
:ONE
@ECHO ONE!
@ECHO Problem merging %newestFPRFILE% and Audited %myAuditedFPRFILE%.
GOTO END
:TWO
@ECHO TWO!
@ECHO Problem merging %newestFPRFILE% and Audited %myAuditedFPRFILE%.
GOTO END
:THREE
@ECHO THREE!
@ECHO Problem merging %newestFPRFILE% and Audited %myAuditedFPRFILE%.
GOTO END
:FOUR
@ECHO FOUR!
@ECHO Problem merging %newestFPRFILE% and Audited %myAuditedFPRFILE%.
GOTO END
:FPRMERGEWASUNSUCCESSFUL
@ECHO FPR Merge was unsuccessful
GOTO END
:SIX
@ECHO SIX!
@ECHO Problem merging %newestFPRFILE% and Audited %myAuditedFPRFILE%.
GOTO END
@REM
:MERGESUCCEEDED
ECHO %sectionSeparator%
@REM Test by opening the Fortify report with Audit Workbench
%AUDITWORKBENCHCMD% %myNewlyAuditedFPRFILE%
@REM
GOTO END
:USAGE
@ECHO.
@ECHO.
@ECHO.
@ECHO.
@ECHO.
@ECHO.
@ECHO   %0      requires that you pass some FPR file names and the Fortify SCA version.
@ECHO.
@ECHO   USAGE:  %0 myNewestProjNotYetReviewed.fpr myAuditedProject.fpr myNewlyMergedOutputProj.fpr fortifySCAVersion
@ECHO.
@ECHO.
@ECHO.
@ECHO.
:END
