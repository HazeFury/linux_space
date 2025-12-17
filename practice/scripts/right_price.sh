#!/bin/bash

NB_TO_GUESS=$RANDOM

echo "--------------------------------------------------------"
echo "----------- Bienvenue au jeu du Juste Prix -------------"
printf "\n"
echo "Entrez un nombre pour commencer à jouer"
printf '\n'

read PLAYER_NB

while [[ "$PLAYER_NB" -ne "$NB_TO_GUESS" ]]
do
	if [[ "$PLAYER_NB" -gt "$NB_TO_GUESS" ]]; then
		printf "c'est moins !\n"
		printf "Entrez un autre nombre\n"
		read PLAYER_NB
	elif [[ "$PLAYER_NB" -lt "$NB_TO_GUESS" ]]; then
		echo "c'est plus ! "
		printf "Entrez un autre nombre\n"
		read PLAYER_NB
	elif [[ "$PLAYER_NB" -eq "$NB_TO_GUESS" ]]; then
		printf ">>>>>>>>>> C'est GAGNÉ !!! BRAVO =)  <<<<<<<<<<<"
		break
	else 
		echo "Une erreur est survenu"
		exit 1
	fi
done

printf "\nLe nombre à trouvé était : $NB_TO_GUESS\n"
printf "bien joué ;)"
