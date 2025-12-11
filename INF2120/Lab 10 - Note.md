Petite mise au point concernant la fonction insererOrdreCroissant : il existe plusieurs façons valides d’implémenter l’insertion dans une liste simplement chaînée triée.

Je préfèrre insèrer toujours après le maillon courant, puis effectue un petit échange de valeurs si nécessaire. L’objectif de cette approche est de réduire la complexité des conditions et de garder une structure de fonction simple, avec **un seul return**.

Certains d’entre vous vont être tenté d'examiner `suivant()` pour insérer directement au bon endroit. Cette solution est tout à fait correcte ; elle devient simplement un peu plus imbriquée lorsqu’on veut gérer proprement tous les cas (début, milieu, fin) tout en conservant un seul point de sortie (**un seul return**).

Voici les deux versions — chacune avec un seul return :

**VERSION 1:** Insertion et échange conditionnel
```java
public static Maillon<String> insererOrdreCroissant(Maillon<String> debut, String valeur) {
    Maillon<String> retour = debut;
    Maillon<String> nouveau = new Maillon<>(valeur);
    String s;    
    
    if (debut != null && valeur != null) {
        // recherche lineaire
        while (debut.suivant() != null && debut.info().compareTo(valeur) < 0){
            debut = debut.suivant();
         }
        // insertion
        nouveau.modifierSuivant(debut.suivant());
        debut.modifierSuivant(nouveau);
        //echange conditionnel
        if (debut.info().compareTo(valeur) > 0) {
            s = nouveau.info();
            nouveau.modifierInfo(debut.info());
            debut.modifierInfo(s);
        }
    }
    return retour;
}
```

**VERSION 2:** Vérification de `suivant()` (sans échange)
```java
public static Maillon<String> insererOrdreCroissant(Maillon<String> debut, String valeur) {
    Maillon<String> retour = debut;
    Maillon<String> nouveau = new Maillon<>(valeur);

    if (valeur != null) {
        // Cas spécial : insertion au début
        if (debut == null || valeur.compareTo(debut.info()) < 0) {
            nouveau.modifierSuivant(debut);
            retour = nouveau;
        } else {
            while (debut.suivant() != null && debut.suivant().info().compareTo(valeur) < 0){
                debut = debut.suivant();
            }

            nouveau.modifierSuivant(debut.suivant());
            debut.modifierSuivant(nouveau);
        }
    }

    return retour;
}
```
Notez le niveau d’imbrication légèrement plus élevé dans la recherche.

Pour terminer, voici une version plus lisible (selon certains), qui utilise des return multiples ou break – **mais qui est découragée dans ce cours**.

**Version 3:**  Vérification de suivant (sans échange) avec retours conditionnels
```java
public static Maillon<String> insererOrdreCroissant(Maillon<String> debut, String valeur) {
    Maillon<String> courant = debut;
    Maillon<String> nouveau = new Maillon<>(valeur);    
    
    if (valeur == null) return debut;

    if (debut == null || valeur.compareTo(debut.info()) < 0) {
        nouveau.modifierSuivant(debut);
        return nouveau;
    }
    
    while(courant != null) {
        if (courant.suivant() == null || courant.suivant().info().compareTo(valeur) >= 0) {
            nouveau.modifierSuivant(courant.suivant());
            courant.modifierSuivant(nouveau);
            break;
        }
        courant = courant.suivant();
    }

    return debut;
}
```