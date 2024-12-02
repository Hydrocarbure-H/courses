# Sécurité Cloud

# Rendu TP01

## Préparation

Nous commençons par installer AWS CLI avec les commandes suivantes:

![image-20241113085750529](./assets/image-20241113085750529.png)

Nous poursuivons avec les étapes d'inscription à l'offre gratuite de AWS.

![image-20241113090333514](./assets/image-20241113090333514.png)

Nous activons la MFA depuis les recommandations de la section IAM. Nous configurons notre application Google Authenticator.

![image-20241113092426946](./assets/image-20241113092426946.png)

## Gestion des utilisateurs avec IAM

Nous créons un utilisateur `test-user-1`.

![image-20241113093028033](./assets/image-20241113093028033.png)

Nous activons l'accès à la console.

![image-20241113093135745](./assets/image-20241113093135745.png)

On effectue une connexion sur le lien de connexion fourni lors de l'activation de l'accès console.

![image-20241113093516289](./assets/image-20241113093516289.png)

On se deconnecte du compte `test-user-1`, on se reconnecte avec le compte `root` et on ajoute une politique d'autorisation pour l'utilisateur `test-user-1`.

![image-20241113093814300](./assets/image-20241113093814300.png)

On ajoute le code indiqué dans le sujet du TP, donnant donc le JSON complet suivant:

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
            "Sid": "s3fullaccess",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
	]
}	
```

Nous créons notre politique `S3FullAccess`.

![image-20241113094152293](./assets/image-20241113094152293.png)

Nous nous connectons ensuite au service IAM Policy Simulator grâce à l'URL https://policysim.aws.amazon.com/home/index.jsp.

![image-20241113094258379](./assets/image-20241113094258379.png)

Après avoir sélectionné notre utilisateur et les 160 actions possibles sur `AmazonS3`, nous avons bien le résultat suivant:

![image-20241113094446434](./assets/image-20241113094446434.png)

Nous ajoutons ensuite la politique d'autorisation `AmazonEC2ReadOnlyAccess` à l'utilisateur `test-user-1`.

![image-20241113094657277](./assets/image-20241113094657277.png)

Nous pouvons constater que notre utilisateur a bien une nouvelle politique d'autorisation.

![image-20241113094749184](./assets/image-20241113094749184.png)

Nous retournons ensuite sur le IAM Policy Simulator et testons les politiques avec notre utilisateur `test-user-1` et `Amazon EC2`.

![image-20241113094915367](./assets/image-20241113094915367.png)

Nous finissons ce TP en supprimant notre utilisateur `test-user-1`.

![image-20241113095144236](./assets/image-20241113095144236.png)

Nous constatons que notre politique `S3FullAccess` a bien été supprimée.

![image-20241113095257077](./assets/image-20241113095257077.png)

# Rendu TP02

Ce TP a été réalisé par `Thomas PEUGNET`.

## Sécurisation du compte AWS

Nous configurons une Alert Preference.

![image-20241113112347043](./assets/image-20241113112347043.png)

Nous mettons à jour la politique par défaut.

![image-20241113112610707](./assets/image-20241113112610707.png)

Nous créons un budget mensuel de 5$.

![image-20241113112743425](./assets/image-20241113112743425.png)

Nous activons l'accès des utilisateurs IAM aux informations de facturation.

![image-20241113112856804](./assets/image-20241113112856804.png)

Nous ajoutons un groupe **facturation** et nous le rattachons aux permissions `Billing`.

![image-20241113113025267](./assets/image-20241113113025267.png)

Nous créons un utilisateur `Mathias` et le mettons dans le groupe **facturation**.

![image-20241113113136605](./assets/image-20241113113136605.png)

Nous activons l'accès console pour notre utilisateur.

![image-20241113113310670](./assets/image-20241113113310670.png)

Nous créons un utilisatateur `thomaspeu`, l'attachons à la politique `AdminAccess` et lui activons son accès console.

![image-20241113113530641](./assets/image-20241113113530641.png)

![image-20241113113701479](./assets/image-20241113113701479.png)

Nous activons l'utilisation de la MFA pour cet utilisateur et nous reconnectons avec ce dernier.

Nous pouvons constater que nous avons bien toutes les permissions nécessaires.

![image-20241113114110832](./assets/image-20241113114110832.png)

Nous créons un alias `thomas-peugnet` pour notre compte AWS et nous reconnectons.

![image-20241113114451912](./assets/image-20241113114451912.png)

Nous créons le groupe `Admin` et y ajoutons notre utilisateur.

![image-20241113114545739](./assets/image-20241113114545739.png)

Nous créons maintenant une politique pour rester dans le Free Tier qui aura le JSON suivant. Son objectif est d'interdire le lancement des VM si elles ne sont pas dans la région de Paris.

```json
{
	"Version": "2012-10-17",
	"Statement": [
                    {
                        "Effect": "Deny",
                        "Action": "ec2:RunInstances", 
                        "Resource": "*",
                        "Condition": {
                            "StringNotEquals": { 
                                "aws:RequestedRegion": "eu-west-3"
                            }
                        }
                    }
	]
}
```

![image-20241113114940055](./assets/image-20241113114940055.png)

Nous attachons cette nouvelle politique `allow-only-paris-region` à notre groupe `Admin`.

![image-20241113115045986](./assets/image-20241113115045986.png)

Nous testons de lancer une instance `t2.micro` hors de France (Frankfurt).

![image-20241113115251982](./assets/image-20241113115251982.png)

Comme prévu, nous avons un message d'erreur.

![image-20241113115307283](./assets/image-20241113115307283.png)



Nous créons ensuite la politique `allow-only-t2-micro` ayant pour objectif d'interdire le lancement de VM différentes du type `t2.micro`. Cette politique aura le JSON suivant:

```json
{
	"Version": "2012-10-17",
	"Statement": [
                    {
                        "Effect": "Deny",
                        "Action": "ec2:RunInstances", 
                        "Resource": "*",
                        "Condition": {
                            "StringNotEquals": { 
                                "ec2:InstanceType": "t2.micro"                            
                            }
                        }
                    }
	]
}
```

Nous associons cette nouvelle politique à notre groupe `Admin`.

![image-20241113115646539](./assets/image-20241113115646539.png)

Nous testons notre politique avec le lancement d'une instance t2.micro en se situant dans la région Paris.

![image-20241113115749682](./assets/image-20241113115749682.png)

Nous obtenons, comme prévu, un message d'erreur.

![image-20241113115801790](./assets/image-20241113115801790.png)

Nous allons maintenant gérer les autorisations AWS en nous basans sur les attributs.

Nous créons une Politique `EC2limitedAccess` avec le JSON suivant:

```json
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "ec2:DescribeInstances",
            "ec2:DescribeImages",
            "ec2:DescribeTags"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "ec2:RebootInstances",
            "ec2:StartInstances",
            "ec2:StopInstances"
         ],
         "Resource":"*",
         "Condition":{
            "StringEquals":{
               "aws:PrincipalTag/Department":"EC2Admins",
               "ec2:ResourceTag/Environment":"Production"
            }
         }
      }
   ]
}
```

![image-20241119132445639](./assets/image-20241119132445639.png)

Nous créons ensuite un utilisateur nommé `testABAC` auquel nous assignons la politique `EC2limitedAccess`. Nous assignons également les tags suivant:

- `key` = Department
- `value` = EC2Admins

![image-20241119132719024](./assets/image-20241119132719024.png)

Nous lançons ensuite nos 2 instances EC2 avec les tags `Environment:Production` et `Environment:Development`.

![image-20241119140014623](./assets/image-20241119140014623.png)

Nous nous reconnectons avec l'utilisateur `testABAC` et constatons que nous pouvons bien redémarrer l'instance de Production mais pas celle de Developpement.

![image-20241119140352461](./assets/image-20241119140352461.png)

# Rendu TP03

Rendu du TP03 effectué par `Thomas PEUGNET`.

Nous créons l'utilisateur Joanne.

![image-20241202132020756](./assets/image-20241202132020756.png)

![image-20241202132304784](./assets/image-20241202132304784.png)

Nous nous reconnectons avec `Joanne ` et constatons le résultat suivant:

![image-20241202132357549](./assets/image-20241202132357549.png)

Nous créons un bucket S3.

![image-20241202132705272](./assets/image-20241202132705272.png)

Nous créons la policy avec le contenu suivant.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "IAMAccess",
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": "*"
        },
        {
            "Sid": "DenyPermBoundaryIAMPolicyAlteration",
            "Effect": "Deny",
            "Action": [
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:CreatePolicyVersion",
                "iam:SetDefaultPolicyVersion"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:policy/PermissionsBoundary"
            ]
        },
        {
            "Sid": "DenyRemovalOfPermBoundaryFromAnyUserOrRole",
            "Effect": "Deny",
            "Action": [
                "iam:DeleteUserPermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        },
        {
            "Sid": "DenyAccessIfRequiredPermBoundaryIsNotBeingApplied",
            "Effect": "Deny",
            "Action": [
                "iam:PutUserPermissionsBoundary",
                "iam:PutRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        },
        {
            "Sid": "DenyUserAndRoleCreationWithOutPermBoundary",
            "Effect": "Deny",
            "Action": [
                "iam:CreateUser",
                "iam:CreateRole"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        }
    ]
}
```

![image-20241202133313526](./assets/image-20241202133313526.png)

Nous créons un utilisateur `BadUSER`.

![image-20241202133528697](./assets/image-20241202133528697.png)

Nous nous connectons avec et constatons le résultat suivant.

![image-20241202133715337](./assets/image-20241202133715337.png)

![image-20241202133733828](./assets/image-20241202133733828.png)

![image-20241202133934309](./assets/image-20241202133934309.png)

Nous allons effectuer une escalade de privilèges avec un nouvel utilisateur `testThomas1`.

![image-20241202134047521](./assets/image-20241202134047521.png)

Nous nous reconnectons avec ce nouvel utilisateur et constatons que nous avons maintenant accès.

![image-20241202134204924](./assets/image-20241202134204924.png)

Nous appliquons `PermissionsBoundary` à notre utilisateur `BadUSER`.

![image-20241202134335069](./assets/image-20241202134335069.png)

Nous nous reconnectons avec l'utilisateur `BadUSER` et tentons de supprimer permissions boundary.

![image-20241202134511953](./assets/image-20241202134511953.png)

Nous obtenons le retour suivant.

![image-20241202134525597](./assets/image-20241202134525597.png)

Nous tentons de modifier la politique pour obtenir `AdministratorAccess`.

![image-20241202134802560](./assets/image-20241202134802560.png)

Nous tentons de recréer un nouvel utilisateur et obtenons le résultat suivant.

![image-20241202134917881](./assets/image-20241202134917881.png)

Nous assignons notre `PermissionBoundary` à cet utilisateur et pouvons en effet le créer.

![image-20241202135035136](./assets/image-20241202135035136.png)

Nous pouvons confirmer que l'utilisateur `testThomas2` ne peut pas accéder aux EC2.

![image-20241202135035136](./assets/other.png)

# Rendu TP04

Rendu de TP04 effectué par `Thomas PEUGNET`.

![image-20241202135844631](./assets/image-20241202135844631.png)

Nous créons un AWS account avec cet email: `fedikay342@nausard.com`

![image-20241202140054796](./assets/image-20241202140054796.png)

# Rendu TP05

Rendu de TP05 a été effectué par `Thomas PEUGNET`.

Nous créons un VPC.

![image-20241202140413066](./assets/image-20241202140413066.png)

Nous créons nos 3 subnets.

![image-20241202140909318](./assets/image-20241202140909318.png)

Nous créons notre table de routage.

![image-20241202140946435](./assets/image-20241202140946435.png)

Nous associons les subnets suivant à cette table de routage.

![image-20241202141036987](./assets/image-20241202141036987.png)

De même avec notre `Private RT` routing table.

![image-20241202141152343](./assets/image-20241202141152343.png)

Nous créons notre Internet Gateway.

![image-20241202141236498](./assets/image-20241202141236498.png)

Nous l'attachons à notre VPC.

![image-20241202141320967](./assets/image-20241202141320967.png)

Nous ajoutons une nouvelle route pour `0.0.0.0/0`.

![image-20241202141530670](./assets/image-20241202141530670.png)

Nous activons les hostnames DNS.

![image-20241202141631646](./assets/image-20241202141631646.png)

Nous lançons notre instance EC2.

![image-20241202143138838](./assets/image-20241202143138838.png)

![image-20241202142041540](./assets/image-20241202142041540.png)

Nous avons donc l'instance suivante.

![image-20241202142121873](./assets/image-20241202142121873.png)

La machine ne répond pas aux ping depuis son IP publique.

![image-20241202142225850](./assets/image-20241202142225850.png)

Nous pouvons nous connecter à notre instance via SSH.

![image-20241202142418303](./assets/image-20241202142418303.png)

Nous avons en effet la bonne adresse IP.

![image-20241202143231113](./assets/image-20241202143231113.png)

Nous lançons une nouvelle instance.

![image-20241202143421935](./assets/image-20241202143421935.png)

Depuis la première instance, nous nous connectons sur la nouvelle avec les commandes suivantes.

- Envoi de la clé privé envoyée par AWS sur l'instance de rebond
- Utilisation de cette clé depuis l'instance de rebond pour se connecter à la nouvelle instance dans le réseau privé.

![image-20241202143738800](./assets/image-20241202143738800.png)



Nous avons en effet la bonne adresse IP : `10.150.2.66`

![image-20241202143923558](./assets/image-20241202143923558.png)

![image-20241202143936852](./assets/image-20241202143936852.png)

La VM privée n'a effectivement pas accès à Internet.

![image-20241202144010946](./assets/image-20241202144010946.png)

Nous supprimons les VMs.

![image-20241202144047157](./assets/image-20241202144047157.png)

Nous supprimons le VPC.

![image-20241202144156233](./assets/image-20241202144156233.png)

# Rendu TP06

Rendu de TP06 effectué par `Thomas PEUGNET`.

Nous créons notre instance.

![image-20241202144535121](./assets/image-20241202144535121.png)

Nous nous connectons en SSH à la VM.

![image-20241202144623779](./assets/image-20241202144623779.png)

Nous tentons de lister les `s3`.

![image-20241202144715415](./assets/image-20241202144715415.png)

Nous créons notre rôle `EC2toS3-test-Thomas`.

![image-20241202144859926](./assets/image-20241202144859926.png)

Nous modifions le rôle IAM pour mettre celui nouvellement créé.

![image-20241202144941341](./assets/image-20241202144941341.png)

Nous pouvons constater que le `ls` fonctionne désormais.

![image-20241202145011142](./assets/image-20241202145011142.png)

Nous créons une nouvelle instance `EC2-TP6.2-Thomas`.

![image-20241202145204298](./assets/image-20241202145204298.png)

Nous nous connectons à cette nouvelle instance.

![image-20241202145235463](./assets/image-20241202145235463.png)

Nous créons un nouvel utilisateur `Thomas1`.

![image-20241202145438824](./assets/image-20241202145438824.png)

Nous créons une access key pour notre utilisateur.

![image-20241202145619430](./assets/image-20241202145619430.png)

Après avoir enregistré nos Access Keys (détruites avant publication de ce TP donc visibles en clair sur les captures.) nous constatons que cela fonctionne.

![image-20241202145741260](./assets/image-20241202145741260.png)

Nous constatons également que ces informations sont stockées en clair sur la VM.

![image-20241202145817475](./assets/image-20241202145817475.png)

Nous supprimons ce fichier.

![image-20241202145854567](./assets/image-20241202145854567.png)

Nous modifions le role IAM.

![image-20241202150143534](./assets/image-20241202150143534.png)

Nous pouvons voir le résultat suivant.

![image-20241202150223419](./assets/image-20241202150223419.png)

Nous supprimons tous les éléments du TP.

![image-20241202150554491](./assets/image-20241202150554491.png)

Nous nous connectons au service EC2.

![image-20241202150704995](./assets/image-20241202150704995.png)

Nous créons noétre nouveau rôle.

![image-20241202150901800](./assets/image-20241202150901800.png)

Nous faisons le switch du role.

![image-20241202151208225](./assets/image-20241202151208225.png)

Nous avons bien le résultat suivant.

![image-20241202151236161](./assets/image-20241202151236161.png)

Nous n'avons pas d'accès au service EC2.

![image-20241202151321758](./assets/image-20241202151321758.png)

Idem pour le service IAM.

![image-20241202151344030](./assets/image-20241202151344030.png)

Pas de problème pour la lecture sur S3.

![image-20241202151417451](./assets/image-20241202151417451.png)

Nous ne pouvons pas créer de bucket.

![image-20241202151602206](./assets/image-20241202151602206.png)

Nous créons éun nouvel utilisateur `test-role-thomas`.

![image-20241202151918926](./assets/image-20241202151918926.png)

Nous n'avons pas accès au service S3.

![image-20241202152234153](./assets/image-20241202152234153.png)

Nous créons la policy suivante.

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": "sts:AssumeRole",
			"Resource": : "arn:aws:iam::794038237731:role/S3Readonly-thomas-TP6.3"
		}
	]
}
```

Nous créons la nouvelle policy.

![image-20241202153130208](./assets/image-20241202153130208.png)

Nous switchons de rôle.

![image-20241202153228304](./assets/image-20241202153228304.png)

Nous avons bien un accès en lecture seule.

![image-20241202153334230](./assets/image-20241202153334230.png)

# Rendu TP07

Rendu de TP07 effectué par `Thomas PEUGNET`.

Nous créons notre VPC.

![image-20241202154447343](./assets/image-20241202154447343.png)

![image-20241202154802397](./assets/image-20241202154802397.png)

Nous créons un sécurity group.

![image-20241202154900793](./assets/image-20241202154900793.png)

Nous créons une instance `EC2-TEST-SG-ACL` sur notre VPC.

![image-20241202155021403](./assets/image-20241202155021403.png)

Nous y ajoutons, AVANT de lancer l'instance, le code bash suivant.

```bash
#!/bin/bash
yum update -y
yum install -y httpd 
systemctl start httpd 
systemctl enable httpd
```

Nous testons la résolution DNS.

```
nslookup ec2-35-181-169-122.eu-west-3.compute.amazonaws.com
```

![image-20241202155436770](./assets/image-20241202155436770.png)

Nous ne pouvons pas encore accéder à notre instance depuis le client AWS.

![image-20241202155621942](./assets/image-20241202155621942.png)



Nous créons, dans notre sécurity group, une inbound rule.

![image-20241202155754919](./assets/image-20241202155754919.png)

![image-20241202155804343](./assets/image-20241202155804343.png)



Nous pouvons constater que cela fonctionne.

![image-20241202161834966](./assets/image-20241202161834966.png)

![image-20241202161914002](./assets/image-20241202161914002.png)

Nous créons une seconde instance.

![image-20241202162032494](./assets/image-20241202162032494.png)

La VM privée n'est pas accessible depuis la VM publique.

![image-20241202162213760](./assets/image-20241202162213760.png)

On modifie nos règles.

![image-20241202162306460](./assets/image-20241202162306460.png)

Nous pouvons constater que cela fonctionne.

![image-20241202162407326](./assets/image-20241202162407326.png)

Network ACLs.

![image-20241202162510818](./assets/image-20241202162510818.png)

Nous avons modifié nos rules.

![image-20241202162725791](./assets/image-20241202162725791.png)

Nous pouvons constater que cela ne fonctionne plus.

![image-20241202162835773](./assets/image-20241202162835773.png)

Nous modifions notre règle pour mettre uniquement notre adresse IP.

Nous ne pouvons plus accéder au site.

![image-20241202163022677](./assets/image-20241202163022677.png)



Nous modifions les règles pour ne plus y avoir accès via SSH.

![image-20241202163242527](./assets/image-20241202163242527.png)

Nous pouvons constater que cela fonctionne.

Si nous nous connectons via SSH, nous pouvons constater également que cela fonctionne.

![image-20241202163406762](./assets/image-20241202163406762.png)

On supprime nos instances.

![image-20241202163439674](./assets/image-20241202163439674.png)

Nous nettoyons nos règles Network ACLs.

![image-20241202163631340](./assets/image-20241202163631340.png)

Nous supprimons notre VPC.

![image-20241202163703121](./assets/image-20241202163703121.png)

