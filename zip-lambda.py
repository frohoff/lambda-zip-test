#/usr/bin/env python

import zipfile

with zipfile.ZipFile("python-lambda.zip", "w", compression=zipfile.ZIP_DEFLATED) as z:
	z.write("lambda.py")
	
