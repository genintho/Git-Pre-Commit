Git-Pre-Commit
==============

A small pre-commit to validate your code. Used for PHP and JavaScript development

This hooks is going to use the PHP syntax checker and Google closure compiler to make sure
that your code doesn't contain stupid syntax error before you commit them in your Git repo.


Installation
==============

Download pre-commit.sh
Move it into the /.git/hooks/ directory
Edit the file and update the path to the Google Closure compiler JAR line 3.
Make sure git can execute the script ( chmod a+x )
Enjoy