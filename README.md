# FortifyStuff  
[![](https://tokei.rs/b1/github.com/mccright/FortifyStuff/?category=code)](https://github.com/mccright/FortifyStuff)  

Simple resources for common work with the Fortify Static Code Security Analysis stack  

* Scripts/analyze.ps1 - Powershell script to help document your endpoint sourceanalyzer work.  It helps me behave consistently over time.  I also use it to document translate and scan stage 'elapsed times' when attempting to squeeze more performance out of my endpoint environment.  
* Scripts/report.py - Python script for quick, rough outline of all FPR files in the current directory.  I use it sometimes to quickly compare the 'current' report with the 'last' report to confirm that the targeted vulnerabilities were removed.  
* Scripts/mergeAfterBuild.cmd - Check the integrity of the new FPR, then merge it with the last audited FPR file, & finally test it by opening it with Audit Workbench.  
* Scripts/reportOnFPRs.py - A simple way to get a simple, light report started for those who cannot use an FPR file nor log into your SSC.  
* Scripts/scanjs.sh - A simple script to simplify command line scans of static JavaScript apps on Linux.  This model should be useful via copy-morph in a range of different use cases.
* Scripts/getGHtree.py - A model for extracting a list of files in tree format.  I sometimes need to know what types of files are in a github repo along with their layout in order to prepare for a risk-reasonable static analysis.  This approach is often useful.  
