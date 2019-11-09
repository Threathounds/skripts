#!/usr/bin/python3
# author: ide0x90

import sys
import re

if len(sys.argv) != 3:
    sys.exit("Usage: single-char-xor.py <ciphertext_file> <keyword>")

# keyword is the plaintext we want to search for. Convert it to bytes
keyword = bytes(sys.argv[2], encoding="utf-8")
# create a regular expression matching pattern. The flag is assumed to be between curly brackets
regexp = bytes('{(.+?)}', encoding="utf-8")
# the keyword is assumed to be before the opening curly bracket
regexp = keyword + regexp
# open the file, read-only
ciphertext_file = open(sys.argv[1], "r")
# read everything in the file
ciphertext = ciphertext_file.read()
# remove newlines in ciphertext, they're annoying and are not part of the ciphertext
ciphertext = ciphertext.replace("\n", "")
# convert ciphertext from hex to bytes
ciphertext = bytes.fromhex(ciphertext)
# no plaintext at the moment, but declare it as bytes, encoding is UTF-8
plaintext = bytes("", encoding="utf-8")
# 256 keys we should concern ourselves with (the standard printable characters for UTF-8)
for i in range(0, 256):
    # for each byte in the ciphertext
    for byte in ciphertext:
        # XOR the byte and the key, then convert to bytes, then add to plaintext
        plaintext += bytes([byte ^ i])

    # find the match using a regular expression search
    flag = re.search(regexp, plaintext)
    if flag:
        sys.exit(f"Found: {flag.group(1)}")
    # comment the above 2 lines, and uncomment the next 2 lines if you think the regular expression search is not working properly
    # if keyword in plaintext:
    #     print(plaintext)

    # clear the plaintext variable after XOR operation
    plaintext = bytes("", encoding="utf-8")

sys.exit("Flag not found!")
