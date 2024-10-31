# Mémo réseau Ubuntu

- [Mémo réseau Ubuntu](#mémo-réseau-ubuntu)
  - [1. Définir une IP statique](#1-définir-une-ip-statique)
  - [2. Définir manuellement une passerelle](#2-définir-manuellement-une-passerelle)
  - [3. Définir manuellement un serveur DNS](#3-définir-manuellement-un-serveur-dns)
  - [4. Définir une IP en DHCP](#4-définir-une-ip-en-dhcp)
  - [5. Lister les programmes qui écoutent derrière un port](#5-lister-les-programmes-qui-écoutent-derrière-un-port)
  - [6. Lister les connexions actives](#6-lister-les-connexions-actives)
  - [7. Définir un hostname](#7-définir-un-hostname)

## 1. Définir une IP statique

1. **Repérer le nom de l'interface réseau qu'on souhaite configurer**

```bash
ip a
```

Dans la suite, les exemples seront donnés avec une interface réseau qui s'appellerait `enp0s3`.

2. **Modifier le fichier de configuration `/etc/netplan/01-netcfg.yaml`**

Il doit contenir une section qui configure l'interface dont vous avez repéré le nom (modifier la section existante, ou ajoutez-en une si elle n'existe pas)

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [10.1.1.10/24]
```

3. **Appliquer la configuration**

```bash
sudo netplan apply
```

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

2. **Modifier le fichier de configuration `/etc/netplan/01-netcfg.yaml`**

Il doit contenir une section qui configure l'interface dont vous avez repéré le nom (modifier la section existante, ou ajoutez-en une si elle n'existe pas)

On ajoute la ligne : `gateway4: <IP_PASSERELLE>`. Dans l'exemple ci-dessous, on considère que la passerelle porte l'IP `10.1.1.254`

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [10.1.1.10/24]
      gateway4: 10.1.1.254
```

3. **Appliquer la configuration**

```bash
sudo netplan apply
```

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

2. **Modifier le fichier de configuration `/etc/netplan/01-netcfg.yaml`**

Il doit contenir une section qui configure l'interface dont vous avez repéré le nom (modifier la section existante, ou ajoutez-en une si elle n'existe pas)

On ajoute deux lignes à la configuration de notre interface :

```yaml
      nameservers:
        addresses: [<LISTE_DE_SERVEURS_DNS>]
```

Dans l'exemple ci-dessous, on considère que l'on veut ajouter les serveurs DNS `1.1.1.1` et `1.0.0.1` :

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [10.1.1.10/24]
      gateway4: 10.1.1.254
      nameservers:
        addresses: [1.1.1.1,1.0.0.1]
```

3. **Appliquer la configuration**

```bash
sudo netplan apply
```

4. **Vérifier et prouver que le changement est effectif**

```bash
# vous pouvez lister le serveur DNS utilisé actuellement avec
resolvectl

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

2. **Modifier le fichier de configuration `/etc/netplan/01-netcfg.yaml`**

Il doit contenir une section qui configure l'interface dont vous avez repéré le nom (modifier la section existante, ou ajoutez-en une si elle n'existe pas)

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: yes
```

3. **Appliquer la configuration**

```bash
sudo netplan apply
```

4. **Vérifier et prouver que le changement est effectif**

```bash
ip a
```

## 5. Lister les programmes qui écoutent derrière un port

➜ **Lister les programmes qui écoutent sur un port TCP**

```bash
sudo ss -lnpt
```

➜ **Lister les programmes qui écoutent sur un port UDP**

```bash
sudo ss -lnpu
```

## 6. Lister les connexions actives

➜ **Lister les connexions actives utilisant un port TCP**

```bash
sudo ss -npt
```

➜ **Lister les connexions actives utilisant un port UDP**

```bash
sudo ss -npu
```

## 7. Définir un hostname

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