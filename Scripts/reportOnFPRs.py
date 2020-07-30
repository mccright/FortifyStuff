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
import fnmatch
from subprocess import call
import subprocess
import os
import time

"""
This is a simple way to get a simple, light
report started for those who cannot use
and FPR file nor log into your SSC...
"""
sys.stdout = Unbuffered(sys.stdout)

"""
You need to edit the two lines below as your versions get upgraded...
"""
fortifyVersion="20.1.0"
jreVersion="1.8.0_212"
fprUtil="C:\\PROGRA~1\\Fortify\\Fortify_SCA_and_Apps_"+fortifyVersion+"\\bin\\FPRUtility.bat"

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
