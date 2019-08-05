mkdir -p packages

cd manager/package
dpkg-buildpackage -us -uc -b -a armhf
dh clean
cd ../../
mv manager/*.deb packages/

mkdir -p python-packages
packages=('starlette' 'pydantic' 'fastapi')
# Set version to '' for latest
versions=('0.12.0' '0.30' '0.33.0')
for i in $(seq 0 $((${#packages[@]}-1))); do
	package="${packages[$i]}"
	version="${versions[$i]}"
	mkdir -p "python-packages/$package"
	if [ "$version" == "" ]; then
		pip3 download --no-binary=:all: "$package" -d "python-packages/$package"
	else
		pip3 download --no-binary=:all: "$package==$version" -d "python-packages/$package"
	fi
	py2dsc-deb -d "python-packages/$package/deb_dist" python-packages/"$package"/"$package"*.tar.gz
	cp python-packages/"$package"/deb_dist/*.deb packages/
done

cd packages
tar czf ../opsi-packages.tar.gz * 
cd ..

rm -rf packages
rm -rf manager/*opsi*
rm -rf python-packages
