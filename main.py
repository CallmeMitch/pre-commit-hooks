#!/usr/bin/env python3

import os
import sys

file = sys.argv[1]
EXPECTED_NAME = ["fix", "feat", "docs"]

if os.path.isfile(file):
    openned_file = open(file, "r")
    openned_line_in_file = openned_file.readline()
    check_word = openned_line_in_file.split()[0]
    verif_global(check_word)
    openned_file.close()
    exit()
else:
    print("expected argument:\ntype[optional scope]: description ==> fix: The probleme is fixed!\n[optional body]\n[optional footer(s)]")
    print("The type can be fix, feat or docs(noon value)")


def verif_global(git_verif):
    if git_verif in EXPECTED_NAME:
        print("Check pass")
    