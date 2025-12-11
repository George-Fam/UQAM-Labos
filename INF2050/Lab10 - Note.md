# Lab 10

### Raccourci pour Utilisateurs Windows

Si vous êtes sous Windows, supprimez le \ et écrivez la commande sur une seule ligne. Protégez chaque argument en l'encapsulant dans des "", par exemple "-DgroupId=ca.uqam.info".

```
mvn archetype:generate `
"-DgroupId=ca.uqam.info" `
"-DartifactId=CiTestProject" `
"-DarchetypeArtifactId =maven-archetype-quickstart" `
"-DinteractiveMode=false"
```

### Solution Projet CI
- [Solution](https://gitlab.info.uqam.ca/fam.george/inf250lab10)