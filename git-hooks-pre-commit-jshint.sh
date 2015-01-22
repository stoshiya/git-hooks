#!/bin/bash
#
# Run JSHint validation before commit.

files=$(git diff --cached --name-only --diff-filter=ACMR -- *.js **/*.js)
pass=true

# JSHint
if [ "$files" != "" ]; then
    for file in ${files}; do
        jshint ${file}
        if [[ $? -ne 0 ]]; then
            pass=false
        fi
    done
fi

if $pass; then
    exit 0
else
    echo ""
    echo "COMMIT FAILED:"
    echo "Some JavaScript files are invalid. Please fix errors and try committing again."
    exit 1
fi

