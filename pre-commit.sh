#!/bin/sh
GOOGLE_CLOSURE_PATH='/svn/staging/jsCompiler.jar'

echo "$(tput bold)SUMMARY$(tput sgr0)"
git diff --cached --name-status | cat 
echo ''
echo "$(tput bold)STAT$(tput sgr0)"
git diff --cached --stat | cat
echo ''

CanCommit=1

# Get the list of file name
FileModified=$(git diff --cached --name-only)

echo "$(tput bold)VALIDATION$(tput sgr0)"

# for each file run the chceck based on their type
for File in $FileModified
do
    error=0
    errorMsg=''
    
    # extract file extension
    filename=$(basename "$File")
    FileExtension=${filename##*.}

    case $FileExtension in
        "php")
        # run basic PHP -l syntax checker
            errorMsg=$(php -l $File)
            if [ ! $? = 0 ]
            then
                error=1
            fi
            ;;
        "js")
        # JS run google closure compiler for syntax error
        # Detect console. statement to warn the user
            # summary_detail_level 1
            # warning_level VERBOSE
            errorMsg=$(java -jar $GOOGLE_CLOSURE_PATH --js $File 2>&1)
            if [ ! $? = 0 ]
            then
                error=1
            fi


            ;;
    esac

    if [ $error = 1 ]
    then
        echo -n "$(tput bold)$(tput setaf 1)[FAIL]$(tput sgr0)"
        CanCommit=0
    else
        echo -n "$(tput bold)$(tput setaf 2)[GOOD]$(tput sgr0)"
    fi
    echo " $File"
    if [ $error = 1 ]
    then
        echo "\t$(tput setaf 1)$errorMsg$(tput sgr0)"
    fi
done

echo ""
echo "$(tput bold)FINISH$(tput sgr0)"
if [ $CanCommit = 1 ]
then
    echo "$(tput bold)$(tput setaf 2)COMMIT VALID$(tput sgr0) Good Job!"
    exit 0
else
    echo "$(tput bold)$(tput setaf 1)COMMIT INVALID$(tput sgr0) SUCKA! CHECK LOG TO SEE WHERE YOU FAILED"
    exit 1
fi
