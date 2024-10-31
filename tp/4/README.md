# TP4 : DHCP et accès internet

TP très court en rapport DHCP. DHCP c'est pour ~~Dynamic Host Configuration Protocol~~ permettre à nos mamans qui savent pas ce que c'est une adresse IP de quand même avoir un "accès internet".

## Sommaire

- [TP4 : DHCP et accès internet](#tp4--dhcp-et-accès-internet)
  - [Sommaire](#sommaire)
- [0. Prérequis](#0-prérequis)
- [I. DHCP](#i-dhcp)
  - [0. Intro](#0-intro)
  - [1. Les mains dans le capot](#1-les-mains-dans-le-capot)

# 0. Prérequis

- ton PC connecté à un réseau local où t'as internet
- **pense à bien remettre ton interface WiFi en configuration automatique**

# I. DHCP

## 0. Intro

➜ Si là tout de suite t'as internet, et que la configuration de ta carte réseau est automatique, **alors il y a forcément un serveur DHCP dans le même réseau local que toi**.

Le serveur DHCP t'a fourni 3 infos pour que tu aies un "accès internet" :

- **il propose une adresse IP libre dans le réseau**
  - à l'école, il vous propose une adresse IP en `10.33.xx.xx`
  - il sait que c'est libre, parce que c'est lui qui gère les adresses IP de tout le monde le bougre, donc il a une liste de ce qu'il a déjà proposé à quelqu'un
- **il indique l'adresse de la passerelle du réseau**
  - la passerelle, c'est le routeur qui est dans le réseau et qui fait passer vos paquets vers internet
  - à l'école, il vous indique que c'est `10.33.79.254`
- **il indique l'adresse d'un serveur DNS joignable**
  - quand tu visites le site `xkcd.com` (par exemple), ton PC fait spontanément une requête DNS pour connaître l'adresse IP qui correspond au nom `xkcd.com`
  - il envoie cette requête à l'adresse d'un serveur DNS qu'il a appris lors de l'échange DHCP
  - à l'école, il vous indique que c'est `8.8.8.8` et `1.1.1.1`

➜ **Quand tu te connectes à un réseau, il se produit un échange spontané et automatique : ton PC essaie de contacter un serveur DHCP sur le réseau pour apprendre ces 3 infos.**

Si ça fonctionne, t'as internet. Paf.

## 1. Les mains dans le capot

☀️ **Capturez un échange DHCP complet**

- capture `dhcp.pcap`
- il y a 4 trames (le DORA) : Discover, Offer, Request, Acknowledge

 
les fichier demandé  se trouve dans le fichier [dhcp.pcap](dhcp.pcapng)


> **Soucis** : l'échange DHCP complet ne se produit qu'à la première connexion. **Pour forcer un échange DHCP**, ça dépend de votre OS. Sur **GNU/Linux**, avec `dhclient` ça se fait bien. Sur **Windows**, le plus simple reste de définir une IP statique pourrie sur la carte réseau, se déconnecter du réseau, remettre en DHCP, se reconnecter au réseau (ché moa sa march). Essayez de regarder par vous-mêmes s'il existe une commande clean pour faire ça ! Sur **MacOS**, je connais peu mais Internet dit qu'c'est po si compliqué, appelez moi si besoin.

☀️ **Directement dans Wireshark, vous pouvez voir toutes les infos que vous donne  le serveur DHCP**

- retrouvez dans l'échange DHCP les 3 infos dont on parle plus haut :
  - adresse IP proposée : 
  ```
  1	0.000000	0.0.0.0	255.255.255.255	DHCP	342	DHCP Discover - Transaction ID 0xc79e8a60

  ```
  - serveur DNS indiqué:
  ```
  3	1.115784	0.0.0.0	255.255.255.255	DHCP	370	DHCP Request  - Transaction ID 0xc79e8a60
  ```
  
  - passerelle du réseau:
  
  ```
  2	1.112475	10.33.79.254	255.255.255.255	DHCP	342	DHCP Offer    - Transaction ID 0xc79e8a60
  
  
  ```
- **pour le compte-rendu** le nom des champs et leur valeur, pour ces 3 valeurs
  - par exemple (l'exemple te parlera + quand t'auras regardé dans Wireshark) :

```
Option(1337) Meow: 10.10.10.10
```

![DORA](./img/dora.jpg)
