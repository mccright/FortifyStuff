# FortifyStuff  

Simple resources for common work with the Fortify Static Code Security Analysis stack

* Scripts/analyze.ps1 - Powershell script to help document your endpoint sourceanalyzer work.  It helps me behave consistently over time.  I also use it to document translate and scan stage 'elapsed times' when attempting to squeeze more performance out of my endpoint environment.  
* Scripts/report.py - Python script for quick, rough outline of all FPR files in the current directory.  I use it sometimes to quickly compare the 'current' report with the 'last' report to confirm that the targeted vulnerabilities were removed.  
* Scripts/mergeAfterBuild.cmd - Check the integrity of the new FPR, then merge it with the last audited FPR file, & finally test it by opening it with Audit Workbench.  
