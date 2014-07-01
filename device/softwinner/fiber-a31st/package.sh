cd $PACKAGE
if [ "$1" = "-d" ]; then
	echo "--------debug version, have uart printf-------------"
	./pack -c sun6i -p android -b fiber-a31st -d card0
else
	echo "--------release version, donnot have uart printf-------------"
	./pack -c sun6i -p android -b fiber-a31st
fi
cd -
