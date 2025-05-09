### Data Search and Extraction: Software Bill of Materials

# Examples of data extraction from nested data structures. The structure is
# a SBOM (Software Bill of Materials) file 

function main()
    bom := readData();
    println("\n* List of all artifacts with their versions");
    bom.artifacts
    | fields name, version
    | println();

    println("\n* List of all artifacts with BSD licenses");
    bom.artifacts
    # use subsearch on list of license names and save BSD ones them in a new field
    # fixme: why do we need () around `:=` ?
    | search (_.bsd_lics:=licenses search  r"BSD")
    | fields name, version, bsd_lics
    | println();

    println("\n* List of all licenses used");
    # FIXME: add more friendly way to filter non-unique results (like sort() | uniq() )
    bom.artifacts[]["licenses"] | append | hashset
    | println;

    
    println("\n* Check if there is a specific file");
    bom.files
    | search location.path == "/bin/busybox"
    # convert to boolean, retuens true for non-empty result
    | bool()
    | println();

    println("\n* List of all files in /etc/");
    bom.files[]["location"]["path"]
    | search r"^/etc"
    | println();

end;


function readData()
    return (
        {
            "artifacts": [
                {
                    "id": "d152144d8060d0c2",
                    "name": "alpine-baselayout",
                    "version": "3.2.0-r23",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:alpine-baselayout:alpine-baselayout:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine-baselayout:alpine_baselayout:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout:alpine-baselayout:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout:alpine_baselayout:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine-baselayout:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine_baselayout:3.2.0-r23:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/alpine-baselayout@3.2.0-r23?arch=x86_64&upstream=alpine-baselayout&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "alpine-baselayout",
                        "originPackage": "alpine-baselayout",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "3.2.0-r23",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://git.alpinelinux.org/cgit/aports/tree/main/alpine-baselayout",
                        "description": "Alpine base dir structure and init scripts",
                        "size": 11136,
                        "installedSize": 348160,
                        "pullDependencies": "alpine-baselayout-data=3.2.0-r23 /bin/sh so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q19UI7UxyiUywG6aew9c3lCBPshsE=",
                        "gitCommitOfApkPort": "348653a9ba0701e8e968b3344e72313a9ef334e4",
                        "files": [
                            {
                                "path": "/dev"
                            },
                            {
                                "path": "/dev/pts"
                            },
                            {
                                "path": "/dev/shm"
                            },
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/motd",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1XmduVVNURHQ27TvYp1Lr5TMtFcA="
                                }
                            },
                            {
                                "path": "/etc/apk"
                            },
                            {
                                "path": "/etc/conf.d"
                            },
                            {
                                "path": "/etc/crontabs"
                            },
                            {
                                "path": "/etc/crontabs/root",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "600",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1vfk1apUWI4yLJGhhNRd0kJixfvY="
                                }
                            },
                            {
                                "path": "/etc/init.d"
                            },
                            {
                                "path": "/etc/modprobe.d"
                            },
                            {
                                "path": "/etc/modprobe.d/aliases.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1WUbh6TBYNVK7e4Y+uUvLs/7viqk="
                                }
                            },
                            {
                                "path": "/etc/modprobe.d/blacklist.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q14TdgFHkTdt3uQC+NBtrntOnm9n4="
                                }
                            },
                            {
                                "path": "/etc/modprobe.d/i386.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1pnay/njn6ol9cCssL7KiZZ8etlc="
                                }
                            },
                            {
                                "path": "/etc/modprobe.d/kms.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1ynbLn3GYDpvajba/ldp1niayeog="
                                }
                            },
                            {
                                "path": "/etc/modules-load.d"
                            },
                            {
                                "path": "/etc/network"
                            },
                            {
                                "path": "/etc/network/if-down.d"
                            },
                            {
                                "path": "/etc/network/if-post-down.d"
                            },
                            {
                                "path": "/etc/network/if-pre-up.d"
                            },
                            {
                                "path": "/etc/network/if-up.d"
                            },
                            {
                                "path": "/etc/opt"
                            },
                            {
                                "path": "/etc/periodic"
                            },
                            {
                                "path": "/etc/periodic/15min"
                            },
                            {
                                "path": "/etc/periodic/daily"
                            },
                            {
                                "path": "/etc/periodic/hourly"
                            },
                            {
                                "path": "/etc/periodic/monthly"
                            },
                            {
                                "path": "/etc/periodic/weekly"
                            },
                            {
                                "path": "/etc/profile.d"
                            },
                            {
                                "path": "/etc/profile.d/README",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q135OWsCzzvnB2fmFx62kbqm1Ax1k="
                                }
                            },
                            {
                                "path": "/etc/profile.d/color_prompt.sh.disabled",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q11XM9mde1Z29tWMGaOkeovD/m4uU="
                                }
                            },
                            {
                                "path": "/etc/profile.d/locale.sh",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1S8j+WW71mWxfVy8ythqU7HUVoBw="
                                }
                            },
                            {
                                "path": "/etc/sysctl.d"
                            },
                            {
                                "path": "/home"
                            },
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/firmware"
                            },
                            {
                                "path": "/lib/mdev"
                            },
                            {
                                "path": "/lib/modules-load.d"
                            },
                            {
                                "path": "/lib/sysctl.d"
                            },
                            {
                                "path": "/lib/sysctl.d/00-alpine.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1HpElzW1xEgmKfERtTy7oommnq6c="
                                }
                            },
                            {
                                "path": "/media"
                            },
                            {
                                "path": "/media/cdrom"
                            },
                            {
                                "path": "/media/floppy"
                            },
                            {
                                "path": "/media/usb"
                            },
                            {
                                "path": "/mnt"
                            },
                            {
                                "path": "/opt"
                            },
                            {
                                "path": "/proc"
                            },
                            {
                                "path": "/root",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "700"
                            },
                            {
                                "path": "/run"
                            },
                            {
                                "path": "/sbin"
                            },
                            {
                                "path": "/sbin/mkmntdirs",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1+f8Hjd+dkHS03O6ZZaIw7mb8nLM="
                                }
                            },
                            {
                                "path": "/srv"
                            },
                            {
                                "path": "/sys"
                            },
                            {
                                "path": "/tmp",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "1777"
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/lib"
                            },
                            {
                                "path": "/usr/lib/modules-load.d"
                            },
                            {
                                "path": "/usr/local"
                            },
                            {
                                "path": "/usr/local/bin"
                            },
                            {
                                "path": "/usr/local/lib"
                            },
                            {
                                "path": "/usr/local/share"
                            },
                            {
                                "path": "/usr/sbin"
                            },
                            {
                                "path": "/usr/share"
                            },
                            {
                                "path": "/usr/share/man"
                            },
                            {
                                "path": "/usr/share/misc"
                            },
                            {
                                "path": "/var"
                            },
                            {
                                "path": "/var/run",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q11/SNZz/8cK2dSKK+cJpVrZIuF4Q="
                                }
                            },
                            {
                                "path": "/var/cache"
                            },
                            {
                                "path": "/var/cache/misc"
                            },
                            {
                                "path": "/var/empty",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "555"
                            },
                            {
                                "path": "/var/lib"
                            },
                            {
                                "path": "/var/lib/misc"
                            },
                            {
                                "path": "/var/local"
                            },
                            {
                                "path": "/var/lock"
                            },
                            {
                                "path": "/var/lock/subsys"
                            },
                            {
                                "path": "/var/log"
                            },
                            {
                                "path": "/var/mail"
                            },
                            {
                                "path": "/var/opt"
                            },
                            {
                                "path": "/var/spool"
                            },
                            {
                                "path": "/var/spool/mail",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1dzbdazYZA2nTzSIG3YyNw7d4Juc="
                                }
                            },
                            {
                                "path": "/var/spool/cron"
                            },
                            {
                                "path": "/var/spool/cron/crontabs",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1OFZt+ZMp7j0Gny0rqSKuWJyqYmA="
                                }
                            },
                            {
                                "path": "/var/tmp",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "1777"
                            }
                        ]
                    }
                },
                {
                    "id": "59eadcf6a622022c",
                    "name": "alpine-baselayout-data",
                    "version": "3.2.0-r23",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:alpine-baselayout-data:alpine-baselayout-data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine-baselayout-data:alpine_baselayout_data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout_data:alpine-baselayout-data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout_data:alpine_baselayout_data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine-baselayout:alpine-baselayout-data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine-baselayout:alpine_baselayout_data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout:alpine-baselayout-data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_baselayout:alpine_baselayout_data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine-baselayout-data:3.2.0-r23:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine_baselayout_data:3.2.0-r23:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/alpine-baselayout-data@3.2.0-r23?arch=x86_64&upstream=alpine-baselayout&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "alpine-baselayout-data",
                        "originPackage": "alpine-baselayout",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "3.2.0-r23",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://git.alpinelinux.org/cgit/aports/tree/main/alpine-baselayout",
                        "description": "Alpine base dir structure and init scripts",
                        "size": 11655,
                        "installedSize": 77824,
                        "pullDependencies": "",
                        "pullChecksum": "Q1d4HQ/Gyfw7NRD1qRvOgS6IzT2sI=",
                        "gitCommitOfApkPort": "348653a9ba0701e8e968b3344e72313a9ef334e4",
                        "files": [
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/fstab",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q11Q7hNe8QpDS531guqCdrXBzoA/o="
                                }
                            },
                            {
                                "path": "/etc/group",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q13K+olJg5ayzHSVNUkggZJXuB+9Y="
                                }
                            },
                            {
                                "path": "/etc/hostname",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q16nVwYVXP/tChvUPdukVD2ifXOmc="
                                }
                            },
                            {
                                "path": "/etc/hosts",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1BD6zJKZTRWyqGnPi4tSfd3krsMU="
                                }
                            },
                            {
                                "path": "/etc/inittab",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1TsthbhW7QzWRe1E/NKwTOuD4pHc="
                                }
                            },
                            {
                                "path": "/etc/modules",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1toogjUipHGcMgECgPJX64SwUT1M="
                                }
                            },
                            {
                                "path": "/etc/mtab",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1kiljhXXH1LlQroHsEJIkPZg2eiw="
                                }
                            },
                            {
                                "path": "/etc/nsswitch.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q19DBsMnv0R2fajaTjoTv0C91NOqo="
                                }
                            },
                            {
                                "path": "/etc/passwd",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1TchuuLUfur0izvfZQZxgN/LJhB8="
                                }
                            },
                            {
                                "path": "/etc/profile",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1F3DgXUP+jNZDknmQPPb5t9FSfDg="
                                }
                            },
                            {
                                "path": "/etc/protocols",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1omKlp3vgGq2ZqYzyD/KHNdo8rDc="
                                }
                            },
                            {
                                "path": "/etc/services",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q19WLCv5ItKg4MH7RWfNRh1I7byQc="
                                }
                            },
                            {
                                "path": "/etc/shadow",
                                "ownerUid": "0",
                                "ownerGid": "42",
                                "permissions": "640",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1ltrPIAW2zHeDiajsex2Bdmq3uqA="
                                }
                            },
                            {
                                "path": "/etc/shells",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1ojm2YdpCJ6B/apGDaZ/Sdb2xJkA="
                                }
                            },
                            {
                                "path": "/etc/sysctl.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q14upz3tfnNxZkIEsUhWn7Xoiw96g="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "3f53edc3b14056c3",
                    "name": "alpine-keys",
                    "version": "2.4-r1",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "MIT"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:alpine-keys:alpine-keys:2.4-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine-keys:alpine_keys:2.4-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_keys:alpine-keys:2.4-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine_keys:alpine_keys:2.4-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine-keys:2.4-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:alpine:alpine_keys:2.4-r1:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/alpine-keys@2.4-r1?arch=x86_64&upstream=alpine-keys&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "alpine-keys",
                        "originPackage": "alpine-keys",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "2.4-r1",
                        "license": "MIT",
                        "architecture": "x86_64",
                        "url": "https://alpinelinux.org",
                        "description": "Public keys for Alpine Linux packages",
                        "size": 13359,
                        "installedSize": 159744,
                        "pullDependencies": "",
                        "pullChecksum": "Q1FBfIjtsEmvuqoNXpShXDcm/mjzE=",
                        "gitCommitOfApkPort": "aab68f8c9ab434a46710de8e12fb3206e2930a59",
                        "files": [
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/apk"
                            },
                            {
                                "path": "/etc/apk/keys"
                            },
                            {
                                "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1OvCFSO94z97c80mIDCxqGkh2Og4="
                                }
                            },
                            {
                                "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1v7YWZYzAWoclaLDI45jEguI7YN0="
                                }
                            },
                            {
                                "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1NnGuDsdQOx4ZNYfB3N97eLyGPkI="
                                }
                            },
                            {
                                "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1lZlTESNrelWTNkL/oQzmAU8a99A="
                                }
                            },
                            {
                                "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1WNW6Sy87HpJ3IdemQy8pju33Kms="
                                }
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/share"
                            },
                            {
                                "path": "/usr/share/apk"
                            },
                            {
                                "path": "/usr/share/apk/keys"
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1OvCFSO94z97c80mIDCxqGkh2Og4="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1v7YWZYzAWoclaLDI45jEguI7YN0="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1BTqS+H/UUyhQuzHwiBl47+BTKuU="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1NnGuDsdQOx4ZNYfB3N97eLyGPkI="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58199dcc.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Oaxdcsa6AYoPdLi0U4lO3J2we18="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58cbb476.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1yPq+su65ksNox3uXB+DR7P18+QU="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58e4f17d.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1MpZDNX0LeLHvSOwVUyXiXx11NN0="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5e69ca50.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1glCQ/eJbvA5xqcswdjFrWv5Fnk0="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-60ac2099.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1XUdDEoNTtjlvrS+iunk6ziFgIpU="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1lZlTESNrelWTNkL/oQzmAU8a99A="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1WNW6Sy87HpJ3IdemQy8pju33Kms="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616a9724.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1I9Dy6hryacL2YWXg+KlE6WvwEd4="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616abc23.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1NSnsgmcMbU4g7j5JaNs0tVHpHVA="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616ac3bc.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1VaMBBk4Rxv6boPLKF+I085Q8y2E="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616adfeb.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q13hJBMHAUquPbp5jpAPFjQI2Y1vQ="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616ae350.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1V/a5P9pKRJb6tihE3e8O6xaPgLU="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616db30d.rsa.pub",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q13wLJrcKQajql5a1p9Q45U+ZXENA="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/aarch64"
                            },
                            {
                                "path": "/usr/share/apk/keys/aarch64/alpine-devel@lists.alpinelinux.org-58199dcc.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q17j9nWJkQ+wfIuVQzIFrmFZ7fSOc="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/aarch64/alpine-devel@lists.alpinelinux.org-616ae350.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1snr+Q1UbfHyCr/cmmtVvMIS7SGs="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/armhf"
                            },
                            {
                                "path": "/usr/share/apk/keys/armhf/alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1U9QtsdN+rYZ9Zh76EfXy00JZHMg="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/armhf/alpine-devel@lists.alpinelinux.org-616a9724.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1bC+AdQ0qWBTmefXiI0PvmYOJoVQ="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/armv7"
                            },
                            {
                                "path": "/usr/share/apk/keys/armv7/alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1U9QtsdN+rYZ9Zh76EfXy00JZHMg="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/armv7/alpine-devel@lists.alpinelinux.org-616adfeb.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1xbIVu7ScwqGHxXGwI22aSe5OdUY="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/mips64"
                            },
                            {
                                "path": "/usr/share/apk/keys/mips64/alpine-devel@lists.alpinelinux.org-5e69ca50.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1hCZdFx+LvzbLtPs753je78gEEBQ="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/ppc64le"
                            },
                            {
                                "path": "/usr/share/apk/keys/ppc64le/alpine-devel@lists.alpinelinux.org-58cbb476.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1t21dhCLbTJmAHXSCeOMq/2vfSgo="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/ppc64le/alpine-devel@lists.alpinelinux.org-616abc23.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1PS9zNIPJanC8qcsc5qarEWqhV5Q="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/riscv64"
                            },
                            {
                                "path": "/usr/share/apk/keys/riscv64/alpine-devel@lists.alpinelinux.org-60ac2099.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1NVPbZavaXpsItFwQYDWbpor7yYE="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/riscv64/alpine-devel@lists.alpinelinux.org-616db30d.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1U6tfuKRy5J8C6iaKPMZaT/e8tbA="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/s390x"
                            },
                            {
                                "path": "/usr/share/apk/keys/s390x/alpine-devel@lists.alpinelinux.org-58e4f17d.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1sjbV2r2w0Ih2vwdzC4Jq6UI7cMQ="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/s390x/alpine-devel@lists.alpinelinux.org-616ac3bc.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1l09xa7RnbOIC1dI9FqbaCfS/GXY="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86"
                            },
                            {
                                "path": "/usr/share/apk/keys/x86/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Ii51i7Nrc4uft14HhqugaUqdH64="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86/alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Y49eVxhpvftbQ3yAdvlLfcrPLTU="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86/alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1HjdvcVkpBZzr1aSe3p7oQfAtm/E="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86_64"
                            },
                            {
                                "path": "/usr/share/apk/keys/x86_64/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Ii51i7Nrc4uft14HhqugaUqdH64="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86_64/alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1AUFY+fwSBTcrYetjT7NHvafrSQc="
                                }
                            },
                            {
                                "path": "/usr/share/apk/keys/x86_64/alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1qKA23VzMUDle+Dqnrr5Kz+Xvty4="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "9bb9cb82a4ce72b1",
                    "name": "apk-tools",
                    "version": "2.12.9-r3",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:apk-tools:apk-tools:2.12.9-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:apk-tools:apk_tools:2.12.9-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:apk_tools:apk-tools:2.12.9-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:apk_tools:apk_tools:2.12.9-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:apk:apk-tools:2.12.9-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:apk:apk_tools:2.12.9-r3:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/apk-tools@2.12.9-r3?arch=x86_64&upstream=apk-tools&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "apk-tools",
                        "originPackage": "apk-tools",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "2.12.9-r3",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://gitlab.alpinelinux.org/alpine/apk-tools",
                        "description": "Alpine Package Keeper - package manager for alpine",
                        "size": 120745,
                        "installedSize": 307200,
                        "pullDependencies": "musl>=1.2 ca-certificates-bundle so:libc.musl-x86_64.so.1 so:libcrypto.so.1.1 so:libssl.so.1.1 so:libz.so.1",
                        "pullChecksum": "Q1VFFFWMKjB9aRkehIATc5kwgAhlU=",
                        "gitCommitOfApkPort": "34d90ac8388e88126893f5d27ea35d304e65e5ab",
                        "files": [
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/apk"
                            },
                            {
                                "path": "/etc/apk/keys"
                            },
                            {
                                "path": "/etc/apk/protected_paths.d"
                            },
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/libapk.so.3.12.0",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1kVeagJvcGMIKp8ijGOxaZD08ONs="
                                }
                            },
                            {
                                "path": "/sbin"
                            },
                            {
                                "path": "/sbin/apk",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1P1oUBG/VMMhnndf2fBXsZXBjHVE="
                                }
                            },
                            {
                                "path": "/var"
                            },
                            {
                                "path": "/var/cache"
                            },
                            {
                                "path": "/var/cache/misc"
                            },
                            {
                                "path": "/var/lib"
                            },
                            {
                                "path": "/var/lib/apk"
                            }
                        ]
                    }
                },
                {
                    "id": "2bc2db5bac1d0fe4",
                    "name": "busybox",
                    "version": "1.35.0-r17",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:busybox:busybox:1.35.0-r17:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/busybox@1.35.0-r17?arch=x86_64&upstream=busybox&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "busybox",
                        "originPackage": "busybox",
                        "maintainer": "Sören Tempel <soeren+alpine@soeren-tempel.net>",
                        "version": "1.35.0-r17",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://busybox.net/",
                        "description": "Size optimized toolbox of many common UNIX utilities",
                        "size": 507831,
                        "installedSize": 962560,
                        "pullDependencies": "so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q1iZ+C2JJdBlm2KKtAOkSkM7zZegY=",
                        "gitCommitOfApkPort": "2bf6ec48e526113f87216683cd341a78af5f0b3f",
                        "files": [
                            {
                                "path": "/bin"
                            },
                            {
                                "path": "/bin/busybox",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1WUwBY0eOGgzgVxTZxJBZPyQUicI="
                                }
                            },
                            {
                                "path": "/bin/sh",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1pcfTfDNEbNKQc2s1tia7da05M8Q="
                                }
                            },
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/securetty",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1mB95Hq2NUTZ599RDiSsj9w5FrOU="
                                }
                            },
                            {
                                "path": "/etc/udhcpd.conf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1EgLFjj67ou3eMqp4m3r2ZjnQ7QU="
                                }
                            },
                            {
                                "path": "/etc/logrotate.d"
                            },
                            {
                                "path": "/etc/logrotate.d/acpid",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1TylyCINVmnS+A/Tead4vZhE7Bks="
                                }
                            },
                            {
                                "path": "/etc/network"
                            },
                            {
                                "path": "/etc/network/if-down.d"
                            },
                            {
                                "path": "/etc/network/if-post-down.d"
                            },
                            {
                                "path": "/etc/network/if-post-up.d"
                            },
                            {
                                "path": "/etc/network/if-pre-down.d"
                            },
                            {
                                "path": "/etc/network/if-pre-up.d"
                            },
                            {
                                "path": "/etc/network/if-up.d"
                            },
                            {
                                "path": "/etc/network/if-up.d/dad",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "775",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1ORf+lPRKuYgdkBBcKoevR1t60Q4="
                                }
                            },
                            {
                                "path": "/sbin"
                            },
                            {
                                "path": "/tmp",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "1777"
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/sbin"
                            },
                            {
                                "path": "/usr/share"
                            },
                            {
                                "path": "/usr/share/udhcpc"
                            },
                            {
                                "path": "/usr/share/udhcpc/default.script",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1t9vir/ZrX3nbSIYT9BDLWZenkVQ="
                                }
                            },
                            {
                                "path": "/var"
                            },
                            {
                                "path": "/var/cache"
                            },
                            {
                                "path": "/var/cache/misc"
                            },
                            {
                                "path": "/var/lib"
                            },
                            {
                                "path": "/var/lib/udhcpd"
                            }
                        ]
                    }
                },
                {
                    "id": "3ff09d7a5e0dc2ed",
                    "name": "ca-certificates-bundle",
                    "version": "20220614-r0",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "MPL-2.0",
                        "AND",
                        "MIT"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:ca-certificates-bundle:ca-certificates-bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca-certificates-bundle:ca_certificates_bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca_certificates_bundle:ca-certificates-bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca_certificates_bundle:ca_certificates_bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca-certificates:ca-certificates-bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca-certificates:ca_certificates_bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca_certificates:ca-certificates-bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca_certificates:ca_certificates_bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca:ca-certificates-bundle:20220614-r0:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ca:ca_certificates_bundle:20220614-r0:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/ca-certificates-bundle@20220614-r0?arch=x86_64&upstream=ca-certificates&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "ca-certificates-bundle",
                        "originPackage": "ca-certificates",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "20220614-r0",
                        "license": "MPL-2.0 AND MIT",
                        "architecture": "x86_64",
                        "url": "https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/",
                        "description": "Pre generated bundle of Mozilla certificates",
                        "size": 125920,
                        "installedSize": 233472,
                        "pullDependencies": "",
                        "pullChecksum": "Q1huqjigIP7ZNHBueDUmNnT6PpToI=",
                        "gitCommitOfApkPort": "bb51fa7743320ac61f76e181cca84daa9977573e",
                        "files": [
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/ssl"
                            },
                            {
                                "path": "/etc/ssl/cert.pem",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Nj6gTBdkZpTFW/obJGdpfvK0StA="
                                }
                            },
                            {
                                "path": "/etc/ssl/certs"
                            },
                            {
                                "path": "/etc/ssl/certs/ca-certificates.crt",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1D8ljYj7pXsRq4d/eHGNYB0GY1+I="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "ededb9e6ff708347",
                    "name": "libc-utils",
                    "version": "0.7.2-r3",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "BSD-2-Clause",
                        "AND",
                        "BSD-3-Clause"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:libc-utils:libc-utils:0.7.2-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:libc-utils:libc_utils:0.7.2-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:libc_utils:libc-utils:0.7.2-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:libc_utils:libc_utils:0.7.2-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:libc:libc-utils:0.7.2-r3:*:*:*:*:*:*:*",
                        "cpe:2.3:a:libc:libc_utils:0.7.2-r3:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/libc-utils@0.7.2-r3?arch=x86_64&upstream=libc-dev&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "libc-utils",
                        "originPackage": "libc-dev",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "0.7.2-r3",
                        "license": "BSD-2-Clause AND BSD-3-Clause",
                        "architecture": "x86_64",
                        "url": "https://alpinelinux.org",
                        "description": "Meta package to pull in correct libc",
                        "size": 1480,
                        "installedSize": 4096,
                        "pullDependencies": "musl-utils",
                        "pullChecksum": "Q1O4GFJRvHz95tPjO84qpEvkNVwDw=",
                        "gitCommitOfApkPort": "60424133be2e79bbfeff3d58147a22886f817ce2",
                        "files": []
                    }
                },
                {
                    "id": "b45ac99d5b23a895",
                    "name": "libcrypto1.1",
                    "version": "1.1.1s-r0",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "OpenSSL"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:libcrypto1.1:libcrypto1.1:1.1.1s-r0:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/libcrypto1.1@1.1.1s-r0?arch=x86_64&upstream=openssl&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "libcrypto1.1",
                        "originPackage": "openssl",
                        "maintainer": "Timo Teras <timo.teras@iki.fi>",
                        "version": "1.1.1s-r0",
                        "license": "OpenSSL",
                        "architecture": "x86_64",
                        "url": "https://www.openssl.org/",
                        "description": "Crypto library from openssl",
                        "size": 1212869,
                        "installedSize": 2772992,
                        "pullDependencies": "so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q1sntUdrpKbXw81vASa482yLXNEp8=",
                        "gitCommitOfApkPort": "46b66114372a5b408ec19d3a0a0faf4aa111a36f",
                        "files": [
                            {
                                "path": "/etc"
                            },
                            {
                                "path": "/etc/ssl"
                            },
                            {
                                "path": "/etc/ssl/ct_log_list.cnf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1olh8TpdAi2QnTl4FK3TjdUiSwTo="
                                }
                            },
                            {
                                "path": "/etc/ssl/ct_log_list.cnf.dist",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1olh8TpdAi2QnTl4FK3TjdUiSwTo="
                                }
                            },
                            {
                                "path": "/etc/ssl/openssl.cnf",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1wGuxVEOK9iGLj1i8D3BSBnT7MJA="
                                }
                            },
                            {
                                "path": "/etc/ssl/openssl.cnf.dist",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1wGuxVEOK9iGLj1i8D3BSBnT7MJA="
                                }
                            },
                            {
                                "path": "/etc/ssl/certs"
                            },
                            {
                                "path": "/etc/ssl/misc"
                            },
                            {
                                "path": "/etc/ssl/misc/CA.pl",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1IACevKhK93GYBHp96Ie26jgZ17s="
                                }
                            },
                            {
                                "path": "/etc/ssl/misc/tsget",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q13NVgfr7dQUuGYxur0tNalH6EIjU="
                                }
                            },
                            {
                                "path": "/etc/ssl/misc/tsget.pl",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1B4a6x5Xv8BnIXP9fafuqopvrtD0="
                                }
                            },
                            {
                                "path": "/etc/ssl/private"
                            },
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/libcrypto.so.1.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1lYfJOxQT2Pc/ktEQt5eG4f3FLGQ="
                                }
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/lib"
                            },
                            {
                                "path": "/usr/lib/libcrypto.so.1.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1T2si+c7ts7sgDxQYve4B3i1Dgo0="
                                }
                            },
                            {
                                "path": "/usr/lib/engines-1.1"
                            },
                            {
                                "path": "/usr/lib/engines-1.1/afalg.so",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q11UvSn9HY0EtbzWGYm8LNatQrK/Y="
                                }
                            },
                            {
                                "path": "/usr/lib/engines-1.1/capi.so",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Z+cQuXE87JZm1iQYBohJtw6fjbs="
                                }
                            },
                            {
                                "path": "/usr/lib/engines-1.1/padlock.so",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1ojt69UgLTXJSYj4gNJH/AMTeUQ8="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "3527575c5b0f2eb",
                    "name": "libssl1.1",
                    "version": "1.1.1s-r0",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "OpenSSL"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:libssl1.1:libssl1.1:1.1.1s-r0:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/libssl1.1@1.1.1s-r0?arch=x86_64&upstream=openssl&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "libssl1.1",
                        "originPackage": "openssl",
                        "maintainer": "Timo Teras <timo.teras@iki.fi>",
                        "version": "1.1.1s-r0",
                        "license": "OpenSSL",
                        "architecture": "x86_64",
                        "url": "https://www.openssl.org/",
                        "description": "SSL shared libraries",
                        "size": 213470,
                        "installedSize": 540672,
                        "pullDependencies": "so:libc.musl-x86_64.so.1 so:libcrypto.so.1.1",
                        "pullChecksum": "Q1dA1xCFDqKI3z/84yu4S77VxAU6g=",
                        "gitCommitOfApkPort": "46b66114372a5b408ec19d3a0a0faf4aa111a36f",
                        "files": [
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/libssl.so.1.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q18j7n4cIb/ge1J3ty4Y8OtFzxGJ0="
                                }
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/lib"
                            },
                            {
                                "path": "/usr/lib/libssl.so.1.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q18j35pe3yp6HOgMih1wlGP1/mm2c="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "cf71e417c1b2e0ba",
                    "name": "musl",
                    "version": "1.2.3-r1",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "MIT"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:musl:musl:1.2.3-r1:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/musl@1.2.3-r1?arch=x86_64&upstream=musl&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "musl",
                        "originPackage": "musl",
                        "maintainer": "Timo Teräs <timo.teras@iki.fi>",
                        "version": "1.2.3-r1",
                        "license": "MIT",
                        "architecture": "x86_64",
                        "url": "https://musl.libc.org/",
                        "description": "the musl c library (libc) implementation",
                        "size": 383459,
                        "installedSize": 622592,
                        "pullDependencies": "",
                        "pullChecksum": "Q14QhfC7ADTZ++cSoCC18jO47qnhQ=",
                        "gitCommitOfApkPort": "6711e7bdc190b184ec2db78d8ab5ebf06917ae78",
                        "files": [
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/ld-musl-x86_64.so.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1qyxQz8gx3d2xv+3X9qfj8jvK/Y0="
                                }
                            },
                            {
                                "path": "/lib/libc.musl-x86_64.so.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q17yJ3JFNypA4mxhJJr0ou6CzsJVI="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "58fe03d60769b2c3",
                    "name": "musl-utils",
                    "version": "1.2.3-r1",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "MIT",
                        "BSD",
                        "GPL2+"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:musl-utils:musl-utils:1.2.3-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:musl-utils:musl_utils:1.2.3-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:musl_utils:musl-utils:1.2.3-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:musl_utils:musl_utils:1.2.3-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:musl:musl-utils:1.2.3-r1:*:*:*:*:*:*:*",
                        "cpe:2.3:a:musl:musl_utils:1.2.3-r1:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/musl-utils@1.2.3-r1?arch=x86_64&upstream=musl&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "musl-utils",
                        "originPackage": "musl",
                        "maintainer": "Timo Teräs <timo.teras@iki.fi>",
                        "version": "1.2.3-r1",
                        "license": "MIT BSD GPL2+",
                        "architecture": "x86_64",
                        "url": "https://musl.libc.org/",
                        "description": "the musl c library (libc) implementation",
                        "size": 36959,
                        "installedSize": 135168,
                        "pullDependencies": "scanelf so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q1Avw82bzBMrlEuyKE1i1UEPK0V2Q=",
                        "gitCommitOfApkPort": "6711e7bdc190b184ec2db78d8ab5ebf06917ae78",
                        "files": [
                            {
                                "path": "/sbin"
                            },
                            {
                                "path": "/sbin/ldconfig",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1Kja2+POZKxEkUOZqwSjC6kmaED4="
                                }
                            },
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/bin"
                            },
                            {
                                "path": "/usr/bin/getconf",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1vGW6zqxwLuUVOBx6Uzf8N/hproQ="
                                }
                            },
                            {
                                "path": "/usr/bin/getent",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1zszN2Pw+TEbY4SmfOguLKmmIazA="
                                }
                            },
                            {
                                "path": "/usr/bin/iconv",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1UrvY/MROqlTgaScif5n9GLw9Rt8="
                                }
                            },
                            {
                                "path": "/usr/bin/ldd",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1yFAhGggmL7ERgbIA7KQxyTzf3ks="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "7514a98b23f9928c",
                    "name": "scanelf",
                    "version": "1.3.4-r0",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:scanelf:scanelf:1.3.4-r0:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/scanelf@1.3.4-r0?arch=x86_64&upstream=pax-utils&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "scanelf",
                        "originPackage": "pax-utils",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "1.3.4-r0",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities",
                        "description": "Scan ELF binaries for stuff",
                        "size": 36745,
                        "installedSize": 94208,
                        "pullDependencies": "so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q1Gcqe+ND8DFOlhM3R0o5KyZjR2oE=",
                        "gitCommitOfApkPort": "d7ae612a3cc5f827289d915783b4cbf8c7207947",
                        "files": [
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/bin"
                            },
                            {
                                "path": "/usr/bin/scanelf",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1YPb72qHJJvTH6mJkN9DuExFQQh8="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "7aec2be3ffd82c3c",
                    "name": "ssl_client",
                    "version": "1.35.0-r17",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "GPL-2.0-only"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:ssl-client:ssl-client:1.35.0-r17:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ssl-client:ssl_client:1.35.0-r17:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ssl_client:ssl-client:1.35.0-r17:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ssl_client:ssl_client:1.35.0-r17:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ssl:ssl-client:1.35.0-r17:*:*:*:*:*:*:*",
                        "cpe:2.3:a:ssl:ssl_client:1.35.0-r17:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/ssl_client@1.35.0-r17?arch=x86_64&upstream=busybox&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "ssl_client",
                        "originPackage": "busybox",
                        "maintainer": "Sören Tempel <soeren+alpine@soeren-tempel.net>",
                        "version": "1.35.0-r17",
                        "license": "GPL-2.0-only",
                        "architecture": "x86_64",
                        "url": "https://busybox.net/",
                        "description": "EXternal ssl_client for busybox wget",
                        "size": 5004,
                        "installedSize": 28672,
                        "pullDependencies": "so:libc.musl-x86_64.so.1 so:libcrypto.so.1.1 so:libssl.so.1.1",
                        "pullChecksum": "Q1KWJXawaNPiINHfdzCg/FrEmiAaU=",
                        "gitCommitOfApkPort": "2bf6ec48e526113f87216683cd341a78af5f0b3f",
                        "files": [
                            {
                                "path": "/usr"
                            },
                            {
                                "path": "/usr/bin"
                            },
                            {
                                "path": "/usr/bin/ssl_client",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1C6qA8RFt5eagesbaqu4plc6Ctyc="
                                }
                            }
                        ]
                    }
                },
                {
                    "id": "94e7e84b87c1f8c3",
                    "name": "zlib",
                    "version": "1.2.12-r3",
                    "type": "apk",
                    "foundBy": "apkdb-cataloger",
                    "locations": [
                        {
                            "path": "/lib/apk/db/installed",
                            "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                        }
                    ],
                    "licenses": [
                        "Zlib"
                    ],
                    "language": "",
                    "cpes": [
                        "cpe:2.3:a:zlib:zlib:1.2.12-r3:*:*:*:*:*:*:*"
                    ],
                    "purl": "pkg:alpine/zlib@1.2.12-r3?arch=x86_64&upstream=zlib&distro=alpine-3.16.3",
                    "metadataType": "ApkMetadata",
                    "metadata": {
                        "package": "zlib",
                        "originPackage": "zlib",
                        "maintainer": "Natanael Copa <ncopa@alpinelinux.org>",
                        "version": "1.2.12-r3",
                        "license": "Zlib",
                        "architecture": "x86_64",
                        "url": "https://zlib.net/",
                        "description": "A compression/decompression Library",
                        "size": 53346,
                        "installedSize": 110592,
                        "pullDependencies": "so:libc.musl-x86_64.so.1",
                        "pullChecksum": "Q1Ekuqm/0CPywDCKEbEwhsPCw+z9E=",
                        "gitCommitOfApkPort": "57ce38bde7ce42964b664c137935cf2de803ac44",
                        "files": [
                            {
                                "path": "/lib"
                            },
                            {
                                "path": "/lib/libz.so.1",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "777",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1+aBjyJ7dmLatVkyqCNnAChlDZh8="
                                }
                            },
                            {
                                "path": "/lib/libz.so.1.2.12",
                                "ownerUid": "0",
                                "ownerGid": "0",
                                "permissions": "755",
                                "digest": {
                                    "algorithm": "sha1",
                                    "value": "Q1x/qx/7zlM20k7fLfVee7A4WLOC8="
                                }
                            }
                        ]
                    }
                }
            ],
            "artifactRelationships": [
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "231e2b9b768a1fff",
                    "type": "contains"
                },
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "51a0badf3b704202",
                    "type": "contains"
                },
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "78bf055cad090d65",
                    "type": "contains"
                },
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "7b5d21b40bc7eee7",
                    "type": "contains"
                },
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "91817eca9cc4b5de",
                    "type": "contains"
                },
                {
                    "parent": "2bc2db5bac1d0fe4",
                    "child": "a2c9b7dd9588eed5",
                    "type": "contains"
                },
                {
                    "parent": "3527575c5b0f2eb",
                    "child": "bf6955e2941356b2",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "202110ab27dcf973",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "3078ae894cd9cfbd",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "387bdef96b1af6e4",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "388b915e3caf5f8b",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "3d8ddf18e3124850",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "44900ed9ce94fa9e",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "487fe69baafa2d7e",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "5353cb0dc92ea4b",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "55708c7a7e686d62",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "55e20144d113e62d",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "59a8217f4f6c22a1",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "68769d7fd3919789",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "6a0ff9781347bfd9",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "6fbe3c2a939ebbd2",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "7e6812fc46b6a77",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "983be5c7034a6165",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "a01e0e5b23c3173d",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "af97d47465df73a7",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "c4944df811809487",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "e041389ecc1c5526",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "f02ff58080ad2795",
                    "type": "contains"
                },
                {
                    "parent": "3f53edc3b14056c3",
                    "child": "f7de852c28002fea",
                    "type": "contains"
                },
                {
                    "parent": "3ff09d7a5e0dc2ed",
                    "child": "f2d3dfa05f2554a0",
                    "type": "contains"
                },
                {
                    "parent": "58fe03d60769b2c3",
                    "child": "1b47e047a7a2d57c",
                    "type": "contains"
                },
                {
                    "parent": "58fe03d60769b2c3",
                    "child": "72d84b54cc507273",
                    "type": "contains"
                },
                {
                    "parent": "58fe03d60769b2c3",
                    "child": "88f42084360d15dc",
                    "type": "contains"
                },
                {
                    "parent": "58fe03d60769b2c3",
                    "child": "e0f2d4db60a9b798",
                    "type": "contains"
                },
                {
                    "parent": "58fe03d60769b2c3",
                    "child": "e4f8a4c0b073c8bc",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "33b11b3a2ec70e8f",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "3426822570585ca6",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "37f2712bfdc05029",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "65ba00203fcb00b7",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "98d3eb523b0b443b",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "98fd433dcbda9dd8",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "aa75789d9e818133",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "aebdc91357768244",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "c7479ec33c892d37",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "de09f2147681af25",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "e1ce65f920562037",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "f68970af52c912d3",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "fc7c614fbff1fe93",
                    "type": "contains"
                },
                {
                    "parent": "59eadcf6a622022c",
                    "child": "ff4dbb6e8f3bb698",
                    "type": "contains"
                },
                {
                    "parent": "7514a98b23f9928c",
                    "child": "ae378054cbd7ef90",
                    "type": "contains"
                },
                {
                    "parent": "7aec2be3ffd82c3c",
                    "child": "dfa8a561b5b9eed",
                    "type": "contains"
                },
                {
                    "parent": "94e7e84b87c1f8c3",
                    "child": "52dc0abd8e7f5999",
                    "type": "contains"
                },
                {
                    "parent": "9bb9cb82a4ce72b1",
                    "child": "6a92934c972808b8",
                    "type": "contains"
                },
                {
                    "parent": "9bb9cb82a4ce72b1",
                    "child": "b04bc3289bb54853",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "287e44a117aa6396",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "2ea8f53adecae6f3",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "34a945b6fcfc9394",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "461f2cb164a4d9de",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "5217fc877d4a56a3",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "5b247851eb9d9920",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "629d9b60ae1d9e52",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "7c76c319483f88f8",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "80d54a8d1cb02a6b",
                    "type": "contains"
                },
                {
                    "parent": "b45ac99d5b23a895",
                    "child": "e90735c3db4c5cc",
                    "type": "contains"
                },
                {
                    "parent": "cf71e417c1b2e0ba",
                    "child": "4c909bab2f47ab6",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "2a20bd42108d699a",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "3617fb189dce6482",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "3b5675f91b90110",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "6407d5cf424b18ad",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "7e87ca025472176a",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "84e95c181a3977e9",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "9ce07ed49f8fb925",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "b83f6a50a3bd4519",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "c7d306fe1c6785c7",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "c82217b71778b876",
                    "type": "contains"
                },
                {
                    "parent": "d152144d8060d0c2",
                    "child": "e6b17bb11a720679",
                    "type": "contains"
                }
            ],
            "files": [
                {
                    "id": "51a0badf3b704202",
                    "location": {
                        "path": "/bin/busybox",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "983be5c7034a6165",
                    "location": {
                        "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "3078ae894cd9cfbd",
                    "location": {
                        "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "388b915e3caf5f8b",
                    "location": {
                        "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "af97d47465df73a7",
                    "location": {
                        "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "7e6812fc46b6a77",
                    "location": {
                        "path": "/etc/apk/keys/alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "6407d5cf424b18ad",
                    "location": {
                        "path": "/etc/crontabs/root",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "33b11b3a2ec70e8f",
                    "location": {
                        "path": "/etc/fstab",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "3426822570585ca6",
                    "location": {
                        "path": "/etc/group",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "c7479ec33c892d37",
                    "location": {
                        "path": "/etc/hostname",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "f68970af52c912d3",
                    "location": {
                        "path": "/etc/hosts",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "65ba00203fcb00b7",
                    "location": {
                        "path": "/etc/inittab",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "91817eca9cc4b5de",
                    "location": {
                        "path": "/etc/logrotate.d/acpid",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "b83f6a50a3bd4519",
                    "location": {
                        "path": "/etc/modprobe.d/aliases.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "c82217b71778b876",
                    "location": {
                        "path": "/etc/modprobe.d/blacklist.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "9ce07ed49f8fb925",
                    "location": {
                        "path": "/etc/modprobe.d/i386.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "3617fb189dce6482",
                    "location": {
                        "path": "/etc/modprobe.d/kms.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "fc7c614fbff1fe93",
                    "location": {
                        "path": "/etc/modules",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "84e95c181a3977e9",
                    "location": {
                        "path": "/etc/motd",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "7b5d21b40bc7eee7",
                    "location": {
                        "path": "/etc/network/if-up.d/dad",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "37f2712bfdc05029",
                    "location": {
                        "path": "/etc/nsswitch.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e1ce65f920562037",
                    "location": {
                        "path": "/etc/passwd",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "de09f2147681af25",
                    "location": {
                        "path": "/etc/profile",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e6b17bb11a720679",
                    "location": {
                        "path": "/etc/profile.d/README",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "2a20bd42108d699a",
                    "location": {
                        "path": "/etc/profile.d/color_prompt.sh.disabled",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "7e87ca025472176a",
                    "location": {
                        "path": "/etc/profile.d/locale.sh",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "ff4dbb6e8f3bb698",
                    "location": {
                        "path": "/etc/protocols",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "78bf055cad090d65",
                    "location": {
                        "path": "/etc/securetty",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "aa75789d9e818133",
                    "location": {
                        "path": "/etc/services",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "98fd433dcbda9dd8",
                    "location": {
                        "path": "/etc/shadow",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "98d3eb523b0b443b",
                    "location": {
                        "path": "/etc/shells",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "f2d3dfa05f2554a0",
                    "location": {
                        "path": "/etc/ssl/certs/ca-certificates.crt",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "461f2cb164a4d9de",
                    "location": {
                        "path": "/etc/ssl/ct_log_list.cnf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e90735c3db4c5cc",
                    "location": {
                        "path": "/etc/ssl/ct_log_list.cnf.dist",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "2ea8f53adecae6f3",
                    "location": {
                        "path": "/etc/ssl/misc/CA.pl",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "5b247851eb9d9920",
                    "location": {
                        "path": "/etc/ssl/misc/tsget.pl",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "629d9b60ae1d9e52",
                    "location": {
                        "path": "/etc/ssl/openssl.cnf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "34a945b6fcfc9394",
                    "location": {
                        "path": "/etc/ssl/openssl.cnf.dist",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "aebdc91357768244",
                    "location": {
                        "path": "/etc/sysctl.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "231e2b9b768a1fff",
                    "location": {
                        "path": "/etc/udhcpd.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "4c909bab2f47ab6",
                    "location": {
                        "path": "/lib/ld-musl-x86_64.so.1",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "6a92934c972808b8",
                    "location": {
                        "path": "/lib/libapk.so.3.12.0",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "5217fc877d4a56a3",
                    "location": {
                        "path": "/lib/libcrypto.so.1.1",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "bf6955e2941356b2",
                    "location": {
                        "path": "/lib/libssl.so.1.1",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "52dc0abd8e7f5999",
                    "location": {
                        "path": "/lib/libz.so.1.2.12",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "c7d306fe1c6785c7",
                    "location": {
                        "path": "/lib/sysctl.d/00-alpine.conf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "b04bc3289bb54853",
                    "location": {
                        "path": "/sbin/apk",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e0f2d4db60a9b798",
                    "location": {
                        "path": "/sbin/ldconfig",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "3b5675f91b90110",
                    "location": {
                        "path": "/sbin/mkmntdirs",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "88f42084360d15dc",
                    "location": {
                        "path": "/usr/bin/getconf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "72d84b54cc507273",
                    "location": {
                        "path": "/usr/bin/getent",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e4f8a4c0b073c8bc",
                    "location": {
                        "path": "/usr/bin/iconv",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "1b47e047a7a2d57c",
                    "location": {
                        "path": "/usr/bin/ldd",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "ae378054cbd7ef90",
                    "location": {
                        "path": "/usr/bin/scanelf",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "dfa8a561b5b9eed",
                    "location": {
                        "path": "/usr/bin/ssl_client",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "287e44a117aa6396",
                    "location": {
                        "path": "/usr/lib/engines-1.1/afalg.so",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "80d54a8d1cb02a6b",
                    "location": {
                        "path": "/usr/lib/engines-1.1/capi.so",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "7c76c319483f88f8",
                    "location": {
                        "path": "/usr/lib/engines-1.1/padlock.so",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "487fe69baafa2d7e",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "6fbe3c2a939ebbd2",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "68769d7fd3919789",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "387bdef96b1af6e4",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "a01e0e5b23c3173d",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58199dcc.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "6a0ff9781347bfd9",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58cbb476.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "f7de852c28002fea",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-58e4f17d.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "c4944df811809487",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-5e69ca50.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "3d8ddf18e3124850",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-60ac2099.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "e041389ecc1c5526",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "202110ab27dcf973",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "55708c7a7e686d62",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616a9724.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "f02ff58080ad2795",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616abc23.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "59a8217f4f6c22a1",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616ac3bc.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "5353cb0dc92ea4b",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616adfeb.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "55e20144d113e62d",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616ae350.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "44900ed9ce94fa9e",
                    "location": {
                        "path": "/usr/share/apk/keys/alpine-devel@lists.alpinelinux.org-616db30d.rsa.pub",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                },
                {
                    "id": "a2c9b7dd9588eed5",
                    "location": {
                        "path": "/usr/share/udhcpc/default.script",
                        "layerID": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd"
                    }
                }
            ],
            "source": {
                "type": "image",
                "target": {
                    "userInput": "alpine:latest",
                    "imageID": "sha256:bfe296a525011f7eb76075d688c681ca4feaad5afe3b142b36e30f1a171dc99a",
                    "manifestDigest": "sha256:6b7f97b22b59a2c6bc62354f00df8dcafb8a32716bc958a788a7004e0a391232",
                    "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
                    "tags": [
                        "alpine:latest"
                    ],
                    "imageSize": 5539603,
                    "layers": [
                        {
                            "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
                            "digest": "sha256:e5e13b0c77cbb769548077189c3da2f0a764ceca06af49d8d558e759f5c232bd",
                            "size": 5539603
                        }
                    ],
                    "manifest": "eyJzY2hlbWFWZXJzaW9uIjoyLCJtZWRpYVR5cGUiOiJhcHBsaWNhdGlvbi92bmQuZG9ja2VyLmRpc3RyaWJ1dGlvbi5tYW5pZmVzdC52Mitqc29uIiwiY29uZmlnIjp7Im1lZGlhVHlwZSI6ImFwcGxpY2F0aW9uL3ZuZC5kb2NrZXIuY29udGFpbmVyLmltYWdlLnYxK2pzb24iLCJzaXplIjoxNDcxLCJkaWdlc3QiOiJzaGEyNTY6YmZlMjk2YTUyNTAxMWY3ZWI3NjA3NWQ2ODhjNjgxY2E0ZmVhYWQ1YWZlM2IxNDJiMzZlMzBmMWExNzFkYzk5YSJ9LCJsYXllcnMiOlt7Im1lZGlhVHlwZSI6ImFwcGxpY2F0aW9uL3ZuZC5kb2NrZXIuaW1hZ2Uucm9vdGZzLmRpZmYudGFyLmd6aXAiLCJzaXplIjo1ODI3NTg0LCJkaWdlc3QiOiJzaGEyNTY6ZTVlMTNiMGM3N2NiYjc2OTU0ODA3NzE4OWMzZGEyZjBhNzY0Y2VjYTA2YWY0OWQ4ZDU1OGU3NTlmNWMyMzJiZCJ9XX0=",
                    "config": "eyJhcmNoaXRlY3R1cmUiOiJhbWQ2NCIsImNvbmZpZyI6eyJIb3N0bmFtZSI6IiIsIkRvbWFpbm5hbWUiOiIiLCJVc2VyIjoiIiwiQXR0YWNoU3RkaW4iOmZhbHNlLCJBdHRhY2hTdGRvdXQiOmZhbHNlLCJBdHRhY2hTdGRlcnIiOmZhbHNlLCJUdHkiOmZhbHNlLCJPcGVuU3RkaW4iOmZhbHNlLCJTdGRpbk9uY2UiOmZhbHNlLCJFbnYiOlsiUEFUSD0vdXNyL2xvY2FsL3NiaW46L3Vzci9sb2NhbC9iaW46L3Vzci9zYmluOi91c3IvYmluOi9zYmluOi9iaW4iXSwiQ21kIjpbIi9iaW4vc2giXSwiSW1hZ2UiOiJzaGEyNTY6MThmNDEyZTM1OWRlMDQyNjM0NGY0ZmUxMTUxNzk2ZTJkOWRjMTIxYjAxZDczN2U5NTNmMDQzYTEwNDY0ZDBiNyIsIlZvbHVtZXMiOm51bGwsIldvcmtpbmdEaXIiOiIiLCJFbnRyeXBvaW50IjpudWxsLCJPbkJ1aWxkIjpudWxsLCJMYWJlbHMiOm51bGx9LCJjb250YWluZXIiOiIzY2QyY2U2MTJiOTExOWJlOTY3Mzg2MDAyMjQyMGVlZTAyMGYwYTZkNDRlOTA3MmNhMjUxOTZmNGYwYTQ2MTNkIiwiY29udGFpbmVyX2NvbmZpZyI6eyJIb3N0bmFtZSI6IjNjZDJjZTYxMmI5MSIsIkRvbWFpbm5hbWUiOiIiLCJVc2VyIjoiIiwiQXR0YWNoU3RkaW4iOmZhbHNlLCJBdHRhY2hTdGRvdXQiOmZhbHNlLCJBdHRhY2hTdGRlcnIiOmZhbHNlLCJUdHkiOmZhbHNlLCJPcGVuU3RkaW4iOmZhbHNlLCJTdGRpbk9uY2UiOmZhbHNlLCJFbnYiOlsiUEFUSD0vdXNyL2xvY2FsL3NiaW46L3Vzci9sb2NhbC9iaW46L3Vzci9zYmluOi91c3IvYmluOi9zYmluOi9iaW4iXSwiQ21kIjpbIi9iaW4vc2giLCItYyIsIiMobm9wKSAiLCJDTUQgW1wiL2Jpbi9zaFwiXSJdLCJJbWFnZSI6InNoYTI1NjoxOGY0MTJlMzU5ZGUwNDI2MzQ0ZjRmZTExNTE3OTZlMmQ5ZGMxMjFiMDFkNzM3ZTk1M2YwNDNhMTA0NjRkMGI3IiwiVm9sdW1lcyI6bnVsbCwiV29ya2luZ0RpciI6IiIsIkVudHJ5cG9pbnQiOm51bGwsIk9uQnVpbGQiOm51bGwsIkxhYmVscyI6e319LCJjcmVhdGVkIjoiMjAyMi0xMS0xMlQwNDoxOToyMy4xOTk3MTY1MzlaIiwiZG9ja2VyX3ZlcnNpb24iOiIyMC4xMC4xMiIsImhpc3RvcnkiOlt7ImNyZWF0ZWQiOiIyMDIyLTExLTEyVDA0OjE5OjIzLjA1MTU0MjA5WiIsImNyZWF0ZWRfYnkiOiIvYmluL3NoIC1jICMobm9wKSBBREQgZmlsZTpjZWViNmU4NjMyZmFmYzY1NzExNmNiZjNhZmJkNTIyMTg1YTE2OTYzMjMwYjU3ODgxMDczZGFkMjJlYjBlMWEzIGluIC8gIn0seyJjcmVhdGVkIjoiMjAyMi0xMS0xMlQwNDoxOToyMy4xOTk3MTY1MzlaIiwiY3JlYXRlZF9ieSI6Ii9iaW4vc2ggLWMgIyhub3ApICBDTUQgW1wiL2Jpbi9zaFwiXSIsImVtcHR5X2xheWVyIjp0cnVlfV0sIm9zIjoibGludXgiLCJyb290ZnMiOnsidHlwZSI6ImxheWVycyIsImRpZmZfaWRzIjpbInNoYTI1NjplNWUxM2IwYzc3Y2JiNzY5NTQ4MDc3MTg5YzNkYTJmMGE3NjRjZWNhMDZhZjQ5ZDhkNTU4ZTc1OWY1YzIzMmJkIl19fQ==",
                    "repoDigests": [
                        "alpine@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b"
                    ],
                    "architecture": "amd64",
                    "os": "linux"
                }
            },
            "distro": {
                "prettyName": "Alpine Linux v3.16",
                "name": "Alpine Linux",
                "id": "alpine",
                "versionID": "3.16.3",
                "homeURL": "https://alpinelinux.org/",
                "bugReportURL": "https://gitlab.alpinelinux.org/alpine/aports/-/issues"
            },
            "descriptor": {
                "name": "syft",
                "version": "0.58.0",
                "configuration": {
                    "configPath": "",
                    "verbosity": 0,
                    "quiet": false,
                    "output": [
                        "json"
                    ],
                    "output-template-path": "",
                    "file": "",
                    "check-for-app-update": true,
                    "anchore": {
                        "host": "",
                        "path": "",
                        "dockerfile": "",
                        "overwrite-existing-image": false,
                        "import-timeout": 30
                    },
                    "dev": {
                        "profile-cpu": false,
                        "profile-mem": false
                    },
                    "log": {
                        "structured": false,
                        "level": "warning",
                        "file-location": ""
                    },
                    "catalogers": null,
                    "package": {
                        "cataloger": {
                            "enabled": true,
                            "scope": "Squashed"
                        },
                        "search-unindexed-archives": false,
                        "search-indexed-archives": true
                    },
                    "file-metadata": {
                        "cataloger": {
                            "enabled": false,
                            "scope": "Squashed"
                        },
                        "digests": [
                            "sha256"
                        ]
                    },
                    "file-classification": {
                        "cataloger": {
                            "enabled": false,
                            "scope": "Squashed"
                        }
                    },
                    "file-contents": {
                        "cataloger": {
                            "enabled": false,
                            "scope": "Squashed"
                        },
                        "skip-files-above-size": 1048576,
                        "globs": []
                    },
                    "secrets": {
                        "cataloger": {
                            "enabled": false,
                            "scope": "AllLayers"
                        },
                        "additional-patterns": {},
                        "exclude-pattern-names": [],
                        "reveal-values": false,
                        "skip-files-above-size": 1048576
                    },
                    "registry": {
                        "insecure-skip-tls-verify": false,
                        "insecure-use-http": false,
                        "auth": []
                    },
                    "exclude": [],
                    "attest": {
                        "key": "",
                        "cert": "",
                        "noUpload": false,
                        "force": false,
                        "recursive": false,
                        "replace": false,
                        "fulcioUrl": "https://fulcio.sigstore.dev",
                        "fulcio_identity_token": "",
                        "insecure_skip_verify": false,
                        "rekorUrl": "https://rekor.sigstore.dev",
                        "oidcIssuer": "https://oauth2.sigstore.dev/auth",
                        "oidcClientId": "sigstore",
                        "OIDCRedirectURL": ""
                    },
                    "platform": ""
                }
            },
            "schema": {
                "version": "4.0.0",
                "url": "https://raw.githubusercontent.com/anchore/syft/main/schema/json/schema-4.0.0.json"
            }
        }

    );
end;

main();
