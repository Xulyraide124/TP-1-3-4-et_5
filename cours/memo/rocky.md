# Mémo réseau Rocky

- [Mémo réseau Rocky](#mémo-réseau-rocky)
  - [1. Définir une IP statique](#1-définir-une-ip-statique)
  - [2. Définir manuellement une passerelle](#2-définir-manuellement-une-passerelle)
  - [3. Définir manuellement un serveur DNS](#3-définir-manuellement-un-serveur-dns)
  - [4. Définir une IP en DHCP](#4-définir-une-ip-en-dhcp)
  - [5. Activer le routage](#5-activer-le-routage)
  - [6. Interagir avec le pare-feu](#6-interagir-avec-le-pare-feu)
  - [7. Lister les programmes qui écoutent derrière un port](#7-lister-les-programmes-qui-écoutent-derrière-un-port)
  - [8. Lister les connexions actives](#8-lister-les-connexions-actives)
  - [9. Définir un hostname](#9-définir-un-hostname)

## 1. Définir une IP statique

1. **Repérer le nom de l'interface réseau qu'on souhaite configurer**

```bash
ip a
```

Dans la suite, les exemples seront donnés avec une interface réseau qui s'appellerait `enp0s3`.

2. **Modifier le fichier de configuration `/etc/sysconfig/network-scripts/ifcfg-<INTERFACE>`**

Si on souhaite configurer une interface nommée `enp0s3`, le fichier **DOIT** donc s'appeler `ifcfg-enp0s3`.

Si on souhaite définir l'adresse IP `10.1.1.10/24`, il doit contenir :

```bash
DEVICE=enp0s3
NAME=ce_que_tu_veux

ONBOOT=yes
BOOTPROTO=static

IPADDR=10.1.1.10
NETMASK=255.255.255.0
```

> ***Remplacez `ce_que_tu_veux` par... ce que vous voulez !** Un truc qui est parlant, qui est simple à lire et à taper. Par exemple `lan` c'est un nom simple et facile à taper ;D*

3. **Appliquer la configuration**

```bash
# on charge la nouvelle configuration
sudo nmcli connection reload

# allumage de la carte (change ce_que_tu_veux par le nom que tu as donné dans le fichier)
sudo nmcli connection up ce_que_tu_veux

# si vous modifiez une configuration existante, éteignez, puis rallumez la carte
sudo nmcli connection down ce_que_tu_veux
sudo nmcli connection up ce_que_tu_veux
```

> *Vous pouvez écrire juse `con` au lieu de `connection` en entier si jamais avec cette commande ;)*

4. **Vérifier et prouver que le changement est effectif**

```bash
ip a
```

## 2. Définir manuellement une passerelle

1. **Repérer le nom de l'interface réseau qu'on souhaite configurer**

```bash
ip a
```

Dans la suite, les exemples seront donnés avec une interface réseau qui s'appellerait `enp0s3`.

2. **Modifier le fichier de configuration `/etc/sysconfig/network-scripts/ifcfg-<INTERFACE>`**

Si on souhaite configurer une interface nommée `enp0s3`, le fichier **DOIT** donc s'appeler `ifcfg-enp0s3`.

Si on souhaite définir l'adresse IP `10.1.1.254` comme passerelle, on ajoute la ligne `GATEWAY=10.1.1.254` :

```bash
DEVICE=enp0s3
NAME=ce_que_tu_veux

ONBOOT=yes
BOOTPROTO=static

IPADDR=10.1.1.10
NETMASK=255.255.255.0
GATEWAY=10.1.1.254
```

> ***Remplacez `ce_que_tu_veux` par... ce que vous voulez !** Un truc qui est parlant, qui est simple à lire et à taper. Par exemple `lan` c'est un nom simple et facile à taper ;D*

3. **Appliquer la configuration**

```bash
# on charge la nouvelle configuration
sudo nmcli connection reload

# allumage de la carte (change ce_que_tu_veux par le nom que tu as donné dans le fichier)
sudo nmcli connection up ce_que_tu_veux

# si vous modifiez une configuration existante, éteignez, puis rallumez la carte
sudo nmcli connection down ce_que_tu_veux
sudo nmcli connection up ce_que_tu_veux
```

> *Vous pouvez écrire juse `con` au lieu de `connection` en entier si jamais avec cette commande ;)*

4. **Vérifier et prouver que le changement est effectif**

```bash
# vous devriez voir l'IP de la passerelle en face du mot "default"
ip route show
# la commande ip supporte l'abrégé, on peut taper ça, plus court (ça fait pareil)
ip r s

# vous devriez pouvoir ping une IP publique, par exemple 1.1.1.1
ping 1.1.1.1
```

## 3. Définir manuellement un serveur DNS

1. **Repérer le nom de l'interface réseau qu'on souhaite configurer**

```bash
ip a
```

Dans la suite, les exemples seront donnés avec une interface réseau qui s'appellerait `enp0s3`.

2. **Modifier le fichier de configuration `/etc/sysconfig/network-scripts/ifcfg-<INTERFACE>`**

Si on souhaite configurer une interface nommée `enp0s3`, le fichier **DOIT** donc s'appeler `ifcfg-enp0s3`.

Si on souhaite définir l'adresse IP `1.1.1.1` comme adresse de serveur DNS à utiliser, on ajoute la ligne `DNS1=1.1.1.1` :

```bash
DEVICE=enp0s3
NAME=ce_que_tu_veux

ONBOOT=yes
BOOTPROTO=static

IPADDR=10.1.1.10
NETMASK=255.255.255.0
GATEWAY=10.1.1.254
DNS1=1.1.1.1
```

> ***Remplacez `ce_que_tu_veux` par... ce que vous voulez !** Un truc qui est parlant, qui est simple à lire et à taper. Par exemple `lan` c'est un nom simple et facile à taper ;D*

3. **Appliquer la configuration**

```bash
# on charge la nouvelle configuration
sudo nmcli connection reload

# allumage de la carte (change ce_que_tu_veux par le nom que tu as donné dans le fichier)
sudo nmcli connection up ce_que_tu_veux

# si vous modifiez une configuration existante, éteignez, puis rallumez la carte
sudo nmcli connection down ce_que_tu_veux
sudo nmcli connection up ce_que_tu_veux
```

4. **Vérifier et prouver que le changement est effectif**

```bash
# vous pouvez lister le serveur DNS utilisé actuellement avec
cat /etc/resolv.conf
# vous devriez voir une ligne "nameserver x.x.x.x"

# vous devriez pouvoir joindre des noms de domaine
ping ynov.com

# si vous voulez faire une requête DNS à la main (et pas envoyer un ping) vous pouvez utiliser drill
drill ynov.com
```

## 4. Définir une IP en DHCP

1. **Repérer le nom de l'interface réseau qu'on souhaite configurer**

```bash
ip a
```

Dans la suite, les exemples seront donnés avec une interface réseau qui s'appellerait `enp0s3`.

2. **Modifier le fichier de configuration `/etc/sysconfig/network-scripts/ifcfg-<INTERFACE>`**

Si on souhaite configurer une interface nommée `enp0s3`, le fichier **DOIT** donc s'appeler `ifcfg-enp0s3`.

Si on souhaite définir l'adresse IP `10.1.1.10/24`, il doit contenir :

```bash
DEVICE=enp0s3
NAME=ce_que_tu_veux

ONBOOT=yes
BOOTPROTO=dhcp
```

> ***Remplacez `ce_que_tu_veux` par... ce que vous voulez !** Un truc qui est parlant, qui est simple à lire et à taper. Par exemple `lan` c'est un nom simple et facile à taper ;D*

3. **Appliquer la configuration**

```bash
# on charge la nouvelle configuration
sudo nmcli connection reload

# allumage de la carte (change ce_que_tu_veux par le nom que tu as donné dans le fichier)
sudo nmcli connection up ce_que_tu_veux

# si vous modifiez une configuration existante, éteignez, puis rallumez la carte
sudo nmcli connection down ce_que_tu_veux
sudo nmcli connection up ce_que_tu_veux
```

> *Vous pouvez écrire juse `con` au lieu de `connection` en entier si jamais avec cette commande ;)*

4. **Vérifier et prouver que le changement est effectif**

```bash
ip a
```

## 5. Activer le routage

```bash
sudo firewall-cmd --add-masquerade --permanent
sudo firewall-cmd --reload
```

## 6. Interagir avec le pare-feu

➜ **Lister les règles actuelles du pare-feu**

```bash
sudo firewall-cmd --list-all
```

➜ **Fermer les ports inutilement ouverts par défaut sur Rocky**

```bash
sudo firewall-cmd --permanent --remove-service dhcpv6-client
sudo firewall-cmd --permanent --remove-service cockpit
sudo firewall-cmd --reload
```

➜ **Ouvrir un port spécifique**

```bash
sudo firewall-cmd --permanent --add-port=8888/tcp
sudo firewall-cmd --reload
```

➜ **Fermer un port spécifique**

```bash
sudo firewall-cmd --permanent --remove-port=8888/tcp
sudo firewall-cmd --reload
```

## 7. Lister les programmes qui écoutent derrière un port

➜ **Lister les programmes qui écoutent sur un port TCP**

```bash
sudo ss -lnpt
```

➜ **Lister les programmes qui écoutent sur un port UDP**

```bash
sudo ss -lnpu
```

## 8. Lister les connexions actives

➜ **Lister les connexions actives utilisant un port TCP**

```bash
sudo ss -npt
```

➜ **Lister les connexions actives utilisant un port UDP**

```bash
sudo ss -npu
```

## 9. Définir un hostname

➜ **Voir le hostname actuel**

```bash
# la première partie du nom est visible dans le prompt
# c'est "meow" sur la machine depuis laquelle est données l'exemple
[it4@meow]$ sudo hostnamectl
```

➜ **Définir un nouveau hostname**

```bash
sudo hostnamectl set-hostname <NOUVEAU_HOSTNAME>

# par exemple
sudo hostnamectl set-hostname hello.b1
```

> *Le nom indiqué dans le prompt ne se met à jour qu'après une ptite déco/reco. (j'ai dit déco/reco, pas reboot la machine hein... bande de bourrins !).*
