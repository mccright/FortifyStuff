# Developer Access to Static Analysis Data  

**Need**: Provide developers accurate and timely static code security analysis (SCSA) feedback.  This seems most timely when a developer performs a git push or pull request.  


In an operational environment having a decentralized developer population, 'lots of' developers, a high-speed/high-capacity vulnerability analysis pipeline and/or a development environment incorporating multiple source code management (SCM) platforms there are material challenges for getting accurate and timely vulnerability information to each developer for each (relevant) source code push.  

* Fast and light-weight (from developer perspective)  
* Simple interface(s)  
* 'Mapped' to git push or pull request events  

The [Google Open Source Vulnerabilities (OSV)](https://osv.dev/) project has what seems like a useful way to start engineering a system to deal with these challenges.  The OSV provides an API that lets users query whether or not their open source component versions are impacted.  

By commit hash:  
```terminal
curl -X POST -d \
    '{"commit": "6879efc2c1596d11a6a6ad296f80063b558d5e0f"}' \
    "https://api.osv.dev/v1/query"
```
or by a package name and version:  
```terminal
curl -X POST -d \
    '{"version": "2.4.1", "package": {"name": "jinja2", "ecosystem": "PyPI"}}' \
    "https://api.osv.dev/v1/query"
```

Using a generic HTTP POST to query by **commit hash** seems like it would be useful in workflow automation hosted on most SCM or pipeline platforms and would provide tight coupling with a developers push event (whether or not it is associated with a pull request).  

In this case, a developer (*or the administrator of their CMS or pipeline platform*) would incorporate a *scripted* call to our static code security analysis results API in a manner analogous to Google's OSV API.  

By commit hash:  
```terminal
curl -X POST -d \
    '{"commit": "7a96d168efc2c151063b558d5e0fa6a6ad296f80"}' \
    "https://api.scsa.dev/v1/query"
```
or by a repository name (with an optional 'project' name) and branch:  
```terminal
curl -X POST -d \
    '{"repository": {"name": "inventory_apis", "project": "verifyproductavailability"}, "branch": "enhance-lookahead-logic" }' \
    "https://api.scsa.dev/v1/query"
```

In this scenario the SCSA API looks up the set of vulnerabilities affecting the specified commit or the *latest* analysis results for the specified repository & branch (*with an optional 'project'*) and returns data describing a list of vulnerabilities found in that code with supporting metadata.  

**Need**:  What is the 'schema' that will support maximum developer engagement and productivity?  What will support a good developer experience?  Clearly defining these issues and data is critical because output from SCSA platforms can be verbose, and sometimes include feedback of marginal value to any given developer.  

At this point, we assume that the vulnerability metadata should be returned in a machine-readable JSON format.  There may be value in providing a human-friendly format as well, depending on the SCM and pipeline platform(s) we need to support.  

The API consumer uses our information to identify and prioritise (*new*) units of work.  Depending on their environment, the SCM or pipeline platform may inject these units of work into an existing work management system.  

### What resources already exist?  
* [Schema.org](https://schema.org/docs/schemas.html): I could not find a model schema here that was useful for our use cases.  
* [STIX](https://stixproject.github.io/about/): STIX is a standard for documenting threat information more applicable to the broader category of cyber-threats.  It seems not well aligned to the specific needs of communicating SCSA vulnerability outputs to developers.  





## ADDITIONAL REFERENCES:  
* "NIST SP 500-268: Source Code Security Analysis Tool Functional Specification Version 1.0" with special attention to "Annex A Source Code Weaknesses" [https://www.govinfo.gov/content/pkg/GOVPUB-C13-988734ff9845c0f4cadf998e66e992cd/pdf/GOVPUB-C13-988734ff9845c0f4cadf998e66e992cd.pdf](https://www.govinfo.gov/content/pkg/GOVPUB-C13-988734ff9845c0f4cadf998e66e992cd/pdf/GOVPUB-C13-988734ff9845c0f4cadf998e66e992cd.pdf)