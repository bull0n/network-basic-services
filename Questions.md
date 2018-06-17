# REPONSES DE SERGYI

#### 1. quel est le rôle du mot clé authoritative dans la configuration du serveur DHCP ?
si on a configuré le sous-réseau ```aa.bb``` dans le DHCP, une requête venant d'un sous-réseau "non identifié" ```aa.bb.cc``` sera ignorée si ce mot clé n'est pas activé, s'il est activé, le serveur répondra avec un NACK

#### 2. pour quelle raison aurait-on tendance à configurer une durée de bail DHCP courte (p.ex. 1h) ? ou longue ? (p.ex. 1 semaine)
- bail court: quand il y a beaucoup de clients et pas beaucoup d'adresses ip disponibles dans la plage
- bail long: quand il y a des grandes plages d'adresses ip et pas beaucoup de clients

#### 3. peut-on imaginer un réseau dans lequel aucune adresse de type hard static n’existe ?
non, il faut au moins que le routeur aie une adresse hard static

#### 4. quel est l’avantage de configurer des imprimantes, machines virtuelles ou éventuellement serveurs en adresse de type DHCP static ?
ils sont censé être toujours disponibles et à la même adresse donc pourquoi on mettrait du dynamique ?

#### 5. peut-on mettre les plages d’adresses DHCP dynamic là où se trouvent des adresses hard static ?
bah non ! il risquerait d'allouer dynamiquement une adresse statique

#### 6. qu’est-ce que Cisco appelle des manual bindings ?
c'est des adresses ip (un pool) liés à certaines adresses MAC connues par le serveur DHCP

#### 7. expliquez le concept derrière la configuration DNS suivante (faites abtraction du CNAME, mais tenez compte du TTL et du fait qu’il y a 2 champs A différents) :
```
$ dig -t a www.yahoo.com
www.yahoo.com.            216   IN    CNAME   fd-fp3.wg1.b.yahoo.c
fd-fp3.wg1.b.yahoo.com.   38    IN    A       46.228.47.114
fd-fp3.wg1.b.yahoo.com.   38    IN    A       46.228.47.115

#lancez plusieurs fois la commande pour voir si quelque chose change
```
on a un serveur dupliqué donc deux serveurs à disposition

#### 8. consultez sur un serveur DHCP le fichier ```/var/lib/dhcp/dhcpd.leases``` : que contient-il ? qu’en déduisez-vous sur la volatilité des adresses IP dynamiques ?
contient les bails DHCP, les adresses IP dynamiques ont un "temps de vie" limité qui expire au bout d'un certain moment

#### 9. capturez et expliquez ce qu’il se passe avec : ```host big-entry.alphanet.ch``` (sur machine réelle, ou ```nslookup```)
il y pleins d'adresses ip qui s'affichent:
```
big-entry.alphanet.ch has address 192.168.24.25
```

il y a plusieurs serveurs physiques qui répondent à ce nom (plusieurs entrées avec le même nom dans la résolution d'adresses directe DNS)

#### 10. expliquez la résolution inverse (adresse IP vers nom)
Baaaah ça lie une adresse ip -> nom

#### 11. comment un serveur de nom trouve-t-il quels serveurs gèrent la racine ```.``` ?
Ils sont "codés en dur", les serveurs racines y en a pas des masses dans le monde

#### 12. à quoi sert l’option DNS (bind/named) ```forwarders``` ?
L'option “forwarders” permet de rediriger les requêtes qui ne sont pas résolues par notre serveur vers un serveur DNS distant (serveurs DNS de votre FAI par exemple).

Cela permet d'utiliser le cache d'un serveur déjà existant et donc d'obtenir des temps d'accès plus rapides.
Si la requête DNS n'est pas résolue par le serveur DNS “distant” alors la requête sera envoyée aux serveurs DNS racine.

#### 13. vous modifiez une zone gérée par un master et un slave DNS, que devez-vous absolument changer ?
bah si on change le master faut aussi changer le slave et vice-versa

#### 14. que pensez-vous de la sécurité du protocole DNS ? quelles possibilités existent pour l’améliorer ?
comme exploit il y a moyen de rediriger les requêtes vers des "faux sites", du coup pour éviter ça il y a un protocole DNSSEC qui est comme DNS mais plus sûre

#### 15. vous venez de configurer deux serveurs DNS pour la zone ```mondomaine.ch```, et ils sont associés à un registrar : expliquez ce que le registry 1 doit faire pour que cela fonctionne, techniquement (indication : ```whois alphanet.ch``` ; de plus, voir les entrées ```NS``` sur ```n1-routeur``` de ```mylan.ch``` vers les sous-domaines)
Faire remonter l'existance de ce réseau au DNS suppérieurs

#### 16. pourquoi est-ce important d’avoir des champs PTR existants et cohérents ?
- Faciliter de changemement de configuration
- Sécurité

#### 17. à quoi servent les champs de type SRV ? et TXT ? et NAPTR ? (donnez un exemple pour chacun)
- SRV : indique quel serveur s'occupe d'zun service spécifique  : SIP
- TXT : texte libre. Exemple: notification de règles SPF (Shortest Path First)
- NAPTR : conversion de valeurs. Exemple: n° de téléphone en URI SIP

#### 18. a-t-il été nécessaire de changer le protocole DNS pour supporter les domaines accentués, ou seul une modification du client a suffi ? (indication : punycode, exemple : ```linux-neuchâtel.ch``` dans votre navigateur)
- Aucune modification du DNS
- Mais utilisation de punycode

#### 19. à quoi sert le DNSSEC ?
Sécuriser le protocole `DNS` avec l'ajout d'un chiffrement des données
