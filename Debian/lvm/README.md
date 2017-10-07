# Gerenciamento de discos de forma mais otimizada.

## Siglas dos comandos
PV - Physical Volume	- Consiste nos discos e partições;

VG - Volume Group	- São as partições reunidas(soma);

LV - Logical Volume	- É um pedaço da soma(VG) que irá ser utilizado;

## Visualizando status
pvs		- physical volume status	- status do physical volume;

vgs/vgdisplay   - volume group status		- status do volume group;

lvs/lvdisplay	- logical volume status		- statusdo logical volume;

## Inicializando os discos
pvcreate "nomedisco"
	pvcreate /dev/sdb

	pvcreate /dev/sdc

## Criando volume de discos
vgcreate "nomevg" "nomedisco"

	vgcreate vgteste /dev/sdb /dev/sdc

## Visualizando informações do volume group
vgs - forma resumida

vgdisplay - informações mais completas;

## Criando volume lógico
lvcreate -L(length) "tamanho" -n "nomelv" "nomevg"	

	lvcreate -L 5GB -n lvteste vgteste

## Visualizando informações
lvs/lvdisplay

## Formatando volume
mkfs.(formato) /dev/vgteste/lvteste

mkfs.ext4 /dev/vgteste/lvteste

## Montando volume
mount "nomedisco" "local"

mount /dev/vgteste/lvteste /mnt

## Verificando utilização dos discos 
df -h

## Aumentando tamanho do LV
lvextend -L "tamanho" "nomelv"

lvextend -L +5GB /dev/vgteste/lvteste

## Avisando SO sobre modificação no disco
resize2fs "nomelv"

resize2fs /dev/vgteste/lvteste

## Diminuindo tamanho LV
resize2fs "nomediscolv" "tamanhoesperado"

resize2fs /dev/vgteste/lvteste 8GB

lvreduce -L "tamanhoserreduzido" "nomediscolv"

lvreduce -L 2GB /dev/vgteste/lvteste

## Adicionando novo VG
pvcreate "nomepartição"

pvcreate /dev/sdd

## Aumentando tamanho do VG
vgextend "nomevg" "nomepartição"

vgextend vgteste /dev/sdd

## Removendo partição VG
vgreduce "nomevg" "nomepartição"

vgreduce vgteste /dev/sdd

## Removendo volume VG
lvremove "nomelv"

lvremove /dev/vgteste/lvteste

## Quando for modificar os volumes, é interessante desmontá-los.
unmount /mnt

## Para listar os discos, para digitar o comando 
fdisk -l

## Algumas distribuições não contem o LVM, sendo assim, basta instalá-lo com o comando
apt install lvm2 -y

