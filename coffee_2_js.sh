#!/usr/bin/env bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

printf "${GREEN}SKIP... STEP 1: Installation${NC}\n";

#printf "${GREEN}STEP 1: Installation...${NC}\n";
#npm i -g depercolator && npm i -g decaffeinate &&
#printf "${GREEN}STEP 1: Installation... done.${NC}\n";

cd ./app/scripts/ &&

printf "${GREEN}STEP 2: Converting... *.coffee -> *.js...${NC}\n";
find . -type d | while read d; do
  for f in ${d}/*.coffee; do
    if ls ${d}/*.coffee >/dev/null 2>&1;
    then
      decaffeinate ${f} --use-js-modules --disable-suggestion-comment;
    fi;
  done;
done;
printf "${GREEN}STEP 2: Converting... *.coffee -> *.js... done.${NC}\n";

printf "${GREEN}STEP 2: Converting... *.cjsx -> *.jsx...${NC}\n";
find . -type d | while read d; do
  for f in ${d}/*.cjsx; do
    if ls ${d}/*.cjsx >/dev/null 2>&1;
    then
      depercolate ${f} --prefer-const --print-width 120;
    fi;
  done;
done;
printf "${GREEN}STEP 2: Converting... *.cjsx -> *.jsx... done.${NC}\n";

printf "${GREEN}STEP 3: REGEX replace...${NC}\n";
find . -type d | while read d; do
  printf "${d}\n";
  if ls ${d}/*.js* >/dev/null 2>&1;
  then
    perl -i -pe 's/import (.*) from '"'"'(.*)\.coffee'"'"'/import $1 from '"'"'$2'"'"'/g' ${d}/*.js*;
    perl -i -pe 's/import (.*) from '"'"'(.*)\.cjsx'"'"'/import $1 from '"'"'$2'"'"'/g' ${d}/*.js*;
    perl -i -pe 's/import ReactRedux from/import * as ReactRedux from/g' ${d}/*.js*;
    perl -i -pe 's/import Redux from/import * as Redux from/g' ${d}/*.js*;
    perl -i -pe 's/import ReduxDevTools from/import * as ReduxDevTools from/g' ${d}/*.js*;
    perl -i -pe 's/import DayPickerAddons from/import * as DayPickerAddons from/g' ${d}/*.js*;
    perl -i -pe 's/import History from/import * as History from/g' ${d}/*.js*;
    perl -i -pe 's/import MenuListObject from/import * as MenuListObject from/g' ${d}/*.js*;
  fi;
done;

perl -i -pe 's/export \{ Variant, getActiveVariant, isVariant, getAllActiveExperiments \}/export default \{ Variant, getActiveVariant, isVariant, getAllActiveExperiments \}/g' ./utils/abtesting.jsx;
perl -i -pe 's/DevTools.instrument/DevTools.default.instrument/g' ./utils/store.js;
perl -i -pe 's/this.history = require\('"'"'utils\/history'"'"'\)/this.history = require\('"'"'utils\/history'"'"'\).default/g' ./pages/container/urlhistory.jsx;

printf "${GREEN}STEP 3: REGEX replace... done.${NC}\n";

printf "${GREEN}STEP 4: ESLINT fixes...${NC}\n";
cd ../../
npm run lint:fix;
printf "${GREEN}STEP 4: ESLINT fixes... done.${NC}\n";

cd ./test

printf "${GREEN}STEP 5: Converting... test folder... *.coffee -> *.js...${NC}\n";
find . -type d | while read d; do
  for f in ${d}/*.coffee; do
    if ls ${d}/*.coffee >/dev/null 2>&1;
    then
      decaffeinate ${f} --use-js-modules --disable-suggestion-comment;
    fi;
  done;
done;
printf "${GREEN}STEP 5: Converting... test folder... *.coffee -> *.js... done.${NC}\n";

printf "${GREEN}STEP 6: Converting... test folder... *.cjsx -> *.jsx...${NC}\n";
find . -type d | while read d; do
  for f in ${d}/*.cjsx; do
    if ls ${d}/*.cjsx >/dev/null 2>&1;
    then
      depercolate ${f} --prefer-const --print-width 120;
    fi;
  done;
done;
printf "${GREEN}STEP 6: Converting... test folder... *.cjsx -> *.jsx... done.${NC}\n";

printf "${GREEN}STEP 7: REGEX replace... test folder... ${NC}\n";
find . -type d | while read d; do
  printf "${d}\n";
  if ls ${d}/*.js* >/dev/null 2>&1;
  then
    perl -i -pe 's/import Redux from/import * as Redux from/g' ${d}/*.js*;
    perl -i -pe 's/import Enzyme from/import * as Enzyme from/g' ${d}/*.js*;
    perl -i -pe 's/import (.*) from '"'"'(.*)\.coffee'"'"'/import $1 from '"'"'$2'"'"'/g' ${d}/*.js*;
    perl -i -pe 's/import (.*) from '"'"'(.*)\.cjsx'"'"'/import $1 from '"'"'$2'"'"'/g' ${d}/*.js*;
    perl -i -pe 's/import ReactTestUtils from/import * as ReactTestUtils from/g' ${d}/*.js*;
    perl -i -pe 's/return describe\(/describe\(/g' ${d}/*.js*;
    perl -i -pe 's/return it\(/it\(/g' ${d}/*.js*;
    perl -i -pe 's/return expect\(/expect\(/g' ${d}/*.js*;
    perl -i -pe 's/return mock/mock/g' ${d}/*.js*;
  fi;
done;

cd ./unit/spec
find . -type d | while read d; do
  printf "${d}\n";
  if ls ${d}/*.js* >/dev/null 2>&1;
  then
    perl -i -pe 's/export default defaultExport/ /g' ${d}/*.js*;
  fi;
done;
cd ../../

perl -i -pe 's/require.context\('"'"'spec'"'"'\, true\, \/\\\.coffee\$\/\)/require.context\('"'"'spec'"'"'\, true\, \/\\\.js\$\/\)/g' ./unit/main.js;
perl -i -pe 's/import '"'"'.\/main'"'"'/import * as main from '"'"'.\/main'"'"'/g' ./unit/webpack.js;

printf "${GREEN}STEP 7: REGEX replace... test folder... done.${NC}\n";

printf "${GREEN}STEP 8: ESLINT fixes... test folder... ${NC}\n";
cd ../
npm run lint:fix:test;
printf "${GREEN}STEP 8: ESLINT fixes... test folder... done.${NC}\n";