#!/usr/bin/env bash

# Comment

function myfunction() {
    echo 'You called myfunction()'
}

VARIABLE_NAME=`hostname`

case ${VARIABLE_NAME} in
    localhost)
        echo "So you're local."
        myfunction();
        ;;
    *)
        echo ${VARIABLE_NAME}
esac

exit
