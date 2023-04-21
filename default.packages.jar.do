#!/usr/bin/env python3

import re
from subprocess import run
from sys import argv
from tempfile import TemporaryDirectory
from zipfile import ZipFile, ZipInfo

variant = argv[1].removesuffix(".packages.jar")
run(["redo-ifchange", "packages.rc"], close_fds=False).check_returncode()
jars = []
expr = re.compile(r"^packages_" + variant + r"\[([^]]*)\]=")
with open("packages.rc") as f:
    for line in f:
        if match := expr.match(line):
            jars.append(f"pkg/{match.group(1)}.jar")
run(["redo-ifchange", *jars], close_fds=False).check_returncode()
already_written = set()
with TemporaryDirectory() as d, ZipFile(argv[3], "w") as out:
    for jar in reversed(jars):
        with ZipFile(jar) as z:
            for inf in z.infolist():
                if inf.is_dir():
                    continue
                path = inf.filename.split("/")
                if (
                    not path
                    or path[0] == ""
                    or ".." in path
                    or path == ["META-INF", "MANIFEST.MF"]
                    or inf.filename in already_written
                ):
                    continue
                already_written.add(inf.filename)
                with z.open(inf.filename) as src:
                    out.writestr(inf, src.read())
    out.writestr(
        ZipInfo("META-INF/MANIFEST.MF"),
        b"Manifest-Version: 1.0\nCreated-By: python-program\n",
    )
# vim:ft=python
