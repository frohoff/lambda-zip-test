echo removing old zips
rm *.zip
echo building zip
zip zip-lambda.zip lambda.py
7z a 7z-lambda.zip lambda.py
python zip-lambda.py
