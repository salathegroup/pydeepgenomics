#!/usr/bin/env bash
cp ./requirements.txt ./docs/source/requirements.rst
cd docs
sphinx-apidoc -d 3 -f -e -o ./source ../pydeepgenomics/preprocess
sphinx-apidoc -d 3 -f -e -o ./source ../pydeepgenomics/tools
sphinx-apidoc -d 3 -f -e -o ./source ../alltests
make clean
make html
cd ..
# commit and push
echo add
git add -A
echo commit
git commit -m "building and pushing docs"
echo push master
git push origin master
# switch branches and pull the data we want
git checkout gh-pages
rm -rf .
touch .nojekyll
git checkout master docs/build/html
mv ./docs/build/html/* ./
rm -rf ./docs
git add -A
git commit -m "publishing updated docs..."
git push origin gh-pages
# switch back
git checkout master