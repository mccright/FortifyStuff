class Unbuffered(object):
   def __init__(self, stream):
       self.stream = stream
   def write(self, data):
       self.stream.write(data)
       self.stream.flush()
   def writelines(self, datas):
       self.stream.writelines(datas)
       self.stream.flush()
   def __getattr__(self, attr):
       return getattr(self.stream, attr)

import sys
import os
import shutil
import fnmatch
from subprocess import call
import subprocess
import os
import time

"""
This is a simple way to get a simple, light
report started for those who cannot use
an FPR file nor log into your SSC...
NOTE: There have been reports of incomplete results 
being emitted by Fortify's ReportGenerator.bat. See 
an example in the issue: https://github.com/DefectDojo/django-DefectDojo/issues/1657 
(go down to "dougmcdorman commented on Nov 26, 2019" 
"""
sys.stdout = Unbuffered(sys.stdout)

"""
You need to edit the two lines below as your versions get upgraded...
"""
fortifyVersion="20.1.0"
jreVersion="1.8.0_212"
# I used to hard code the path...
# fprUtil="C:\\PROGRA~1\\Fortify\\Fortify_SCA_and_Apps_"+fortifyVersion+"\\bin\\FPRUtility.bat"
# Then searched for it, but didn't check for exceptions or 'None'...
# fprUtil = shutil.which("FPRUtility.bat")
target_file = 'FPRUtility.bat'
try:
    fprUtil = shutil.which(target_file)
except shutil.Error as err:
    print(f'{err}')
if fprUtil is None:
    print(f'Did not find {target_file} in the path. Returned: {fprUtil}')
else:
    files = [f for f in os.listdir('.') if os.path.isfile(f)]
    for filename in files:
        if fnmatch.fnmatch(filename, '*.fpr'):
            now = time.strftime("%c")
            print ("")
            print ("------------------------------------------------------------")
            print ("Fortify Report filename: " + filename)
            print ("Report start: %s"  % now )
            print ("------------------------------------------------------------")
            print ("\r\n")
            print ("Scan Date: ")
            print ("Scanned:  files,  LOC (Executable)")
            print ("Gross Issues:  (0 critical, 0 high, 0 medium, 0 low)")
            print ("Files: ")
            print ("Executable LoC: ")
            print ("Total LoC: ")
            print ("Certified: Results Certification Valid")
            print ("Warnings: ")
            print ("SCA Engine Version: HPE Security Fortify Static Code Analyzer " + fortifyVersion + " (using JRE " + jreVersion + ")")
            print ("\r\n")
            print ("The following are Fortify Issue Severity Counts:")
            print ("-----------------------------------------------")
            print ("CRITICAL: _")
            print ("HIGH: _")
            print ("MEDIUM: _")
            print ("LOW: _")
            print ("FALSE POSITIVE: _")
            print ("Total for all severities: _ Issues")
            print ("\r\n")
            print ("The following are Fortify analyzer Issue Counts by Criticality:")
            print ("--------------------------------------------------------------")
            print ("CRITICAL")
            print ("--------")
            print ("\r\n")
            print ("HIGH")
            print ("--------")
            print ("\r\n")
            print ("MEDIUM")
            print ("--------")
            print ("\r\n")
            print ("LOW")
            print ("--------")
            print ("\r\n")
            print ("FALSE POSITIVE")
            print ("--------------")
            print ("\r\n")
            print ("------------------------------------------------------------")
            print ("Fortify SCA Category Issue Counts for: " + filename)
            print ("------------------------------------------------------------")
            os.system(fprUtil + " -information -categoryIssueCounts -project " + filename)
            print ("")
            print ("------------------------------------------------------------")
            print ("Fortify SCA Analyzer Issue Counts for: " + filename)
            print ("------------------------------------------------------------")
            os.system(fprUtil + " -information -analyzerIssueCounts -project " + filename)
            print ("")
            print ("------------------------------------------------------------")
            print ("Fortify SCA Errors for: " + filename)
            print ("------------------------------------------------------------")
            os.system(fprUtil + " -information -errors -project " + filename)
            print ("")
            print ("")
            print ("------------------------------------------------------------")
            print ("Done with ad-hoc reporting on: " + filename)
            print ("------------------------------------------------------------")
            now = time.strftime("%c")
            print ("Report end: %s"  % now )
            print ("------------------------------------------------------------")
            print ("")
