
cd ~/Documents/Development/git/f100l
git checkout master
git branch -D gh-pages

rm -rf _modules _sources _static doc genindex.html index.html objects.inv py-modindex.html search.html searchindex.js .nojekyll

git checkout master
git pull
git checkout -b gh-pages
cp -r src/_build/html/* .
cp -r src/_build/html/.nojekyll .
git add _modules _sources _static doc genindex.html index.html objects.inv py-modindex.html search.html searchindex.js .nojekyll
git commit -m "checkin documentation"
rm -rf src/_build
git pull
git push origin gh-pages



