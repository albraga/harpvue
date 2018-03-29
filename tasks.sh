#!/bin/bash

PUBLIC="./public/"

function init {
if [ ! -d "$PUBLIC""js" ]; then
mkdir -v "$PUBLIC""js"
fi
cd "$PUBLIC""js"
if [ ! -f jquery-3.3.1.js ]; then
wget "https://code.jquery.com/jquery-3.3.1.js"
fi
if [ ! -f popper.min.js ]; then
wget "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
fi
if [ ! -f bootstrap.min.js ]; then
wget "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
fi
touch main.js
# Open file descriptor (fd) 3 for read/write on a text file.
exec 3<> main.js
	# Let's print some text to fd 3
	echo "console.log('ok');" >&3
# Close fd 3
exec 3>&-
cd ..
if [ ! -d "css" ]; then
mkdir -v css
fi
cd css
cp ../../src/main.css .
if [ ! -f bootstrap.min.css ]; then
wget "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
fi
cd ../..
}

function todocs {
cd $PUBLIC
rm _data.json
cp bkp_data.json _data.json
rm -rfv ../docs js css
mv ../www ../docs
rm -rfv js css img
rm -v *00.ejs *.html
cd ..
}

function makeinitial {
rm -rfv .git
git init
git add --all
git commit -m "to initial commit"
git remote add origin https://github.com/albraga/harpvue.git
git push -u --force origin master
}

for argument in "$@"
do
case $argument in
	init)
		init
	;;
	todocs)
		todocs
	;;
	makeinitial)
		makeinitial
	;;
	test)
		init
		#harp compile
		#todocs
	;;
esac
done
