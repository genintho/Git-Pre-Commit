#s!/bin/sh

echo "install start"
echo "Create Dev Tool Dir"
mkdir ~/DevTools
cd DevTools
echo "Fetch Git Repo"
git clone git@github.com:genintho/Git-Pre-Commit.git
cd Git-Pre-Commit
"Init git commit"
ln ./pre-commit.sh /expensify/staging/www/git/expensify.com/.git/hooks/pre-commit
cd ~
echo "install is over"

