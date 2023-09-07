# Cryptographie

Notes de cours par `Thomas Peugnet`.

# 2. Chiffrement [...]

## Introduction

## Chiffrement par flot continu

![15-Schéma de chiffrement par flux | Download Scientific Diagram](./assets/Schema-de-chiffrement-par-flux.png)

Chiffrement synchrone et asynchrone.

![image-20230907134113654](./assets/image-20230907134113654-4086874.png)

Si la flèche en pointillés est utilisée, alors le chiffrement est synchrone.

#### Les nombres aléatoires

La génération des nombres aléatoires est une fonction principale des algorithmes de chiffrement.

> Quelques usages :
>
> - Génération de clés RSA
> - Génération des clés de Session
> - Distributino des clés et authentification mutuelle (nonce - antirejeu)

Il existe deux exigences distinctes pour une séquence de nombres aléatoires :

- Aléatoire
- Imprévisibilité

Par ailleurs, deux critères sont utilisés pour valider qu'une séquence de nombres est aléatoire : 

- Distribution **uniforme** : La fréquence d'apparition des 1 et des 0 doit être approximativement égale
- **Indépendance** : Aucune **sous-séquence** de la séquence [...] `notes manquantes`.

#### Génération de nombres aléatoires

![Pseudo Random Number Generators - ppt download](./assets/Structures+of+Random+Number+Generation.jpg)

 

### Chiffrement par bloc

On ne peut pas chiffrer bit par bit, on doit avoir une taille de bloc prédéfinie (128bits par exemple).

![Padding oracle - hackndo](./assets/sc1.png)