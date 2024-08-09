#!/bin/bash

while IFS= read -r path; do
  target="/home/kevin/test${path#*test}"
  temp_folder="/home/kevin/test${path#*test}"
  folder="${temp_folder%/*}"


  case "$path" in
    */home/kevin/test*)
      echo "$folder"
      sshpass -p $1 ssh -p $2 $3@$4 "mkdir -p $folder"  < /dev/null &&
      sshpass -p $1 scp -P $2 -r "$path" $3@$4:"'$target'"
      echo "$path 배포 완료"
      ;;
    *)
      echo "$path 는 배포 대상 파일이 아닙니다."
      ;;
  esac
done < .github/workflows/script/change-file
