cd $PACKAGE
if [ "$1" = "-d" ]; then
	echo "--------debug version, have uart printf-------------"
	./pack -c sun6i -p android -b fiber-a31stm -d card0
else
	echo "--------release version, donnot have uart printf-------------"
	./pack -c sun6i -p android -b fiber-a31stm
fi
cd -
