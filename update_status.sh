if [ "x$REPO_BUILD_ROOT" = "x" ] ; then
    REPO_BUILD_ROOT="`pwd`"
fi
export REPO_BUILD_ROOT

update_status() {
    local p="$1"
    local s="$2"

    case "${TERM}" in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen*)
        :
        ;;
    *)
        return 0
        ;;
    esac

    mkdir -p "${REPO_BUILD_ROOT}/tmp"
    if [ "x$s" = "x" ] ; then
        echo -n "" > "${REPO_BUILD_ROOT}/tmp/${p}.status"
    else
        echo -n "[${2}]${1}    " > "${REPO_BUILD_ROOT}/tmp/${p}.status"
    fi

    local title="`(cd "${REPO_BUILD_ROOT}/tmp/" && cat *.status)`"

    if test -t 2 ; then
        echo -ne "\033]0;${title}\007" >&2
    elif test -t 1 ; then
        echo -ne "\033]0;${title}\007" >&2
    fi
}

