#!/usr/bin/env bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd ./app/scripts/ &&

printf "${GREEN}STEP 1: Remove COFFEE files${NC}\n";
find ./ -name "*.coffee" -type f
printf "${GREEN}STEP 1: Remove COFFEE files... done${NC}\n";

printf "${GREEN}STEP 2: Remove CJSX files${NC}\n";
find ./ -name "*.cjsx" -type f
printf "${GREEN}STEP 2: Remove CJSX files... done${NC}\n";

printf "${GREEN}Remove old files done!${NC}\n";