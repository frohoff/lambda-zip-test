echo starting test
echo uname -a
uname -a
echo dpkg -s zlib1g
dpkg -s zlib1g
echo ls -la .
ls -la .
echo ls -la ~ 
ls -la ~ 
echo ls -la ~/.aws
ls -la ~/.aws
echo
echo =========== testing python zip ============
sh test.sh python-lambda.zip
echo
echo =========== testing zip zip ===========
sh test.sh zip-lambda.zip
echo
echo =========== testing 7z zip ===========
sh test.sh 7z-lambda.zip
