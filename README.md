# coffee_2_js
Helpers (scripts, etc) for Coffee to JS conversion


### Usage

Put scripts in `nfh-website/docker-frontend/client` dir.
Now you are ready to launch thenLaunch.

Order:

1. `coffee_2_js.sh` - convert `coffee` and `cjsx` to `js` and `jsx` (could take around 30 mins)
2. (optional) `js_2_flow.sh` - convert `js` to `flow` (be ready for a big number of flow errors, also some things can not work in flow as is)
3.  `remove_coffee_files.sh` - remove `coffee` and `cjsx` files from the project

