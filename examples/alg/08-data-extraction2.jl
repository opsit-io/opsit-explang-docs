### Data Search and Extraction: Software Vulnerabilities

# Examples of data extraction from nested data structures. The structure is
# an output file of the Grype (https://github.com/anchore/grype) vulnerability
# scanner with some parts (not required for the examples) removed.

function main()
    vulnerabilities := readData();
    println("\n* List of all vulnerabilities with their severity ",
            "and fix statuses");
    vulnerabilities.matches
    | fields vulnerability (id, severity, fix.state)
    | println();

    println("\n* List of all High and Critical vulnerabilities with fix ",
            "status wont-fix");
    vulnerabilities.matches
    | search vulnerability.severity in ["Critical","High"]
             and (vulnerability.fix.state == "wont-fix")
    | fields vulnerability.id, artifact (name as "artifact",  version)
    | println();
    
    println("\n* Count of all High and Critical vulnerabilities");
    vulnerabilities.matches
    | search vulnerability.severity in ["Critical","High"] | length()
    | println();

    println("\n* Return Boolean status if there are Critical vulnerabilities");
    vulnerabilities.matches
    | search vulnerability.severity in ["Critical","High"] | bool()
    | println();

    println("\n* Return True if there is 10 or more High or Critical ",
            "vulnerabilities");
    vulnerabilities.matches
    | search vulnerability.severity in ["Critical","High"] | length() | >=(10)
    | println();

    println("\n* Return counts of vulnerabilities per severity");
    vulnerabilities.matches
    | []["vulnerability"]["severity"]
    | reduce( (m,severity) -> begin m[severity] := m[severity] + 1; m; end, {} )
    | println();
    
    println("\n* make CSV report of High and Critical vulnerabilities ",
            "with fix status wont-fix");
    vulnerabilities.matches
    | fields vulnerability (id, severity, fix.state), artifact (name as "artifact", version)
    | search severity in ["Critical", "High", "Medium"] and state == "wont-fix"
    | map(x -> i"$(x.id),$(x.artifact),$(x.version)")
    | sort()
    | join("\n")
    | println()
end;


function readData()
    return ({
        # remov ed non relevent parts
        "distro" : {},
        "source" : {},
        "matches" : [{
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:openssl:openssl:1.1.1n-0+deb11u3:*:*:*:*:*:*:*" ],
                "name" : "openssl",
                "purl" : "pkg:deb/debian/openssl@1.1.1n-0+deb11u3?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "1.1.1n-0+deb11u3",
                "language" : "",
                "licenses" : [ ],
                "locations" : [ {
                    "path" : "/usr/share/doc/openssl/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/openssl.conffiles",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/openssl.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "openssl",
                        "version" : "1.1.1n-0+deb11u3"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2010-0928",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2010-0928" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2010-0928",
                "description" : "OpenSSL 0.9.8i on the Gaisler Research LEON3 SoC on the Xilinx Virtex-II Pro FPGA uses a Fixed Width Exponentiation (FWE) algorithm for certain signature calculations, and does not verify the signature before providing it to a caller, which makes it easier for physically proximate attackers to determine the private key via a modified supply voltage for the microprocessor, related to a \"fault-based attack.\""
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2010-0928",
                "cvss" : [ {
                    "vector" : "AV:L/AC:H/Au:N/C:C/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 4,
                        "impactScore" : 6.9,
                        "exploitabilityScore" : 1.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "http://www.eecs.umich.edu/%7Evaleria/research/publications/DATE10RSA.pdf", "http://www.networkworld.com/news/2010/030410-rsa-security-attack.html", "http://www.theregister.co.uk/2010/03/04/severe_openssl_vulnerability/", "http://rdist.root.org/2010/03/08/attacking-rsa-exponentiation-with-fault-injection/", "http://www.osvdb.org/62808", "https://exchange.xforce.ibmcloud.com/vulnerabilities/56750" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2010-0928",
                "description" : "OpenSSL 0.9.8i on the Gaisler Research LEON3 SoC on the Xilinx Virtex-II Pro FPGA uses a Fixed Width Exponentiation (FWE) algorithm for certain signature calculations, and does not verify the signature before providing it to a caller, which makes it easier for physically proximate attackers to determine the private key via a modified supply voltage for the microprocessor, related to a \"fault-based attack.\""
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libgnutls30:libgnutls30:3.7.1-5+deb11u2:*:*:*:*:*:*:*" ],
                "name" : "libgnutls30",
                "purl" : "pkg:deb/debian/libgnutls30@3.7.1-5+deb11u2?arch=amd64&upstream=gnutls28&distro=debian-11",
                "type" : "deb",
                "version" : "3.7.1-5+deb11u2",
                "language" : "",
                "licenses" : [ "Apache-2.0", "BSD-3-Clause", "CC0", "Expat", "GFDL-1.3", "GPL", "GPL-3", "GPLv3+", "LGPL", "LGPL-3", "LGPLv2.1+", "LGPLv3+_or_GPLv2+", "The" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libgnutls30/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libgnutls30:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "gnutls28"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "gnutls28",
                        "version" : "3.7.1-5+deb11u2"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2011-3389",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2011-3389" ],
                "severity" : "Medium",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2011-3389",
                "description" : "The SSL protocol, as used in certain configurations in Microsoft Windows and Microsoft Internet Explorer, Mozilla Firefox, Google Chrome, Opera, and other products, encrypts data by using CBC mode with chained initialization vectors, which allows man-in-the-middle attackers to obtain plaintext HTTP headers via a blockwise chosen-boundary attack (BCBA) on an HTTPS session, in conjunction with JavaScript code that uses (1) the HTML5 WebSocket API, (2) the Java URLConnection API, or (3) the Silverlight WebClient API, aka a \"BEAST\" attack."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2011-3389",
                "cvss" : [ {
                    "vector" : "AV:N/AC:M/Au:N/C:P/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 4.3,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 8.6
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "http://www.opera.com/docs/changelogs/unix/1151/", "http://www.securityfocus.com/bid/49388", "http://www.opera.com/docs/changelogs/windows/1151/", "http://www.opera.com/docs/changelogs/mac/1151/", "http://osvdb.org/74829", "http://secunia.com/advisories/45791", "http://www.securitytracker.com/id?1025997", "http://eprint.iacr.org/2004/111", "https://bugzilla.redhat.com/show_bug.cgi?id=737506", "http://ekoparty.org/2011/juliano-rizzo.php", "http://www.imperialviolet.org/2011/09/23/chromeandbeast.html", "https://bugzilla.novell.com/show_bug.cgi?id=719047", "http://www.insecure.cl/Beast-SSL.rar", "http://www.educatedguesswork.org/2011/09/security_impact_of_the_rizzodu.html", "http://eprint.iacr.org/2006/136", "http://isc.sans.edu/diary/SSL+TLS+part+3+/11635", "http://my.opera.com/securitygroup/blog/2011/09/28/the-beast-ssl-tls-issue", "http://blog.mozilla.com/security/2011/09/27/attack-against-tls-protected-communications/", "http://blogs.technet.com/b/msrc/archive/2011/09/26/microsoft-releases-security-advisory-2588513.aspx", "http://technet.microsoft.com/security/advisory/2588513", "http://support.apple.com/kb/HT4999", "http://www.oracle.com/technetwork/topics/security/javacpuoct2011-443431.html", "http://support.apple.com/kb/HT5001", "http://lists.apple.com/archives/Security-announce/2011//Oct/msg00001.html", "http://lists.apple.com/archives/Security-announce/2011//Oct/msg00002.html", "http://www.securitytracker.com/id?1026103", "http://www.securityfocus.com/bid/49778", "http://blogs.technet.com/b/srd/archive/2011/09/26/is-ssl-broken-more-about-security-advisory-2588513.aspx", "http://www.redhat.com/support/errata/RHSA-2011-1384.html", "http://vnhacker.blogspot.com/2011/09/beast.html", "http://www.kb.cert.org/vuls/id/864643", "http://googlechromereleases.blogspot.com/2011/10/chrome-stable-release.html", "http://www.ibm.com/developerworks/java/jdk/alerts/", "http://www.opera.com/docs/changelogs/windows/1160/", "http://www.opera.com/docs/changelogs/mac/1160/", "http://www.opera.com/support/kb/view/1004/", "http://www.opera.com/docs/changelogs/unix/1160/", "http://www.redhat.com/support/errata/RHSA-2012-0006.html", "http://support.apple.com/kb/HT5130", "http://lists.apple.com/archives/security-announce/2012/Feb/msg00000.html", "http://marc.info/?l=bugtraq&m=132872385320240&w=2", "http://support.apple.com/kb/HT5281", "http://lists.apple.com/archives/security-announce/2012/May/msg00001.html", "http://lists.apple.com/archives/security-announce/2012/Jul/msg00001.html", "http://support.apple.com/kb/HT5501", "http://lists.apple.com/archives/security-announce/2012/Sep/msg00004.html", "http://secunia.com/advisories/49198", "http://lists.opensuse.org/opensuse-security-announce/2012-01/msg00051.html", "https://hermes.opensuse.org/messages/13155432", "https://hermes.opensuse.org/messages/13154861", "http://lists.opensuse.org/opensuse-security-announce/2012-01/msg00049.html", "http://marc.info/?l=bugtraq&m=132750579901589&w=2", "http://secunia.com/advisories/48692", "https://blogs.oracle.com/sunsecurity/entry/multiple_vulnerabilities_in_fetchmail", "http://secunia.com/advisories/48948", "http://secunia.com/advisories/48915", "http://www.us-cert.gov/cas/techalerts/TA12-010A.html", "https://h20564.www2.hp.com/portal/site/hpsc/public/kb/docDisplay?docId=emr_na-c03839862", "http://secunia.com/advisories/55351", "http://secunia.com/advisories/55322", "http://secunia.com/advisories/55350", "http://www.securitytracker.com/id/1029190", "http://rhn.redhat.com/errata/RHSA-2013-1455.html", "http://lists.apple.com/archives/security-announce/2013/Oct/msg00004.html", "http://www.ubuntu.com/usn/USN-1263-1", "http://support.apple.com/kb/HT6150", "http://security.gentoo.org/glsa/glsa-201406-32.xml", "http://www.oracle.com/technetwork/topics/security/cpujan2015-1972971.html", "http://www.oracle.com/technetwork/topics/security/cpujul2015-2367936.html", "http://downloads.asterisk.org/pub/security/AST-2016-001.html", "http://marc.info/?l=bugtraq&m=134254957702612&w=2", "http://marc.info/?l=bugtraq&m=133365109612558&w=2", "http://marc.info/?l=bugtraq&m=133728004526190&w=2", "http://www.apcmedia.com/salestools/SJHN-7RKGNM/SJHN-7RKGNM_R4_EN.pdf", "https://oval.cisecurity.org/repository/search/definition/oval%3Aorg.mitre.oval%3Adef%3A14752", "http://marc.info/?l=bugtraq&m=134254866602253&w=2", "http://www.mandriva.com/security/advisories?name=MDVSA-2012:058", "http://rhn.redhat.com/errata/RHSA-2012-0508.html", "http://lists.opensuse.org/opensuse-security-announce/2012-05/msg00009.html", "http://security.gentoo.org/glsa/glsa-201203-02.xml", "http://secunia.com/advisories/48256", "http://www.securitytracker.com/id?1026704", "http://secunia.com/advisories/47998", "http://www.debian.org/security/2012/dsa-2398", "http://curl.haxx.se/docs/adv_20120124B.html", "https://ics-cert.us-cert.gov/advisories/ICSMA-18-058-02", "https://docs.microsoft.com/en-us/security-updates/securitybulletins/2012/ms12-006", "https://cert-portal.siemens.com/productcert/pdf/ssa-556833.pdf", "http://lists.opensuse.org/opensuse-security-announce/2020-01/msg00040.html" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2011-3389",
                "description" : "The SSL protocol, as used in certain configurations in Microsoft Windows and Microsoft Internet Explorer, Mozilla Firefox, Google Chrome, Opera, and other products, encrypts data by using CBC mode with chained initialization vectors, which allows man-in-the-middle attackers to obtain plaintext HTTP headers via a blockwise chosen-boundary attack (BCBA) on an HTTPS session, in conjunction with JavaScript code that uses (1) the HTML5 WebSocket API, (2) the Java URLConnection API, or (3) the Silverlight WebClient API, aka a \"BEAST\" attack."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:perl-base:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl-base:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl_base:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl_base:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*" ],
                "name" : "perl-base",
                "purl" : "pkg:deb/debian/perl-base@5.32.1-4+deb11u2?arch=amd64&upstream=perl&distro=debian-11",
                "type" : "deb",
                "version" : "5.32.1-4+deb11u2",
                "language" : "",
                "licenses" : [ "Artistic", "Artistic-2", "Artistic-dist", "BSD-3-clause", "BSD-3-clause-GENERIC", "BSD-3-clause-with-weird-numbering", "BSD-4-clause-POWERDOG", "BZIP", "DONT-CHANGE-THE-GPL", "Expat", "GPL-1", "GPL-1+", "GPL-2", "GPL-2+", "GPL-3+-WITH-BISON-EXCEPTION", "HSIEH-BSD", "HSIEH-DERIVATIVE", "LGPL-2.1", "REGCOMP", "REGCOMP,", "RRA-KEEP-THIS-NOTICE", "SDBM-PUBLIC-DOMAIN", "TEXT-TABS", "Unicode", "ZLIB" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/perl-base/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/perl-base.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "perl"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "perl",
                        "version" : "5.32.1-4+deb11u2"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2011-4116",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2011-4116" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2011-4116",
                "description" : "_is_safe in the File::Temp module for Perl does not properly handle symlinks."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2011-4116",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:N/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 5,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:N",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "http://www.openwall.com/lists/oss-security/2011/11/04/2", "https://rt.cpan.org/Public/Bug/Display.html?id=69106", "https://github.com/Perl-Toolchain-Gang/File-Temp/issues/14", "http://www.openwall.com/lists/oss-security/2011/11/04/4", "https://seclists.org/oss-sec/2011/q4/238" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2011-4116",
                "description" : "_is_safe in the File::Temp module for Perl does not properly handle symlinks."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:nginx:nginx:1.23.1-1~bullseye:*:*:*:*:*:*:*" ],
                "name" : "nginx",
                "purl" : "pkg:deb/debian/nginx@1.23.1-1~bullseye?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "1.23.1-1~bullseye",
                "language" : "",
                "licenses" : [ ],
                "locations" : [ {
                    "path" : "/usr/share/doc/nginx/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/nginx.conffiles",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/nginx.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "nginx",
                        "version" : "1.23.1-1~bullseye"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2013-0337",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2013-0337" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2013-0337",
                "description" : "The default configuration of nginx, possibly 1.3.13 and earlier, uses world-readable permissions for the (1) access.log and (2) error.log files, which allows local users to obtain sensitive information by reading the files."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2013-0337",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:P/I:P/A:P",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 6.4,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "http://www.openwall.com/lists/oss-security/2013/02/21/15", "http://www.openwall.com/lists/oss-security/2013/02/22/1", "http://secunia.com/advisories/55181", "http://www.openwall.com/lists/oss-security/2013/02/24/1", "http://security.gentoo.org/glsa/glsa-201310-04.xml" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2013-0337",
                "description" : "The default configuration of nginx, possibly 1.3.13 and earlier, uses world-readable permissions for the (1) access.log and (2) error.log files, which allows local users to obtain sensitive information by reading the files."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:coreutils:coreutils:8.32-4+b1:*:*:*:*:*:*:*" ],
                "name" : "coreutils",
                "purl" : "pkg:deb/debian/coreutils@8.32-4+b1?arch=amd64&upstream=coreutils%408.32-4&distro=debian-11",
                "type" : "deb",
                "version" : "8.32-4+b1",
                "language" : "",
                "licenses" : [ "GPL-3" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/coreutils/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/coreutils.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "coreutils",
                    "version" : "8.32-4"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "coreutils",
                        "version" : "8.32-4"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2016-2781",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2016-2781" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2016-2781",
                "description" : "chroot in GNU coreutils, when used with --userspec, allows local users to escape to the parent session via a crafted TIOCSTI ioctl call, which pushes characters to the terminal's input buffer."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2016-2781",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.0/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:N",
                    "metrics" : {
                        "baseScore" : 6.5,
                        "impactScore" : 4,
                        "exploitabilityScore" : 2
                    },
                    "version" : "3.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "http://www.openwall.com/lists/oss-security/2016/02/28/3", "http://www.openwall.com/lists/oss-security/2016/02/28/2", "https://lists.apache.org/thread.html/rf9fa47ab66495c78bb4120b0754dd9531ca2ff0430f6685ac9b07772@%3Cdev.mina.apache.org%3E" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2016-2781",
                "description" : "chroot in GNU coreutils, when used with --userspec, allows local users to escape to the parent session via a crafted TIOCSTI ioctl call, which pushes characters to the terminal's input buffer."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libxml2:libxml2:2.9.10+dfsg-6.7+deb11u2:*:*:*:*:*:*:*" ],
                "name" : "libxml2",
                "purl" : "pkg:deb/debian/libxml2@2.9.10+dfsg-6.7+deb11u2?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "2.9.10+dfsg-6.7+deb11u2",
                "language" : "",
                "licenses" : [ "ISC", "MIT-1" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libxml2/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libxml2:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libxml2",
                        "version" : "2.9.10+dfsg-6.7+deb11u2"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2016-3709",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2016-3709" ],
                "severity" : "Medium",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2016-3709",
                "description" : "Possible cross-site scripting vulnerability in libxml after commit 960f0e2."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2016-3709",
                "cvss" : [ {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N",
                    "metrics" : {
                        "baseScore" : 6.1,
                        "impactScore" : 2.7,
                        "exploitabilityScore" : 2.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://mail.gnome.org/archives/xml/2018-January/msg00010.html" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2016-3709",
                "description" : "Possible cross-site scripting vulnerability in libxml after commit 960f0e2."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libwebp6:libwebp6:0.6.1-2.1:*:*:*:*:*:*:*" ],
                "name" : "libwebp6",
                "purl" : "pkg:deb/debian/libwebp6@0.6.1-2.1?arch=amd64&upstream=libwebp&distro=debian-11",
                "type" : "deb",
                "version" : "0.6.1-2.1",
                "language" : "",
                "licenses" : [ "Apache-2.0" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libwebp6/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libwebp6:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libwebp"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libwebp",
                        "version" : "0.6.1-2.1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2016-9085",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2016-9085" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2016-9085",
                "description" : "Multiple integer overflows in libwebp allows attackers to have unspecified impact via unknown vectors."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2016-9085",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:N/A:L",
                    "metrics" : {
                        "baseScore" : 3.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://security.gentoo.org/glsa/201701-61", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/SH6X3MWD5AHZC5JT4625PGFHAYLR7YW7/", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/PTR2ZW67TMT7KC24RBENIF25KWUJ7VPD/", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/LG5Q42J7EJDKQKWTTHCO4YZMOMP74YPQ/", "https://chromium.googlesource.com/webm/libwebp/+/e2affacc35f1df6cc3b1a9fa0ceff5ce2d0cce83", "https://bugzilla.redhat.com/show_bug.cgi?id=1389338", "http://www.securityfocus.com/bid/93928", "http://www.openwall.com/lists/oss-security/2016/10/27/3", "https://lists.apache.org/thread.html/rf9fa47ab66495c78bb4120b0754dd9531ca2ff0430f6685ac9b07772@%3Cdev.mina.apache.org%3E" ],
                "severity" : "Low",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2016-9085",
                "description" : "Multiple integer overflows in libwebp allows attackers to have unspecified impact via unknown vectors."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:login:login:1:4.8.1-1:*:*:*:*:*:*:*" ],
                "name" : "login",
                "purl" : "pkg:deb/debian/login@1:4.8.1-1?arch=amd64&upstream=shadow&distro=debian-11",
                "type" : "deb",
                "version" : "1:4.8.1-1",
                "language" : "",
                "licenses" : [ "GPL-2" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/login/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/login.conffiles",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/login.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "shadow"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "shadow",
                        "version" : "1:4.8.1-1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2019-19882",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2019-19882" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2019-19882",
                "description" : "shadow 4.8, in certain circumstances affecting at least Gentoo, Arch Linux, and Void Linux, allows local users to obtain root access because setuid programs are misconfigured. Specifically, this affects shadow 4.8 when compiled using --with-libpam but without explicitly passing --disable-account-tools-setuid, and without a PAM configuration suitable for use with setuid account management tools. This combination leads to account management tools (groupadd, groupdel, groupmod, useradd, userdel, usermod) that can easily be used by unprivileged local users to escalate privileges to root in multiple ways. This issue became much more relevant in approximately December 2019 when an unrelated bug was fixed (i.e., the chmod calls to suidusbins were fixed in the upstream Makefile which is now included in the release version 4.8)."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2019-19882",
                "cvss" : [ {
                    "vector" : "AV:L/AC:M/Au:N/C:C/I:C/A:C",
                    "metrics" : {
                        "baseScore" : 6.9,
                        "impactScore" : 10,
                        "exploitabilityScore" : 3.4
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H",
                    "metrics" : {
                        "baseScore" : 7.8,
                        "impactScore" : 5.9,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://bugs.archlinux.org/task/64836", "https://github.com/shadow-maint/shadow/pull/199", "https://github.com/void-linux/void-packages/pull/17580", "https://bugs.gentoo.org/702252", "https://github.com/shadow-maint/shadow/commit/edf7547ad5aa650be868cf2dac58944773c12d75", "https://security.gentoo.org/glsa/202008-09" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2019-19882",
                "description" : "shadow 4.8, in certain circumstances affecting at least Gentoo, Arch Linux, and Void Linux, allows local users to obtain root access because setuid programs are misconfigured. Specifically, this affects shadow 4.8 when compiled using --with-libpam but without explicitly passing --disable-account-tools-setuid, and without a PAM configuration suitable for use with setuid account management tools. This combination leads to account management tools (groupadd, groupdel, groupmod, useradd, userdel, usermod) that can easily be used by unprivileged local users to escalate privileges to root in multiple ways. This issue became much more relevant in approximately December 2019 when an unrelated bug was fixed (i.e., the chmod calls to suidusbins were fixed in the upstream Makefile which is now included in the release version 4.8)."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libdb5.3:libdb5.3:5.3.28+dfsg1-0.8:*:*:*:*:*:*:*" ],
                "name" : "libdb5.3",
                "purl" : "pkg:deb/debian/libdb5.3@5.3.28+dfsg1-0.8?arch=amd64&upstream=db5.3&distro=debian-11",
                "type" : "deb",
                "version" : "5.3.28+dfsg1-0.8",
                "language" : "",
                "licenses" : [ ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libdb5.3/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libdb5.3:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "db5.3"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "db5.3",
                        "version" : "5.3.28+dfsg1-0.8"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2019-8457",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2019-8457" ],
                "severity" : "Critical",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2019-8457",
                "description" : "SQLite3 from 3.6.0 to and including 3.27.2 is vulnerable to heap out-of-bound read in the rtreenode() function when handling invalid rtree tables."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2019-8457",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:P/I:P/A:P",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 6.4,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H",
                    "metrics" : {
                        "baseScore" : 9.8,
                        "impactScore" : 5.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://www.sqlite.org/src/info/90acdbfce9c08858", "https://www.sqlite.org/releaselog/3_28_0.html", "https://usn.ubuntu.com/4004-1/", "https://usn.ubuntu.com/4004-2/", "https://security.netapp.com/advisory/ntap-20190606-0002/", "https://usn.ubuntu.com/4019-1/", "https://usn.ubuntu.com/4019-2/", "http://lists.opensuse.org/opensuse-security-announce/2019-06/msg00074.html", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/SJPFGA45DI4F5MCF2OAACGH3HQOF4G3M/", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/OPKYSWCOM3CL66RI76TYVIG6TJ263RXH/", "https://www.oracle.com/technetwork/security-advisory/cpuoct2019-5072832.html", "https://www.oracle.com/security-alerts/cpujan2020.html", "https://www.oracle.com/security-alerts/cpuapr2020.html", "https://www.oracle.com/security-alerts/cpujul2020.html", "https://kc.mcafee.com/corporate/index?page=content&id=SB10365" ],
                "severity" : "Critical",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2019-8457",
                "description" : "SQLite3 from 3.6.0 to and including 3.27.2 is vulnerable to heap out-of-bound read in the rtreenode() function when handling invalid rtree tables."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libc-bin:libc-bin:2.31-13+deb11u4:*:*:*:*:*:*:*", "cpe:2.3:a:libc-bin:libc_bin:2.31-13+deb11u4:*:*:*:*:*:*:*", "cpe:2.3:a:libc_bin:libc-bin:2.31-13+deb11u4:*:*:*:*:*:*:*", "cpe:2.3:a:libc_bin:libc_bin:2.31-13+deb11u4:*:*:*:*:*:*:*", "cpe:2.3:a:libc:libc-bin:2.31-13+deb11u4:*:*:*:*:*:*:*", "cpe:2.3:a:libc:libc_bin:2.31-13+deb11u4:*:*:*:*:*:*:*" ],
                "name" : "libc-bin",
                "purl" : "pkg:deb/debian/libc-bin@2.31-13+deb11u4?arch=amd64&upstream=glibc&distro=debian-11",
                "type" : "deb",
                "version" : "2.31-13+deb11u4",
                "language" : "",
                "licenses" : [ "GPL-2", "LGPL-2.1" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libc-bin/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libc-bin.conffiles",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libc-bin.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "glibc"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "glibc",
                        "version" : "2.31-13+deb11u4"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2019-9192",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2019-9192" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2019-9192",
                "description" : "** DISPUTED ** In the GNU C Library (aka glibc or libc6) through 2.29, check_dst_limits_calc_pos_1 in posix/regexec.c has Uncontrolled Recursion, as demonstrated by '(|)(\\\\1\\\\1)*' in grep, a different issue than CVE-2018-20796. NOTE: the software maintainer disputes that this is a vulnerability because the behavior occurs only with a crafted pattern."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2019-9192",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 5,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://sourceware.org/bugzilla/show_bug.cgi?id=24269", "https://support.f5.com/csp/article/K26346590?utm_source=f5support&amp;utm_medium=RSS" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2019-9192",
                "description" : "** DISPUTED ** In the GNU C Library (aka glibc or libc6) through 2.29, check_dst_limits_calc_pos_1 in posix/regexec.c has Uncontrolled Recursion, as demonstrated by '(|)(\\\\1\\\\1)*' in grep, a different issue than CVE-2018-20796. NOTE: the software maintainer disputes that this is a vulnerability because the behavior occurs only with a crafted pattern."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libc6:libc6:2.31-13+deb11u4:*:*:*:*:*:*:*" ],
                "name" : "libc6",
                "purl" : "pkg:deb/debian/libc6@2.31-13+deb11u4?arch=amd64&upstream=glibc&distro=debian-11",
                "type" : "deb",
                "version" : "2.31-13+deb11u4",
                "language" : "",
                "licenses" : [ "GPL-2", "LGPL-2.1" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libc6/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libc6:amd64.conffiles",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libc6:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "glibc"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "glibc",
                        "version" : "2.31-13+deb11u4"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2019-9192",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2019-9192" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2019-9192",
                "description" : "** DISPUTED ** In the GNU C Library (aka glibc or libc6) through 2.29, check_dst_limits_calc_pos_1 in posix/regexec.c has Uncontrolled Recursion, as demonstrated by '(|)(\\\\1\\\\1)*' in grep, a different issue than CVE-2018-20796. NOTE: the software maintainer disputes that this is a vulnerability because the behavior occurs only with a crafted pattern."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2019-9192",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 5,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.0",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://sourceware.org/bugzilla/show_bug.cgi?id=24269", "https://support.f5.com/csp/article/K26346590?utm_source=f5support&amp;utm_medium=RSS" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2019-9192",
                "description" : "** DISPUTED ** In the GNU C Library (aka glibc or libc6) through 2.29, check_dst_limits_calc_pos_1 in posix/regexec.c has Uncontrolled Recursion, as demonstrated by '(|)(\\\\1\\\\1)*' in grep, a different issue than CVE-2018-20796. NOTE: the software maintainer disputes that this is a vulnerability because the behavior occurs only with a crafted pattern."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libsystemd0:libsystemd0:247.3-7+deb11u1:*:*:*:*:*:*:*" ],
                "name" : "libsystemd0",
                "purl" : "pkg:deb/debian/libsystemd0@247.3-7+deb11u1?arch=amd64&upstream=systemd&distro=debian-11",
                "type" : "deb",
                "version" : "247.3-7+deb11u1",
                "language" : "",
                "licenses" : [ "CC0-1.0", "Expat", "GPL-2", "GPL-2+", "LGPL-2.1", "LGPL-2.1+", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libsystemd0/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libsystemd0:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "systemd"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "systemd",
                        "version" : "247.3-7+deb11u1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2020-13529",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2020-13529" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2020-13529",
                "description" : "An exploitable denial-of-service vulnerability exists in Systemd 245. A specially crafted DHCP FORCERENEW packet can cause a server running the DHCP client to be vulnerable to a DHCP ACK spoofing attack. An attacker can forge a pair of FORCERENEW and DCHP ACK packets to reconfigure the server."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2020-13529",
                "cvss" : [ {
                    "vector" : "AV:A/AC:M/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.9,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 5.5
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:A/AC:H/PR:N/UI:N/S:C/C:N/I:N/A:H",
                    "metrics" : {
                        "baseScore" : 6.1,
                        "impactScore" : 4,
                        "exploitabilityScore" : 1.6
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://talosintelligence.com/vulnerability_reports/TALOS-2020-1142", "https://security.netapp.com/advisory/ntap-20210625-0005/", "https://security.gentoo.org/glsa/202107-48", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/42TMJVNYRY65B4QCJICBYOEIVZV3KUYI/", "http://www.openwall.com/lists/oss-security/2021/08/04/2", "http://www.openwall.com/lists/oss-security/2021/08/17/3", "http://www.openwall.com/lists/oss-security/2021/09/07/3" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2020-13529",
                "description" : "An exploitable denial-of-service vulnerability exists in Systemd 245. A specially crafted DHCP FORCERENEW packet can cause a server running the DHCP client to be vulnerable to a DHCP ACK spoofing attack. An attacker can forge a pair of FORCERENEW and DCHP ACK packets to reconfigure the server."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libudev1:libudev1:247.3-7+deb11u1:*:*:*:*:*:*:*" ],
                "name" : "libudev1",
                "purl" : "pkg:deb/debian/libudev1@247.3-7+deb11u1?arch=amd64&upstream=systemd&distro=debian-11",
                "type" : "deb",
                "version" : "247.3-7+deb11u1",
                "language" : "",
                "licenses" : [ "CC0-1.0", "Expat", "GPL-2", "GPL-2+", "LGPL-2.1", "LGPL-2.1+", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libudev1/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libudev1:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "systemd"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "systemd",
                        "version" : "247.3-7+deb11u1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2020-13529",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2020-13529" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2020-13529",
                "description" : "An exploitable denial-of-service vulnerability exists in Systemd 245. A specially crafted DHCP FORCERENEW packet can cause a server running the DHCP client to be vulnerable to a DHCP ACK spoofing attack. An attacker can forge a pair of FORCERENEW and DCHP ACK packets to reconfigure the server."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2020-13529",
                "cvss" : [ {
                    "vector" : "AV:A/AC:M/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.9,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 5.5
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:A/AC:H/PR:N/UI:N/S:C/C:N/I:N/A:H",
                    "metrics" : {
                        "baseScore" : 6.1,
                        "impactScore" : 4,
                        "exploitabilityScore" : 1.6
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://talosintelligence.com/vulnerability_reports/TALOS-2020-1142", "https://security.netapp.com/advisory/ntap-20210625-0005/", "https://security.gentoo.org/glsa/202107-48", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/42TMJVNYRY65B4QCJICBYOEIVZV3KUYI/", "http://www.openwall.com/lists/oss-security/2021/08/04/2", "http://www.openwall.com/lists/oss-security/2021/08/17/3", "http://www.openwall.com/lists/oss-security/2021/09/07/3" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2020-13529",
                "description" : "An exploitable denial-of-service vulnerability exists in Systemd 245. A specially crafted DHCP FORCERENEW packet can cause a server running the DHCP client to be vulnerable to a DHCP ACK spoofing attack. An attacker can forge a pair of FORCERENEW and DCHP ACK packets to reconfigure the server."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libldap-2.4-2:libldap-2.4-2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap-2.4-2:libldap_2.4_2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap_2.4_2:libldap-2.4-2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap_2.4_2:libldap_2.4_2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap-2.4:libldap-2.4-2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap-2.4:libldap_2.4_2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap_2.4:libldap-2.4-2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap_2.4:libldap_2.4_2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap:libldap-2.4-2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*", "cpe:2.3:a:libldap:libldap_2.4_2:2.4.57+dfsg-3+deb11u1:*:*:*:*:*:*:*" ],
                "name" : "libldap-2.4-2",
                "purl" : "pkg:deb/debian/libldap-2.4-2@2.4.57+dfsg-3+deb11u1?arch=amd64&upstream=openldap&distro=debian-11",
                "type" : "deb",
                "version" : "2.4.57+dfsg-3+deb11u1",
                "language" : "",
                "licenses" : [ ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libldap-2.4-2/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libldap-2.4-2:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "openldap"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "openldap",
                        "version" : "2.4.57+dfsg-3+deb11u1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2020-15719",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2020-15719" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2020-15719",
                "description" : "libldap in certain third-party OpenLDAP packages has a certificate-validation flaw when the third-party package is asserting RFC6125 support. It considers CN even when there is a non-matching subjectAltName (SAN). This is fixed in, for example, openldap-2.4.46-10.el8 in Red Hat Enterprise Linux."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2020-15719",
                "cvss" : [ {
                    "vector" : "AV:N/AC:H/Au:N/C:P/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 4,
                        "impactScore" : 4.9,
                        "exploitabilityScore" : 4.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:U/C:L/I:L/A:N",
                    "metrics" : {
                        "baseScore" : 4.2,
                        "impactScore" : 2.5,
                        "exploitabilityScore" : 1.6
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://access.redhat.com/errata/RHBA-2019:3674", "https://bugzilla.redhat.com/show_bug.cgi?id=1740070", "https://bugs.openldap.org/show_bug.cgi?id=9266", "http://lists.opensuse.org/opensuse-security-announce/2020-09/msg00033.html", "http://lists.opensuse.org/opensuse-security-announce/2020-09/msg00059.html", "https://kc.mcafee.com/corporate/index?page=content&id=SB10365", "https://www.oracle.com/security-alerts/cpuapr2022.html" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2020-15719",
                "description" : "libldap in certain third-party OpenLDAP packages has a certificate-validation flaw when the third-party package is asserting RFC6125 support. It considers CN even when there is a non-matching subjectAltName (SAN). This is fixed in, for example, openldap-2.4.46-10.el8 in Red Hat Enterprise Linux."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:perl-base:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl-base:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl_base:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl_base:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl:perl-base:5.32.1-4+deb11u2:*:*:*:*:*:*:*", "cpe:2.3:a:perl:perl_base:5.32.1-4+deb11u2:*:*:*:*:*:*:*" ],
                "name" : "perl-base",
                "purl" : "pkg:deb/debian/perl-base@5.32.1-4+deb11u2?arch=amd64&upstream=perl&distro=debian-11",
                "type" : "deb",
                "version" : "5.32.1-4+deb11u2",
                "language" : "",
                "licenses" : [ "Artistic", "Artistic-2", "Artistic-dist", "BSD-3-clause", "BSD-3-clause-GENERIC", "BSD-3-clause-with-weird-numbering", "BSD-4-clause-POWERDOG", "BZIP", "DONT-CHANGE-THE-GPL", "Expat", "GPL-1", "GPL-1+", "GPL-2", "GPL-2+", "GPL-3+-WITH-BISON-EXCEPTION", "HSIEH-BSD", "HSIEH-DERIVATIVE", "LGPL-2.1", "REGCOMP", "REGCOMP,", "RRA-KEEP-THIS-NOTICE", "SDBM-PUBLIC-DOMAIN", "TEXT-TABS", "Unicode", "ZLIB" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/perl-base/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/perl-base.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "perl"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "perl",
                        "version" : "5.32.1-4+deb11u2"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2020-16156",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2020-16156" ],
                "severity" : "High",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2020-16156",
                "description" : "CPAN 2.28 allows Signature Verification Bypass."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2020-16156",
                "cvss" : [ {
                    "vector" : "AV:N/AC:M/Au:N/C:P/I:P/A:P",
                    "metrics" : {
                        "baseScore" : 6.8,
                        "impactScore" : 6.4,
                        "exploitabilityScore" : 8.6
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:H",
                    "metrics" : {
                        "baseScore" : 7.8,
                        "impactScore" : 5.9,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://metacpan.org/pod/distribution/CPAN/scripts/cpan", "https://blog.hackeriet.no/cpan-signature-verification-vulnerabilities/", "http://blogs.perl.org/users/neilb/2021/11/addressing-cpan-vulnerabilities-related-to-checksums.html", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/SZ32AJIV4RHJMLWLU5QULGKMMIHYOMDC/", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/SD6RYOJII7HRJ6WVORFNVTYNOFY5JDXN/" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2020-16156",
                "description" : "CPAN 2.28 allows Signature Verification Bypass."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:nginx:nginx:1.23.1-1~bullseye:*:*:*:*:*:*:*" ],
                "name" : "nginx",
                "purl" : "pkg:deb/debian/nginx@1.23.1-1~bullseye?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "1.23.1-1~bullseye",
                "language" : "",
                "licenses" : [ ],
                "locations" : [ {
                    "path" : "/usr/share/doc/nginx/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/nginx.conffiles",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/nginx.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "nginx",
                        "version" : "1.23.1-1~bullseye"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2020-36309",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2020-36309" ],
                "severity" : "Medium",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2020-36309",
                "description" : "ngx_http_lua_module (aka lua-nginx-module) before 0.10.16 in OpenResty allows unsafe characters in an argument when using the API to mutate a URI, or a request or response header."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2020-36309",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:N/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 5,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:L/A:N",
                    "metrics" : {
                        "baseScore" : 5.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://github.com/openresty/lua-nginx-module/compare/v0.10.15...v0.10.16", "https://github.com/openresty/lua-nginx-module/pull/1654", "https://news.ycombinator.com/item?id=26712562", "https://security.netapp.com/advisory/ntap-20210507-0005/" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2020-36309",
                "description" : "ngx_http_lua_module (aka lua-nginx-module) before 0.10.16 in OpenResty allows unsafe characters in an argument when using the API to mutate a URI, or a request or response header."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:curl:curl:7.74.0-1.3+deb11u3:*:*:*:*:*:*:*" ],
                "name" : "curl",
                "purl" : "pkg:deb/debian/curl@7.74.0-1.3+deb11u3?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "7.74.0-1.3+deb11u3",
                "language" : "",
                "licenses" : [ "BSD-3-Clause", "BSD-4-Clause", "ISC", "curl", "other", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/curl/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/curl.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "curl",
                        "version" : "7.74.0-1.3+deb11u3"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-22922",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-22922" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-22922",
                "description" : "When curl is instructed to download content using the metalink feature, thecontents is verified against a hash provided in the metalink XML file.The metalink XML file points out to the client how to get the same contentfrom a set of different URLs, potentially hosted by different servers and theclient can then download the file from one or several of them. In a serial orparallel manner.If one of the servers hosting the contents has been breached and the contentsof the specific file on that server is replaced with a modified payload, curlshould detect this when the hash of the file mismatches after a completeddownload. It should remove the contents and instead try getting the contentsfrom another URL. This is not done, and instead such a hash mismatch is onlymentioned in text and the potentially malicious content is kept in the file ondisk."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-22922",
                "cvss" : [ {
                    "vector" : "AV:N/AC:M/Au:N/C:N/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 4.3,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 8.6
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:N/I:H/A:N",
                    "metrics" : {
                        "baseScore" : 6.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 2.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://hackerone.com/reports/1213175", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/FRUCW2UVNYUDZF72DQLFQR4PJEC6CF7V/", "https://lists.apache.org/thread.html/r61db8e7dcb56dc000a5387a88f7a473bacec5ee01b9ff3f55308aacc@%3Cdev.kafka.apache.org%3E", "https://lists.apache.org/thread.html/r61db8e7dcb56dc000a5387a88f7a473bacec5ee01b9ff3f55308aacc@%3Cusers.kafka.apache.org%3E", "https://lists.apache.org/thread.html/rbf4ce74b0d1fa9810dec50ba3ace0caeea677af7c27a97111c06ccb7@%3Cdev.kafka.apache.org%3E", "https://lists.apache.org/thread.html/rbf4ce74b0d1fa9810dec50ba3ace0caeea677af7c27a97111c06ccb7@%3Cusers.kafka.apache.org%3E", "https://security.netapp.com/advisory/ntap-20210902-0003/", "https://www.oracle.com/security-alerts/cpuoct2021.html", "https://cert-portal.siemens.com/productcert/pdf/ssa-389290.pdf" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-22922",
                "description" : "When curl is instructed to download content using the metalink feature, thecontents is verified against a hash provided in the metalink XML file.The metalink XML file points out to the client how to get the same contentfrom a set of different URLs, potentially hosted by different servers and theclient can then download the file from one or several of them. In a serial orparallel manner.If one of the servers hosting the contents has been breached and the contentsof the specific file on that server is replaced with a modified payload, curlshould detect this when the hash of the file mismatches after a completeddownload. It should remove the contents and instead try getting the contentsfrom another URL. This is not done, and instead such a hash mismatch is onlymentioned in text and the potentially malicious content is kept in the file ondisk."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libcurl4:libcurl4:7.74.0-1.3+deb11u3:*:*:*:*:*:*:*" ],
                "name" : "libcurl4",
                "purl" : "pkg:deb/debian/libcurl4@7.74.0-1.3+deb11u3?arch=amd64&upstream=curl&distro=debian-11",
                "type" : "deb",
                "version" : "7.74.0-1.3+deb11u3",
                "language" : "",
                "licenses" : [ "BSD-3-Clause", "BSD-4-Clause", "ISC", "curl", "other", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libcurl4/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libcurl4:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "curl"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "curl",
                        "version" : "7.74.0-1.3+deb11u3"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-22922",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-22922" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-22922",
                "description" : "When curl is instructed to download content using the metalink feature, thecontents is verified against a hash provided in the metalink XML file.The metalink XML file points out to the client how to get the same contentfrom a set of different URLs, potentially hosted by different servers and theclient can then download the file from one or several of them. In a serial orparallel manner.If one of the servers hosting the contents has been breached and the contentsof the specific file on that server is replaced with a modified payload, curlshould detect this when the hash of the file mismatches after a completeddownload. It should remove the contents and instead try getting the contentsfrom another URL. This is not done, and instead such a hash mismatch is onlymentioned in text and the potentially malicious content is kept in the file ondisk."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-22922",
                "cvss" : [ {
                    "vector" : "AV:N/AC:M/Au:N/C:N/I:P/A:N",
                    "metrics" : {
                        "baseScore" : 4.3,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 8.6
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:N/I:H/A:N",
                    "metrics" : {
                        "baseScore" : 6.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 2.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://hackerone.com/reports/1213175", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/FRUCW2UVNYUDZF72DQLFQR4PJEC6CF7V/", "https://lists.apache.org/thread.html/r61db8e7dcb56dc000a5387a88f7a473bacec5ee01b9ff3f55308aacc@%3Cdev.kafka.apache.org%3E", "https://lists.apache.org/thread.html/r61db8e7dcb56dc000a5387a88f7a473bacec5ee01b9ff3f55308aacc@%3Cusers.kafka.apache.org%3E", "https://lists.apache.org/thread.html/rbf4ce74b0d1fa9810dec50ba3ace0caeea677af7c27a97111c06ccb7@%3Cdev.kafka.apache.org%3E", "https://lists.apache.org/thread.html/rbf4ce74b0d1fa9810dec50ba3ace0caeea677af7c27a97111c06ccb7@%3Cusers.kafka.apache.org%3E", "https://security.netapp.com/advisory/ntap-20210902-0003/", "https://www.oracle.com/security-alerts/cpuoct2021.html", "https://cert-portal.siemens.com/productcert/pdf/ssa-389290.pdf" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-22922",
                "description" : "When curl is instructed to download content using the metalink feature, thecontents is verified against a hash provided in the metalink XML file.The metalink XML file points out to the client how to get the same contentfrom a set of different URLs, potentially hosted by different servers and theclient can then download the file from one or several of them. In a serial orparallel manner.If one of the servers hosting the contents has been breached and the contentsof the specific file on that server is replaced with a modified payload, curlshould detect this when the hash of the file mismatches after a completeddownload. It should remove the contents and instead try getting the contentsfrom another URL. This is not done, and instead such a hash mismatch is onlymentioned in text and the potentially malicious content is kept in the file ondisk."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:curl:curl:7.74.0-1.3+deb11u3:*:*:*:*:*:*:*" ],
                "name" : "curl",
                "purl" : "pkg:deb/debian/curl@7.74.0-1.3+deb11u3?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "7.74.0-1.3+deb11u3",
                "language" : "",
                "licenses" : [ "BSD-3-Clause", "BSD-4-Clause", "ISC", "curl", "other", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/curl/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/curl.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "curl",
                        "version" : "7.74.0-1.3+deb11u3"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-22923",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-22923" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-22923",
                "description" : "When curl is instructed to get content using the metalink feature, and a user name and password are used to download the metalink XML file, those same credentials are then subsequently passed on to each of the servers from which curl will download or try to download the contents from. Often contrary to the user's expectations and intentions and without telling the user it happened."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-22923",
                "cvss" : [ {
                    "vector" : "AV:N/AC:H/Au:N/C:P/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 2.6,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 4.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:U/C:H/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 5.3,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 1.6
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://hackerone.com/reports/1213181", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/FRUCW2UVNYUDZF72DQLFQR4PJEC6CF7V/", "https://security.netapp.com/advisory/ntap-20210902-0003/", "https://www.oracle.com/security-alerts/cpuoct2021.html", "https://cert-portal.siemens.com/productcert/pdf/ssa-389290.pdf" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-22923",
                "description" : "When curl is instructed to get content using the metalink feature, and a user name and password are used to download the metalink XML file, those same credentials are then subsequently passed on to each of the servers from which curl will download or try to download the contents from. Often contrary to the user's expectations and intentions and without telling the user it happened."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libcurl4:libcurl4:7.74.0-1.3+deb11u3:*:*:*:*:*:*:*" ],
                "name" : "libcurl4",
                "purl" : "pkg:deb/debian/libcurl4@7.74.0-1.3+deb11u3?arch=amd64&upstream=curl&distro=debian-11",
                "type" : "deb",
                "version" : "7.74.0-1.3+deb11u3",
                "language" : "",
                "licenses" : [ "BSD-3-Clause", "BSD-4-Clause", "ISC", "curl", "other", "public-domain" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libcurl4/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libcurl4:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "curl"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "curl",
                        "version" : "7.74.0-1.3+deb11u3"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-22923",
                "fix" : {
                    "state" : "not-fixed",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-22923" ],
                "severity" : "Negligible",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-22923",
                "description" : "When curl is instructed to get content using the metalink feature, and a user name and password are used to download the metalink XML file, those same credentials are then subsequently passed on to each of the servers from which curl will download or try to download the contents from. Often contrary to the user's expectations and intentions and without telling the user it happened."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-22923",
                "cvss" : [ {
                    "vector" : "AV:N/AC:H/Au:N/C:P/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 2.6,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 4.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:U/C:H/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 5.3,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 1.6
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://hackerone.com/reports/1213181", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/FRUCW2UVNYUDZF72DQLFQR4PJEC6CF7V/", "https://security.netapp.com/advisory/ntap-20210902-0003/", "https://www.oracle.com/security-alerts/cpuoct2021.html", "https://cert-portal.siemens.com/productcert/pdf/ssa-389290.pdf" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-22923",
                "description" : "When curl is instructed to get content using the metalink feature, and a user name and password are used to download the metalink XML file, those same credentials are then subsequently passed on to each of the servers from which curl will download or try to download the contents from. Often contrary to the user's expectations and intentions and without telling the user it happened."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libgcrypt20:libgcrypt20:1.8.7-6:*:*:*:*:*:*:*" ],
                "name" : "libgcrypt20",
                "purl" : "pkg:deb/debian/libgcrypt20@1.8.7-6?arch=amd64&distro=debian-11",
                "type" : "deb",
                "version" : "1.8.7-6",
                "language" : "",
                "licenses" : [ "GPL-2", "LGPL" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libgcrypt20/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libgcrypt20:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ ]
            },
            "matchDetails" : [ {
                "type" : "exact-direct-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libgcrypt20",
                        "version" : "1.8.7-6"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-33560",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-33560" ],
                "severity" : "High",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-33560",
                "description" : "Libgcrypt before 1.8.8 and 1.9.x before 1.9.3 mishandles ElGamal encryption because it lacks exponent blinding to address a side-channel attack against mpi_powm, and the window size is not chosen appropriately. This, for example, affects use of ElGamal in OpenPGP."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-33560",
                "cvss" : [ {
                    "vector" : "AV:N/AC:L/Au:N/C:P/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 5,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 10
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N",
                    "metrics" : {
                        "baseScore" : 7.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://dev.gnupg.org/T5466", "https://dev.gnupg.org/rCe8b7f10be275bcedb5fc05ed4837a89bfd605c61", "https://dev.gnupg.org/T5305", "https://dev.gnupg.org/T5328", "https://lists.debian.org/debian-lts-announce/2021/06/msg00021.html", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/R7OAPCUGPF3VLA7QAJUQSL255D4ITVTL/", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/BKKTOIGFW2SGN3DO2UHHVZ7MJSYN4AAB/", "https://www.oracle.com/security-alerts/cpuoct2021.html", "https://www.oracle.com/security-alerts/cpujan2022.html", "https://www.oracle.com/security-alerts/cpuapr2022.html", "https://www.oracle.com/security-alerts/cpujul2022.html" ],
                "severity" : "High",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-33560",
                "description" : "Libgcrypt before 1.8.8 and 1.9.x before 1.9.3 mishandles ElGamal encryption because it lacks exponent blinding to address a side-channel attack against mpi_powm, and the window size is not chosen appropriately. This, for example, affects use of ElGamal in OpenPGP."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libsepol1:libsepol1:3.1-1:*:*:*:*:*:*:*" ],
                "name" : "libsepol1",
                "purl" : "pkg:deb/debian/libsepol1@3.1-1?arch=amd64&upstream=libsepol&distro=debian-11",
                "type" : "deb",
                "version" : "3.1-1",
                "language" : "",
                "licenses" : [ "GPL", "LGPL" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libsepol1/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libsepol1:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libsepol"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libsepol",
                        "version" : "3.1-1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-36084",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-36084" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-36084",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in __cil_verify_classperms (called from __cil_verify_classpermission and __cil_pre_verify_helper)."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-36084",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:N/UI:R/S:U/C:N/I:N/A:L",
                    "metrics" : {
                        "baseScore" : 3.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=31065", "https://github.com/google/oss-fuzz-vulns/blob/main/vulns/selinux/OSV-2021-417.yaml", "https://github.com/SELinuxProject/selinux/commit/f34d3d30c8325e4847a6b696fe7a3936a8a361f3", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/U7ZYR3PIJ75N6U2IONJWCKZ5L2NKJTGR/" ],
                "severity" : "Low",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-36084",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in __cil_verify_classperms (called from __cil_verify_classpermission and __cil_pre_verify_helper)."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libsepol1:libsepol1:3.1-1:*:*:*:*:*:*:*" ],
                "name" : "libsepol1",
                "purl" : "pkg:deb/debian/libsepol1@3.1-1?arch=amd64&upstream=libsepol&distro=debian-11",
                "type" : "deb",
                "version" : "3.1-1",
                "language" : "",
                "licenses" : [ "GPL", "LGPL" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libsepol1/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libsepol1:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libsepol"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libsepol",
                        "version" : "3.1-1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-36085",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-36085" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-36085",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in __cil_verify_classperms (called from __verify_map_perm_classperms and hashtab_map)."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-36085",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:N/A:L",
                    "metrics" : {
                        "baseScore" : 3.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://github.com/google/oss-fuzz-vulns/blob/main/vulns/selinux/OSV-2021-421.yaml", "https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=31124", "https://github.com/SELinuxProject/selinux/commit/2d35fcc7e9e976a2346b1de20e54f8663e8a6cba", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/U7ZYR3PIJ75N6U2IONJWCKZ5L2NKJTGR/" ],
                "severity" : "Low",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-36085",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in __cil_verify_classperms (called from __verify_map_perm_classperms and hashtab_map)."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libsepol1:libsepol1:3.1-1:*:*:*:*:*:*:*" ],
                "name" : "libsepol1",
                "purl" : "pkg:deb/debian/libsepol1@3.1-1?arch=amd64&upstream=libsepol&distro=debian-11",
                "type" : "deb",
                "version" : "3.1-1",
                "language" : "",
                "licenses" : [ "GPL", "LGPL" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libsepol1/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libsepol1:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libsepol"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libsepol",
                        "version" : "3.1-1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-36086",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-36086" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-36086",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in cil_reset_classpermission (called from cil_reset_classperms_set and cil_reset_classperms_list)."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-36086",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:N/A:L",
                    "metrics" : {
                        "baseScore" : 3.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=32177", "https://github.com/google/oss-fuzz-vulns/blob/main/vulns/selinux/OSV-2021-536.yaml", "https://github.com/SELinuxProject/selinux/commit/c49a8ea09501ad66e799ea41b8154b6770fec2c8", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/U7ZYR3PIJ75N6U2IONJWCKZ5L2NKJTGR/" ],
                "severity" : "Low",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-36086",
                "description" : "The CIL compiler in SELinux 3.2 has a use-after-free in cil_reset_classpermission (called from cil_reset_classperms_set and cil_reset_classperms_list)."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libsepol1:libsepol1:3.1-1:*:*:*:*:*:*:*" ],
                "name" : "libsepol1",
                "purl" : "pkg:deb/debian/libsepol1@3.1-1?arch=amd64&upstream=libsepol&distro=debian-11",
                "type" : "deb",
                "version" : "3.1-1",
                "language" : "",
                "licenses" : [ "GPL", "LGPL" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libsepol1/copyright",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/info/libsepol1:amd64.md5sums",
                    "layerID" : "sha256:fe7b1e9bf7922fbc22281bcc6b4f5ac8f1a7b4278929880940978c42fc9d0229"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libsepol"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libsepol",
                        "version" : "3.1-1"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-36087",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-36087" ],
                "severity" : "Low",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-36087",
                "description" : "The CIL compiler in SELinux 3.2 has a heap-based buffer over-read in ebitmap_match_any (called indirectly from cil_check_neverallow). This occurs because there is sometimes a lack of checks for invalid statements in an optional block."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-36087",
                "cvss" : [ {
                    "vector" : "AV:L/AC:L/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 2.1,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 3.9
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:N/A:L",
                    "metrics" : {
                        "baseScore" : 3.3,
                        "impactScore" : 1.4,
                        "exploitabilityScore" : 1.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://github.com/google/oss-fuzz-vulns/blob/main/vulns/selinux/OSV-2021-585.yaml", "https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=32675", "https://lore.kernel.org/selinux/CAEN2sdqJKHvDzPnxS-J8grU8fSf32DDtx=kyh84OsCq_Vm+yaQ@mail.gmail.com/T/", "https://github.com/SELinuxProject/selinux/commit/340f0eb7f3673e8aacaf0a96cbfcd4d12a405521", "https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/U7ZYR3PIJ75N6U2IONJWCKZ5L2NKJTGR/" ],
                "severity" : "Low",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-36087",
                "description" : "The CIL compiler in SELinux 3.2 has a heap-based buffer over-read in ebitmap_match_any (called indirectly from cil_check_neverallow). This occurs because there is sometimes a lack of checks for invalid statements in an optional block."
            } ]
        }, {
            "artifact" : {
                "cpes" : [ "cpe:2.3:a:libgd3:libgd3:2.3.0-2:*:*:*:*:*:*:*" ],
                "name" : "libgd3",
                "purl" : "pkg:deb/debian/libgd3@2.3.0-2?arch=amd64&upstream=libgd2&distro=debian-11",
                "type" : "deb",
                "version" : "2.3.0-2",
                "language" : "",
                "licenses" : [ "BSD-3-clause", "GAP~Makefile.in", "GAP~configure", "GD", "GPL-2", "GPL-2+", "HPND", "MIT", "WEBP", "XFIG" ],
                "locations" : [ {
                    "path" : "/usr/share/doc/libgd3/copyright",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/info/libgd3:amd64.md5sums",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                }, {
                    "path" : "/var/lib/dpkg/status",
                    "layerID" : "sha256:58a06a0d345c56af21bae2c06c4072837a88f9b5c89bb903515597657b9bc2c9"
                } ],
                "upstreams" : [ {
                    "name" : "libgd2"
                } ]
            },
            "matchDetails" : [ {
                "type" : "exact-indirect-match",
                "found" : {
                    "versionConstraint" : "none (deb)"
                },
                "matcher" : "dpkg-matcher",
                "searchedBy" : {
                    "distro" : {
                        "type" : "debian",
                        "version" : "11"
                    },
                    "package" : {
                        "name" : "libgd2",
                        "version" : "2.3.0-2"
                    },
                    "namespace" : "debian:distro:debian:11"
                }
            } ],
            "vulnerability" : {
                "id" : "CVE-2021-38115",
                "fix" : {
                    "state" : "wont-fix",
                    "versions" : [ ]
                },
                "cvss" : [ ],
                "urls" : [ "https://security-tracker.debian.org/tracker/CVE-2021-38115" ],
                "severity" : "Medium",
                "namespace" : "debian:distro:debian:11",
                "advisories" : [ ],
                "dataSource" : "https://security-tracker.debian.org/tracker/CVE-2021-38115",
                "description" : "read_header_tga in gd_tga.c in the GD Graphics Library (aka LibGD) through 2.3.2 allows remote attackers to cause a denial of service (out-of-bounds read) via a crafted TGA file."
            },
            "relatedVulnerabilities" : [ {
                "id" : "CVE-2021-38115",
                "cvss" : [ {
                    "vector" : "AV:N/AC:M/Au:N/C:N/I:N/A:P",
                    "metrics" : {
                        "baseScore" : 4.3,
                        "impactScore" : 2.9,
                        "exploitabilityScore" : 8.6
                    },
                    "version" : "2.0",
                    "vendorMetadata" : { }
                }, {
                    "vector" : "CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:N/I:N/A:H",
                    "metrics" : {
                        "baseScore" : 6.5,
                        "impactScore" : 3.6,
                        "exploitabilityScore" : 2.8
                    },
                    "version" : "3.1",
                    "vendorMetadata" : { }
                } ],
                "urls" : [ "https://github.com/libgd/libgd/pull/711/commits/8b111b2b4a4842179be66db68d84dda91a246032", "https://github.com/libgd/libgd/issues/697" ],
                "severity" : "Medium",
                "namespace" : "nvd:cpe",
                "dataSource" : "https://nvd.nist.gov/vuln/detail/CVE-2021-38115",
                "description" : "read_header_tga in gd_tga.c in the GD Graphics Library (aka LibGD) through 2.3.2 allows remote attackers to cause a denial of service (out-of-bounds read) via a crafted TGA file."
            } ]
        }]
    });
end;

main();
