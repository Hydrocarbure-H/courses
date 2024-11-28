# Architecture Sécurisé

Notes de cours par `Thomas PEUGNET`.

# Rendu LAB01

## Questions

>  Qu'est-ce qu'un keylogger ?

Un keylogger est un programme qui enregistre les frappes au clavier. Il existe 2 types de keyloggers, matériel et logiciels. Le premier type est comme un adaptateur inséré entre le clavier et l'ordinateur, qui intercepte et enregistrent les frappes directement au niveau matériel. Le second type est un programme informatique qui surveille et enregistre les frappes au clavier en s'exécutant en arrière-plan sur le système d'exploitation.

> Y a-t-il une utilisation légitime pour ce genre de programme ? Expliquez.

Oui, un keylogger peut avoir des utilisations légitimes lorsqu'il est déployé de manière éthique et avec consentement.

> Quel est le rôle du paramètre `on_press` ?

Nous avons le code suivant:
```python
from pynput import keyboard

def processkeys(key):
    print(f"Touche appuyée : {key}")

with keyboard.Listener(on_press=processkeys) as keyboard_listener:
    keyboard_listener.join()
```

Le paramètre `on_press` désigne la fonction qui sera appelée à chaque fois qu'une touche est pressée. Elle permet de spécifier le traitement à effectuer pour chaque frappe.

Nous pouvons constater que cela fonctionne parfaitement.

![image-20241128084526452](./assets/image-20241128084526452.png)

> Quel est le rôle des instructions avec le `with`?

Ces instructions permettent de démarrer le keylogger. La méthode `keyboard.Listener` initialise l'écoute, et `keyboard_listener.join()` maintient le programme en fonctionnement jusqu'à ce que l'utilisateur fasse un kill explicite du programme.



