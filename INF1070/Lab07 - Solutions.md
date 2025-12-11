# Solutions Lab 7 : REGEX

### Exercice 1: Recherche REGEX dans dictionnaire french
- On va utiliser grep et l'option, -c, pour voir le compte d'occurence si on veut. 
- Installez wfrench si pas encore installé: `sudo apt install wfrench`.

1. Mots contenant 'titi':
	- `grep 'titi' french`	
2. Mots contenant 2x fois ren avec une seule lettre entre les deux ren
	- `grep 'ren.ren' french`
	- ERE: `grep -E '(ren).\1' french`
3. Mots contenant un « k » et plus loin un « w »
	- `grep 'k.*w' french`
4. Mots contenant un « k » et « w » dans n'importe quel ordre.
	- `grep -e 'k.*w' -e 'w.*k' french`
		-  option e pour permettre plusieurs motifs BRE
5. Mots finissant par latif
	- `grep 'latif$' french`
6. Mots commencant et finissant par dé
	- `grep '^dé.*dé$' french`
7. Mots de 10 lettre commencent et finissant par ent 
	- Option 1: `grep '^ent....ent$' french` EN BRE
	- Option 2: `grep '^ent.\{4\}ent$' french` EN BRE (échapement(rend littérale en expression) de { et } avec \)
	- Option 3: `grep -E '^ent.{4}ent$' french` EN ERE 
8. Mots finissant par « st » mais ne contiennent pas d'autre « s » ou « t »
	- `grep '^[^st]*st$' french`
9. Mots contient trois trais d'union (« - »)
	- Option 1: `grep '\-.*\-.*\-' french`
	- Option 2: `grep -E '(\-.*){3}' french` 
		- Équivalent BRE: `grep '\(\-.*\)\{3\}' french`
			- Échapement de parenthèse pour groupe et d'accolades pour répetition
10. Mots contenat trois e séparés par des t en ignorant0 les accents.
	- Option 1: `grep '[eéèê]t\+[eéèê]t\+[eéèê]' french`
	- Option 2: Classe d'équivalence `[[=e=]]`
		- `grep '[[=e=]]t\+[[=e=]]t\+[[=e=]]' french`
		- `grep -E '[[=e=]]t+[[=e=]]t+[[=e=]]' french`
11. Dernière lettre plus fréquente
	- `grep -o '.$' french | sort | uniq -c | sort -nrk 1 | head -n 1`
		- Option o de grep affiche seulement ce qui est trouvé par le motif, dernière lettre.
		- Puis, on trie et on compte les uniques.
		- Finalement, on trie les comptes (première colonne (option k)) en ordre décroissant (option r) de façon numérique (option n)
12. Avant dernière lettre la plus fréquente
	- `grep -o '..$' french | grep -o "^." | sort | uniq -c | sort -nrk 1`

### Exercice 2: RegexOne (1 à 5)
- 1.`abc`
	- Match les caractères en commun (abc)
- 1.5 `123`
	- Match les nombres en commun (123)
- 2. `\.`
	- Match un point littérale.
- 3. `[cmf]an` ou `[^drp]an`
	- Match premiers lettres suivis de an
- 4. `[^b]og`
	- Match premier lettre (sauf b) suivi de og.
- 5. `[A-C][n-p][a-c]` ou `[A-Z][a-z][a-z]`
	- Match caractères ou match majuscule, minuscule, minuscule.
	
### Exercice 3: man grep
1. `/PCRE`
2. `/\{n?,?m?\}`
3. `-i` puis `/-[A-Z]`
4. Revenir en mode insensible à casse (`-i`) puis `/--.*=`