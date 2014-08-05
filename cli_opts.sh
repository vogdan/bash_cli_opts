#!/bin/bash


usage () {
    echo "usage: ourappstart -a APP_NAME -e ENVIRONMENT -u USER"
    exit
}

echo_err_help () {
    echo "$1" >&2
    usage
    exit 1
}

# cli options
aflag=false eflag=false uflag=false
options=":ha:e:u:"
while getopts $options OPTION; do
    case $OPTION in
        a)
            aflag=true
            APP=$OPTARG
            ;;
        e) 
            eflag=true
            ENV=$OPTARG
            ;;
        u) 
            uflag=true
            USR=$OPTARG
            ;;
        h) 
            usage 
            ;;
        \?) 
            echo_err_help "Unknown option: -$OPTARG"
            ;;
        :) 
            echo_err_help "Missing option argument for -$OPTARG" 
            ;;
        *) 
            echo_err_help "Unimplemented option: -$OPTARG" 
            ;;
    esac
done

shift $((OPTIND - 1))

if ! $aflag || ! $eflag || ! $uflag; then
    echo_err_help "ERROR: All arguments are mandatory."
fi
