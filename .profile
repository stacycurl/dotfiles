function prependToPath {
	PATH=$1:$( echo ${PATH} | tr -s ":" "\n" | grep -vwE "($1)" | tr -s "\n" ":" | sed "s/:$//" )
}
