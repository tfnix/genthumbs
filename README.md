
#### Exemplo de shellscript basico pra gerar thumbnails com images de um endpoint  

*Utiliza o convert do imagemagick, jq (JSON query), curl e utilitarios comuns*


```bash
#!/bin/bash

```


Definindo algumas variaveis

```bash
EXT=".jpg" 
RAW="rawimages.json" 
THUMBS="thumbs"
PREFIX="THUMB_"
```


Verifica se o diretorio $THUMBS existe 

```bash

echo 'hold on...'

if [ -d $THUMBS ] 
then
    cd $THUMBS
    rm * -rf
else
    mkdir $THUMBS
    cd $THUMBS
fi

```

Le o end-point e salva um arquivo JSON contendo as urls das images

```bash

curl 'https://picsum.photos/v2/list?page=2&limit=22' -o $RAW

```

Utiliza o jq para ler o arquivo JSON , sanitiza  (remove as aspas duplas) e salva com o wget

```bash

wget `(jq '.[] | .download_url' $RAW | sed 's/"//g')` >  /dev/null 2>&1

```

Aqui le os arquivos do diretorio atual e gera os thumbnails com convert 


```bash

rm $RAW 

for imagefile in `ls`
do  
   convert $imagefile -resize 200x100 $PREFIX$imagefile$EXT
done

echo 'done.'

```

Referencias: <br>

<https://imagemagick.org/index.php> <br>
<https://stedolan.github.io/jq/>


