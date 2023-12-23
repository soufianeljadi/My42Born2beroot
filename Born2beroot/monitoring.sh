
#!/bin/bash

arc=$(uname -a)
pcpu=$(grep -c "physical id" /proc/cpuinfo)
vcpu=$(grep -c "^processor" /proc/cpuinfo)
fram=$(free -m | awk '/^Mem:/ {print $2}')
uram=$(free -m | awk '/^Mem:/ {print $3}')
pram=$(free -m | awk '/^Mem:/ {printf "%.2f%%", $3/$2*100}')
fdisk=$(df -BG | awk '/^\/dev\// && $1 !~ /\/boot$/ {ft += $2} END {print ft}')
udisk=$(df -BM | awk '/^\/dev\// && $1 !~ /\/boot$/ {ut += $3} END {print ut}')
pdisk=$(df -BM | awk '/^\/dev\// && $1 !~ /\/boot$/ {ut += $3; ft += $2} END {printf "%d", ut/ft*100}')
cpul=$(top -bn1 | awk '/^%Cpu/ {printf "%.1f%%", $1 + $3}')
lb=$(who -b | awk '$1 == "system" {print $3, $4}')
lvmu=$(lsblk | grep -q "lvm" && echo yes || echo no)
ctcp=$(ss -neopt state established | wc -l)
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '/ether/ {print $2}')
cmds=$(journalctl _COMM=sudo | grep -c COMMAND)

wall "    #Architecture: $arc
    #CPU physical: $pcpu
    #vCPU: $vcpu
    #Memory Usage: $uram/${fram}MB ($pram)
    #Disk Usage: $udisk/${fdisk}GB ($pdisk%)
    #CPU load: $cpul
    #Last boot: $lb
    #LVM use: $lvmu
    #Connections TCP: $ctcp ESTABLISHED
    #User log: $ulog
    #Network: IP $ip ($mac)
    #Sudo: $cmds cmd"
#!/bin/bash

#architecture d'os :
arc=$(uname -a)

#Le nombre de processeurs physiques :
pcpu=$(grep "physical id" /proc/cpuinfo | wc -l)

#Le nombre de processeurs virtuels :
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)

#La mémoire vive disponible actuelle sur le serveur ainsi que son taux d’utilisation sous forme de pourcentage :
tram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

#La mémoire disponible actuelle sur votre serveur ainsi que son taux d’utilisation sous forme de pourcentage :
tdisk=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')

#Le taux d’utilisation actuel de vos processeurs sous forme de pourcentage :
cpul=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')

#La date et l’heure du dernier redémarrage :
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')

#Si LVM est actif ou pas :
lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)

#Le nombre de connexions actives :
ctcp=$(ss -t | grep "ESTAB" | wc -l)

#Le nombre d’utilisateurs utilisant le serveur :
ulog=$(users | wc -w)

#L’adresse IPv4 du serveur, ainsi que son adresse MAC :
ip=$(hostname -I)
mac=$(ip link | grep "ether" | ak '{print $2}')

#Le nombre de commande executées avec le programme sudo :
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

#l'affichage :
wall "    #Architecture: $arc
    #CPU physical: $pcpu
    #vCPU: $vcpu
    #Memory Usage: $uram/${tram}MB ($pram%)
    #Disk Usage: $udisk/${tdisk}Gb ($pdisk%)
    #CPU load: $cpul
    #Last boot: $lb
    #LVM use: $lvmu
    #Connections TCP: $ctcp ESTABLISHED
    #User log: $ulog
    #Network: IP $ip ($mac)
    #Sudo: $cmds cmd"






#!/bin/bash

#ARCHI
arc=$(uname -a)

#NUMBER OF PHYSICAL / VIRTUAL PROCC
pcpu=$(grep -c "physical id" /proc/cpuinfo)
vcpu=$(grep -c "^processor" /proc/cpuinfo)

#RAM
fram=$(free -m | awk '/^Mem:/ {print $2}')
uram=$(free -m | awk '/^Mem:/ {print $3}')
pram=$(free -m | awk '/^Mem:/ {printf "%.2f%%", $3/$2*100}')

#ROM
tdisk=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')

#PERCENTAGE OF  USED PROCC
cpul=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')

#LAST LOG DATE
lb=$(who -b | awk '$1 == "system" {print $3, $4}')

#LVM YES OR NO
lvmu=$(lsblk | grep -q "lvm" && echo yes || echo no)

#NUMBER OF CONNECTIONS
ctcp=$(ss -t | grep -c "ESTAB")

#NUMBER OF ACTIVE USERS
ulog=$(users | wc -w)

#ADRESS IPv4 and MAC
ip=$(hostname -I)
mac=$(ip link show | awk '/ether/ {print $2}')

#NUMBER OF SUDO CMD
cmds=$(journalctl _COMM=sudo | grep -c COMMAND)

wall "    #Architecture: $arc
    #CPU physical: $pcpu
    #vCPU: $vcpu
    #Memory Usage: $uram/${fram}MB ($pram)
    #Disk Usage: $udisk/${fdisk}GB ($pdisk%)
    #CPU load: $cpul
    #Last boot: $lb
    #LVM use: $lvmu
    #Connections TCP: $ctcp ESTABLISHED
    #User log: $ulog
    #Network: IP $ip ($mac)
    #Sudo: $cmds cmd"
