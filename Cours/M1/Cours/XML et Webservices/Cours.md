# XML - Extensible Markup Language

 Notes de cours par `Thomas Peugnet`.

# Partie 1 - Le standard XML

## Objectifs

Langage facilement lisible, compatible web, permettant, de façon standardisée, la séparation des aspects suivants : 

- Présentation (formats, couleurs etc.)
- Information (données)

## Pourquoi XML ?

Il existe actuellement deux formats principaux :

- HTML - HyperText Markup Language
- SGML (peu utilisé) - Standard Generalized Blabla Blabla

### Définition intuitive de XML

Le XML est une variante de HTML généralisé.

Le langage possède une structure à balise configurable.

## Structure d'un document XML

**Prologue** :

- Équivalent du `<head>` en HTML
- Meta informations (instructions de traitement & commentaires)
- `<?xml version="1.0" encoding="UTF-8"?>`
  - `standalone` - `yes` ou `no`

**Corps** : 

1. **Élément/Balise** : `<nom_de_l'élément>`
   - **Description** : Les éléments fondamentaux d'un document XML.
   - **Utilisation** : Utilisés pour définir les éléments de données dans la structure XML.
   - **Attributs** : Peuvent avoir des attributs fournissant des informations supplémentaires sur l'élément.
   - **Nesting** : Peuvent être imbriqués à l'intérieur d'autres éléments.
2. **Attribut** : `<nom_de_l'élément nom_de_l'attribut="valeur">`
   - **Description** : Fournit des informations supplémentaires sur un élément XML.
   - **Utilisation** : Utilisé pour ajouter des métadonnées ou des caractéristiques aux éléments.
   - **Valeur** : Contient la valeur de l'attribut, entre guillemets doubles.
3. **Déclaration XML** : `<?xml version="1.0" encoding="UTF-8"?>`
   - **Description** : Spécifie la version et l'encodage du document XML.
   - **Utilisation** : Apparaît au début d'un document XML.
   - **Attributs** : `version` et `encoding` sont des attributs courants.
4. **Commentaire** : `<!-- Ceci est un commentaire -->`
   - **Description** : Permet aux développeurs d'ajouter des commentaires dans le document XML.
   - **Utilisation** : Utilisé pour la documentation ou les explications.
   - **Format** : Encadré entre `<!--` et `-->`.
5. **Section CDATA** : `<![CDATA[ Certains caractères spéciaux & < > peuvent être utilisés ici ]]>`
   - **Description** : Échappe les caractères spéciaux et permet le texte brut.
   - **Utilisation** : Utile lorsque vous souhaitez inclure des caractères qui pourraient autrement être traités comme une balise XML.
   - **Format** : Encadré entre `<![CDATA[` et `]]>`.
6. **Déclaration de Type de Document (DTD)** : `<!DOCTYPE nom_de_l'élément_racine SYSTEM "fichier_dtd.dtd">`
   - **Description** : Définit la structure du document XML.
   - **Utilisation** : Apparaît au début d'un document XML.
   - **Référence** : Pointe vers un fichier DTD externe ou inclut un DTD interne.
7. **Déclaration d'Espace de Noms** : `xmlns:préfixe="URI_de_l'espace_de_noms"`
   - **Description** : Définit les espaces de noms XML pour éviter les conflits de noms.
   - **Utilisation** : Généralement déclaré dans l'élément racine.
   - **Format** : `xmlns` suivi d'un préfixe d'espace de noms et d'une URI.

### Exemple

```xml
<?xml version="1.0" encoding="UTF-8"?>
<website>
    <company category="geeksforgeeks">
        <title>Machine learning</title>
        <author>aarti majumdar</author>
        <year>2022</year>
    </company>
    <company category="geeksforgeeks">
        <title>Web Development</title>
        <author>aarti majumdar</author>
        <year>2022</year>
    </company>
    <company category="geeksforgeekse">
        <title>XML</title>
        <author>aarti majumdar</author>
        <year>2022</year>
    </company>
</website>
```

## 

# Partie 3 - Mise en forme, traitement et transformations