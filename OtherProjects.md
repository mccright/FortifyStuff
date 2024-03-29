# Other Fortify-Related Projects To Watch  

Projects that may be useful to those who work with the Fortify Static Code Security Analysis stack 
* Install Fortify client tooling in a pipeline (*or related use case*) [https://github.com/fortify/FortifyToolsInstaller](https://github.com/fortify/FortifyToolsInstaller/)  
* GitHub.com Actions:
  * "Fortify ScanCentral Scan" -- Test source with Fortify SAST scans [https://github.com/marketplace/actions/fortify-scancentral-scan](https://github.com/marketplace/actions/fortify-scancentral-scan)  
  * Fortify ScanCentral Client -- The source code - [https://github.com/fortify/gha-setup-scancentral-client](https://github.com/fortify/gha-setup-scancentral-client)  
  * "Generate SARIF from Fortify on Demand" -- Generate SARIF file from Fortify on Demand SAST results for import to GitHub [https://github.com/marketplace/actions/generate-sarif-from-fortify-on-demand](https://github.com/marketplace/actions/generate-sarif-from-fortify-on-demand)  
  * "Fortify on Demand Scan" -- Test source with Fortify SaaS scans [https://github.com/marketplace/actions/fortify-on-demand-scan](https://github.com/marketplace/actions/fortify-on-demand-scan)  
* GitLab CI Templates:
  * "Fortify ScanCentral GitLab CI Templates" -- this seems like something every GitLab project should use [https://gitlab.com/Fortify/gitlab-ci-templates](https://gitlab.com/Fortify/gitlab-ci-templates)  
* mleblebici/Security-Cheat-Sheets - [https://github.com/mleblebici/Security-Cheat-Sheets/](https://github.com/mleblebici/Security-Cheat-Sheets/)  
* Checks Fortify for projects and project versions [PowerShell]. If the project doesn't exist, then the task is capable of creating the project and an initial version. If the project version doesn't exist, then the task is capable of creating the version and also capable of copying issues/suppressions from previous versions. [https://github.com/jlburck/FortifyVersionCheck](https://github.com/jlburck/FortifyVersionCheck)  
* Communicate with Fortify Software Security Center through REST API in java, a swagger generated client [Java] [https://github.com/fortify/ssc-restapi-client](https://github.com/fortify/ssc-restapi-client).  The API "*schema*" is well documented in the [swagger/spec.json](https://raw.githubusercontent.com/fortify/ssc-restapi-client/master/src/swagger/spec.json) file.  
* Golang fortify client generated from official swagger docs [https://github.com/piper-validation/fortify-client-go](https://github.com/piper-validation/fortify-client-go)  
* Upload to the Fortify on Demand and optionally fill out dynamic scan forms upon application onboarding [https://github.com/reggiebIV/Fortify-on-Demand-Application-Uploader](https://github.com/reggiebIV/Fortify-on-Demand-Application-Uploader)  
* SSC on AWS - An article describing how to deploy SSC on AWS Elastic Beanstalk including some steps for automating SSC configuration. - [https://fortify.github.io/onprem/ssc-on-aws](https://fortify.github.io/onprem/ssc-on-aws)  
* therealchunt/ssc - Fortify Software Security Center DockerFile (17.10) - [https://github.com/therealchunt/ssc](https://github.com/therealchunt/ssc)  
* therealchunt/ssc_db - mysql database for SSC DockerFile (17.10) [https://github.com/therealchunt/ssc_db](https://github.com/therealchunt/ssc_db)  
* therealchunt/cloudscan_controller - Deploy CloudScan controller for Fortify SCA with Docker on tomcat 8.5.11 - [https://github.com/therealchunt/cloudscan_controller](https://github.com/therealchunt/cloudscan_controller)  
* therealchunt/cloudscan_sensor - cloudscan sensor with docker <not done> - [https://github.com/therealchunt/cloudscan_sensor](https://github.com/therealchunt/cloudscan_sensor)  
* avicoder/pyfortify - A Python interface for the Fortify API having the goal of mapping to Fortify endpoints one-to-one - [https://github.com/avicoder/pyfortify](https://github.com/avicoder/pyfortify)  
* locationlabs/python-hpfortify - Python client for Fortify on Demand v3 api.  [https://github.com/locationlabs/python-hpfortify](https://github.com/locationlabs/python-hpfortify)  
* "Create project using Fortify Software Security Center REST API" [https://stackoverflow.com/questions/36414245/create-project-using-fortify-software-security-center-rest-api](https://stackoverflow.com/questions/36414245/create-project-using-fortify-software-security-center-rest-api) along with "How to create application in SSC with REST API" - [https://community.microfocus.com/t5/Fortify-User-Discussions/How-to-create-application-in-SSC-with-REST-API/td-p/1553209](https://community.microfocus.com/t5/Fortify-User-Discussions/How-to-create-application-in-SSC-with-REST-API/td-p/1553209)  
* webbreaker/fortifyapi - Fortify API is a Python RESTFul API client module for Fortify's Software Security Center [https://github.com/webbreaker/fortifyapi](https://github.com/webbreaker/fortifyapi)  
* andersonshatch/sca-bash-completion - A Bash completion script for Micro Focus Fortify Source Code Analyzer (SCA) - [https://github.com/andersonshatch/sca-bash-completion](https://github.com/andersonshatch/sca-bash-completion)  
* rifatx/ffyruledecoder - IntelliJ project setup - [https://github.com/rifatx/ffyruledecoder](https://github.com/rifatx/ffyruledecoder)  
* mleblebici/Fortify - fpr2xlsx.py to help summarize the data so customers can better understand Fortify reports - [https://github.com/mleblebici/Fortify](https://github.com/mleblebici/Fortify)  
* Dead Target link to their "Python RESTFul API client module for Fortify's Software Security Center" - [https://github.com/target/fortifyapi/commit/18ce25eb0dd082dd3017f27162740cb29f7bda85](https://github.com/target/fortifyapi/commit/18ce25eb0dd082dd3017f27162740cb29f7bda85)  
  * One version of the Target fortifyapi: [https://github.com/target/fortifyapi/tree/1.0.19](https://github.com/target/fortifyapi/tree/1.0.19)  
  * and another version #18: [https://github.com/target/fortifyapi/tree/18ce25eb0dd082dd3017f27162740cb29f7bda85](https://github.com/target/fortifyapi/tree/18ce25eb0dd082dd3017f27162740cb29f7bda85)  
  * Fork of this code at: [https://github.com/djvillafana/fortifyapi](https://github.com/djvillafana/fortifyapi)  
* Relative of the Target code above (*still seems to be alive, recent activity-of-substance March 2022 - maybe a 'deloittecyber' connection now*)- [https://github.com/fortifyadmin/fortifyapi](https://github.com/fortifyadmin/fortifyapi)  
* How to create an application in Foritfy SSC via the API [https://community.microfocus.com/t5/Fortify-User-Discussions/How-to-create-application-in-SSC-with-REST-API/td-p/1553209](https://community.microfocus.com/t5/Fortify-User-Discussions/How-to-create-application-in-SSC-with-REST-API/td-p/1553209)  
* Pull dynamic scan form configuration for all applications within your portal [https://github.com/reggiebIV/Fortify-on-Demand-Dynamic-Form-Configuration-Report](https://github.com/reggiebIV/Fortify-on-Demand-Dynamic-Form-Configuration-Report)  
* Ligoj plugin for Fortify : issues and rate [https://github.com/ligoj/plugin-security-fortify](https://github.com/ligoj/plugin-security-fortify)  
* Fortify Subset of a broader ScanPlatformTool - [https://github.com/wilton2017/ScanPlatformTool/tree/master](https://github.com/wilton2017/ScanPlatformTool/tree/master)  
* Saltworks Security Fortify client project in Python - [https://github.com/gatsalt/FDRewrite](https://github.com/gatsalt/FDRewrite)  
* A model Fortify SSC client by [Behlül Şahin](https://github.com/behlulsahin): [https://github.com/behlulsahin/fortify/blob/master/python3/ssc-client3.py](https://github.com/behlulsahin/fortify/blob/master/python3/ssc-client3.py)  
* A relatively ancient inactive script to compare to FPR files that may have something of value. [https://github.com/EricRohlfs/FortifyCompare](https://github.com/EricRohlfs/FortifyCompare)  
* Here is an another ancient inactive script to interact with FPR files that may have something of value.  It includes some data structure and FPR file navigation hints that may fit a range of use cases [https://github.com/nicolasrod/fortipy](https://github.com/nicolasrod/fortipy)  
