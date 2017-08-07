#!/usr/bin/env bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd ./app/scripts/ &&

printf "${GREEN}STEP 1: Add @Flow notations${NC}\n";
find . -type d | while read d; do
  printf "${d}\n";
  if ls ${d}/*.js* >/dev/null 2>&1;
  then
    for f in ${d}/*.js*; do
      echo "// @flow" > tmpfile
      cat ${f} >> tmpfile
      mv tmpfile ${f}
    done
  fi;
done;
printf "${GREEN}STEP 1: Add @Flow notations... done${NC}\n";

printf "${GREEN}STEP 2: Add  types into functions${NC}\n";
find . -type d | while read d; do
  printf "${d}\n";
  if ls ${d}/*.js* >/dev/null 2>&1;
  then
    perl -i -pe 's/(?:\G(?!\A),?|\W\s*\((?=[^)]*\)\s{))\s*\K(\w+)/$1\: any/g' ${d}/*.js*;
    perl -i -pe 's/const (\S*) = ([A-z]+) =>/const $1 = \($2\: any\) =>/g' ${d}/*.js*;
    perl -i -pe 's/(\S*) = \(\) =>/$1 = \(\): any =>/g' ${d}/*.js*;
    perl -i -pe 's/\: any\: any/\: any/g' ${d}/*.js*;
    perl -i -pe 's/if\s+\(?((.*)\: any(.*))\) \{/if \($2$3\) \{/g' ${d}/*.js*;
    perl -i -pe 's/if\s+\(typeof\: any/if \(typeof/g' ${d}/*.js*;
    perl -i -pe 's/switch\s+\(?((.*)\: any(.*))\) \{/switch \($2$3\) \{/g' ${d}/*.js*;
    perl -i -pe 's/for\s+\(+((.*)\: any(.*))\) \{/for \($2$3\) \{/g' ${d}/*.js*;
    perl -i -pe 's/catch\s+\(+((.*)\: any(.*))\) \{/catch \($2$3\) \{/g' ${d}/*.js*;
    perl -i -pe 's/(?:\G(?!\A),?|\W\s*\=\s*\((?=[^)]*\)\s\=\>))\s*\K(\w+)/$1\ \: any/g' ${d}/*.js*;
    perl -i -pe 's/\: any\)/\: any\)\: any/g' ${d}/*.js*;
    perl -i -pe 's/\: any\: any/\: any/g' ${d}/*.js*;
    perl -i -pe 's/event\: any/event\: SyntheticEvent/g' ${d}/*.js*;
    perl -i -pe 's/\: SyntheticEvent\: SyntheticEvent/\: SyntheticEvent/g' ${d}/*.js*;
  fi;
done;

printf "${GREEN}STEP 2: Add  types into functions... done${NC}\n";

printf "${GREEN}STEP 2: ESLINT fixes...${NC}\n";
cd ../../
npm run lint:fix;
printf "${GREEN}STEP 2: ESLINT fixes... done.${NC}\n";
