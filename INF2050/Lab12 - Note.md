### Raccourci pour clonage

Ce bloc de commandes permet de cloner uniquement une petite partie d’un dépôt Git, au lieu de télécharger tout le dépôt complet.
Cela est utile lorsque le dépôt contient beaucoup de laboratoires, mais que vous n’avez besoin que de deux dossiers spécifiques.

```
git clone --no-checkout https://gitlab.info.uqam.ca/inf2050/labs.git Lab11
cd Lab11
git sparse-checkout init --cone
git sparse-checkout set l12/PrimeChecker
git checkout main
```