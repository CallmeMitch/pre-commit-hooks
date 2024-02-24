#!/usr/bin/env python3

import os
import sys

file = sys.argv[1]
EXPECTED_NAME = ["fix:", "feat:", "docs:"]

def verif_global(git_verif):
    if git_verif not in EXPECTED_NAME:
        print("Check failed for", git_verif,"\nExemple ==> fix: description")
        sys.exit(1)
    print("Check passed for", git_verif)


if os.path.isfile(file):
    openned_file = open(file, "r")
    openned_line_in_file = openned_file.readline()
    if len(openned_line_in_file) < 50:
        check_word = openned_line_in_file.split()[0]
        verif_global(check_word)
    else:
        print("50 characters or less")
        sys.exit(1)
    openned_file.close()
