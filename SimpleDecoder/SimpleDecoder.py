#!/usr/bin/python3
# Author: Sritaran Doraisamy
import base64
import argparse

parser = argparse.ArgumentParser(description='Decodes or encodes strings in hex, base64, base32 and Ascii85 as well as Reverses Them and tries them as well')
parser.add_argument('-e', '--encode', metavar=' ', help='Use this if you want to encode your string')
parser.add_argument('-d', '--decode', metavar=' ', help='Use this if you want to decode your string')
args = parser.parse_args()

if __name__ == '__main__':
    if args.encode:
        databytes = bytes(args.encode, 'utf-8')
        data16 = str(base64.b16encode(databytes), 'utf-8')
        data32 = str(base64.b32encode(databytes), 'utf-8')
        data64 = str(base64.b64encode(databytes), 'utf-8')
        data85 = str(base64.b85encode(databytes), 'utf-8')
        print('[+] Base16 is:', data16, '\n[+] Base32 is:', data32, '\n[+] Base64 is:', data64, '\n[+] Ascii85 is:', data85)

    elif args.decode:
        dataReversed = args.decode[::-1]
        databytes = bytes(args.decode, 'utf-8')
        try:
            data16 = str(base64.b16decode(databytes), 'utf-8')
            print('[+] It is base 16:', data16)
        except:
            pass
        try:
            data16r = str(base64.b16decode(dataReversed), 'utf-8')
            print('[+] It is base 16 from reversed string:', data16r)
        except:
            pass

        try:
            data32 = str(base64.b32decode(databytes), 'utf-8')
            print('[+] It is base 32:', data32)
        except:
            pass
        try:
            data32r = str(base64.b32decode(dataReversed), 'utf-8')
            print('[+] It is base 32 from reversed string:', data32r)
        except:
            pass

        try:
            data64 = str(base64.b64decode(databytes), 'utf-8')
            print('[+] It is base 64:', data64)
        except:
            pass
        try:
            data64r = str(base64.b64decode(dataReversed), 'utf-8')
            print('[+] It is base 64 from reversed string:', data64r)
        except:
            pass

        try:
            data85 = str(base64.b85decode(databytes), 'utf-8')
            print('[+] It is Ascii 85:', data85)
        except:
            pass
        try:
            data85r = str(base64.b85decode(dataReversed), 'utf-8')
            print('[+] It is Ascii 85 from reversed string:', data85r)
        except:
            pass

        try:
            print('[+] Converted from hex to text:', bytes.fromhex(args.decode))
        except:
            print('It is not base16, 32, 64, 85 encoded and is neither a hex value.')


