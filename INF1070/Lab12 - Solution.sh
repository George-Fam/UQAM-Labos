#!/bin/sh

# Couleurs
RED='\033[1;31m'
NOCOLOR='\033[0m'

NBR_ARGS=1
CODE_ERR=1

# REGEX
REGEX_ENTIER_POS="+?[0-9]+"

# Facteurs
FCT_FOOBAR=12
FCT_FOO=3
FCT_BAR=4

# Messages d'erreurs
MSG_ERR_NBR_ARG="foobar prend un seul argument"
MSG_ERR_ENTIER="$1 n'est pas un entier positif"


# Affiche erreur en rouge et quitte avec code d'erreur
exit_erreur() {
   echo "${RED}Erreur: $1${NOCOLOR}" >&2
   exit $CODE_ERR
}

# Affiche foobar, foo, bar ou chiffre (si divisible par 12, 4, 3)
foobar() {
   if [ $(($1 % $FCT_FOOBAR)) -eq 0 ]; then
      echo "foobar"
   elif [ $(($1 % $FCT_FOO)) -eq 0 ]; then
      echo "foo"
   elif [ $(($1 % $FCT_BAR)) -eq 0  ]; then
      echo "bar"
   else
      echo "$1"
   fi
}

# Gestion du nbr d'argument
if [ "$#" -ne "$NBR_ARGS" ]; then
   exit_erreur "$MSG_ERR_NBR_ARG"
fi

# Gestion argument non entier positif
echo "$1" | grep $REGEX_ENTIER_POS -Exvq && exit_erreur "$MSG_ERR_ENTIER"

# AVEC FOR
#for i in $(seq $1)
#do
#   foobar $i
#done

# While
i=1
while [ "$i" -le "$1" ];
do
   foobar "$i"
   i=$(( i + 1 )) # i++
done

exit 0
