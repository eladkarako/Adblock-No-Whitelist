#!/usr/bin/env python
# coding: utf-8

import sys, re, codecs, hashlib, base64

rgx_checksum      = re.compile(r'^\s*!\s*checksum[\s\-:]+([\w\+\/=]+).*\n', re.I | re.M)

def add_checksum(data):
  data = re.sub(rgx_checksum, '', data)
  normalized_data = re.sub(r'\r', '', data)
  normalized_data = re.sub(r'\n+', '\n', normalized_data)
  normalized_data = normalized_data.encode('utf-8')
  md5 = hashlib.md5()
  md5.update(normalized_data)
  checksum = base64.b64encode(md5.digest()).rstrip('=')
  data = re.sub(r'(\r?\n)', r'\1! Checksum: %s\1' % checksum, data, 1)
  return data

def readStream(stream):
  reader = codecs.getreader('utf8')(stream)
  try:
    return reader.read()
  except Exception, e:
    raise Exception('Failed reading data, most likely not encoded as UTF-8:\n%s' % e)

if __name__ == '__main__':
  if sys.platform == "win32":
    import os, msvcrt
    msvcrt.setmode(sys.stdout.fileno(), os.O_BINARY)

  data = readStream(sys.stdin)
  data = add_checksum(data)
  sys.stdout.write(data.encode('utf-8'))
