#! /bin/bash
# by cornerpirate 07/03/2023

while getopts h:p: flag
do
    case "${flag}" in
        h) host=${OPTARG};;
        p) port=${OPTARG};;
    esac
done

echo "[*] host: $host, port: $port";
echo "[*] listing available images";
echo "============"
images=`curl http://$host:$port/v2/_catalog -s | jq -r '.repositories[]'`
#echo $images

# Display list of images
count=1;
for image in `echo $images`; do
  echo "$count) $image"
  ((count=count+1));
done
echo "$count) DOWNLOAD ALL IMAGES";

echo "============"
echo -n "Which image(s) do you want to pull down? "
read toget;

# If that was not a number bomb out.
case $toget in
    ''|*[!0-9]*) echo "Not a number, please re-run the script" && exit;;
esac

echo "============"

# Pull all of them
if [ $toget -eq $count ];
  then
    for image in `echo $images`; do
        echo "[*] pulling down  $image"
        docker pull $host:$port/$image
    done
fi


count2=1;
# Pull just one of them
if [ $toget -le $count ];
  then
    for image in `echo $images`; do
      if [ $toget -eq $count2 ];
        then
           echo "[*] pulling down  $image"
           docker pull $host:$port/$image
      fi
      ((count2=count2+1));
    done
fi
