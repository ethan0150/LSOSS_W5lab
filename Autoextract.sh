#!/bin/bash
mkdir sorted
mkdir sorted/zip sorted/rar sorted/tar sorted/unknown
ID=$(<student_id)$'\n'
cd compressed_files/
VLD=$(ls -1)
cd ..
while read line; do
	line=${line%%.*}$'\n'
	ID=${ID//$line/}
done <<< "$VLD"
ID=${ID%$'\n'}
printf '%s\n' "$ID" > missing_list
#AC=$(ls -1 *.zip)$'\n'$(ls -1 *.rar)$'\n'$(ls -1 *.tar.gz)
#cd ..
#while read line; do
#	ID=${ID/$line/}
#done <<< "$AC"
#while read line; do
#	line=${line%%.*}
#	printf '%s\n' "$line" >> missing_list
#done
mv compressed_files/*.zip sorted/zip/
mv compressed_files/*.rar sorted/rar/
mv compressed_files/*.tar.gz sorted/tar/
cd compressed_files/
WA=$(ls -1)
cd ..
while read line; do
	printf '%s\n' "${line%%.*}" >> wrong_list
done <<< "$WA"
mv compressed_files/* sorted/unknown/
cd sorted/zip/
unzip \*.zip
cd ../rar
unrar e \*.rar
cd ../tar
for file in *.tar.gz; do
	tar zxvf "$file"
done
