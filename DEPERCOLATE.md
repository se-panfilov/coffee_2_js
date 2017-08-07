#### Install

```
npm i -g depercolator
npm i -g decaffeinate
```

`yarn global add depercolator`  Somehow broken at the moment

#### Usage

### With script:

run 
```
coffee_2_js.sh
```
 
(from `nfh-website/docker-frontend/client`)

### Manual (in case shell script won't work)

```
> depercolate --skip-prettier $file
> eslint --fix file
```

#### Convert CJSX to JSX

```
for file in app/**/*.cjsx
do
  echo "$file"
  depercolate $file --prefer-const --print-width 120
done
```

#### Convert Coffee to JS
```
for file in app/**/*.coffee
do
  decaffeinate $file --use-js-modules
done

for file in *.coffee
do
  decaffeinate $file --use-js-modules
done

for file in test/**/*.coffee
do
  decaffeinate $file --use-js-modules
done
```


#### Lint and autofix

```
npm run lint:fix
```



#### Manual conversions
* DayPickerWrapperAddons
* utils/history import history
* Hotel Offer Section
