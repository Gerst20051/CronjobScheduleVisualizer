#!/usr/bin/env sh

# ASCII: http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Setup%20Repo

assets_dir=assets
project_name=${PWD##*/}
project_name_spaces=$(echo $project_name | sed 's/[[:upper:]]/ &/g;s/^ //')
react_project_name=$(echo $project_name | sed 's/[[:upper:]]/-&/g;s/^-//' | tr '[:upper:]' '[:lower:]')
react_project_dir=react-$react_project_name
react_public_url=http://hnswave.co/$react_project_name/

function double_echo {
  echo && echo
}

function newline {
  echo
}

bold=$(tput bold)
normal=$(tput sgr0)

function init {
  echo
  print_header && double_echo
  create_assets_dir && double_echo
  init_react_project && double_echo
  update_react_build_command && double_echo
  add_react_deploy_command && double_echo
  update_react_public_index_html && double_echo
  update_react_public_manifest_json && double_echo
  check_logo && double_echo
  create_logos && double_echo
  build_react_project && double_echo
  deploy_react_project && double_echo
  print_public_url && double_echo
}

function print_header {
  echo '  _________       __                 __________                      '
  echo ' /   _____/ _____/  |_ __ ________   \______   \ ____ ______   ____  '
  echo ' \_____  \_/ __ \   __\  |  \____ \   |       _// __ \\____ \ /  _ \ '
  echo ' /        \  ___/|  | |  |  /  |_> >  |    |   \  ___/|  |_> >  <_> )'
  echo '/_______  /\___  >__| |____/|   __/   |____|_  /\___  >   __/ \____/ '
  echo '        \/     \/           |__|             \/     \/|__|           '
}

function create_assets_dir {
  echo '_________                        __              _____                        __           ________  .__        '
  echo '\_   ___ \_______   ____ _____ _/  |_  ____     /  _  \   ______ ______ _____/  |_  ______ \______ \ |__|______ '
  echo '/    \  \/\_  __ \_/ __ \\__  \\   __\/ __ \   /  /_\  \ /  ___//  ___// __ \   __\/  ___/  |    |  \|  \_  __ \'
  echo '\     \____|  | \/\  ___/ / __ \|  | \  ___/  /    |    \\___ \ \___ \\  ___/|  |  \___ \   |    `   \  ||  | \/'
  echo ' \______  /|__|    \___  >____  /__|  \___  > \____|__  /____  >____  >\___  >__| /____  > /_______  /__||__|   '
  echo '        \/             \/     \/          \/          \/     \/     \/     \/          \/          \/           '

  double_echo

  echo "[\$]> mkdir -p $assets_dir"

  mkdir -p $assets_dir
}

function init_react_project {
  echo '.___       .__  __    __________                      __    __________                   __               __   '
  echo '|   | ____ |__|/  |_  \______   \ ____ _____    _____/  |_  \______   \_______  ____    |__| ____   _____/  |_ '
  echo '|   |/    \|  \   __\  |       _// __ \\__  \ _/ ___\   __\  |     ___/\_  __ \/  _ \   |  |/ __ \_/ ___\   __\'
  echo '|   |   |  \  ||  |    |    |   \  ___/ / __ \\  \___|  |    |    |     |  | \(  <_> )  |  \  ___/\  \___|  |  '
  echo '|___|___|  /__||__|    |____|_  /\___  >____  /\___  >__|    |____|     |__|   \____/\__|  |\___  >\___  >__|  '
  echo '         \/                   \/     \/     \/     \/                               \______|    \/     \/      '

  double_echo

  if [ -d "$react_project_dir" ]; then
    echo "the react project '$react_project_dir' already exists"
  else
    echo "[\$]> npx create-react-app $react_project_dir --use-npm"

    newline

    npx create-react-app $react_project_dir --use-npm
  fi
}

function update_react_build_command {
  echo '__________                      __    __________      .__.__       .___ _________                                           .___'
  echo '\______   \ ____ _____    _____/  |_  \______   \__ __|__|  |    __| _/ \_   ___ \  ____   _____   _____ _____    ____    __| _/'
  echo ' |       _// __ \\__  \ _/ ___\   __\  |    |  _/  |  \  |  |   / __ |  /    \  \/ /  _ \ /     \ /     \\__  \  /    \  / __ | '
  echo ' |    |   \  ___/ / __ \\  \___|  |    |    |   \  |  /  |  |__/ /_/ |  \     \___(  <_> )  Y Y  \  Y Y  \/ __ \|   |  \/ /_/ | '
  echo ' |____|_  /\___  >____  /\___  >__|    |______  /____/|__|____/\____ |   \______  /\____/|__|_|  /__|_|  (____  /___|  /\____ | '
  echo '        \/     \/     \/     \/               \/                    \/          \/             \/      \/     \/     \/      \/ '

  double_echo

  if [ -f "$react_project_dir/package.json" ]; then
    echo "[\$]> echo \"\$(jq \".scripts.build = \\\"PUBLIC_URL=$react_public_url react-scripts build\\\"\" $react_project_dir/package.json)\" > $react_project_dir/package.json"

    echo "$(jq ".scripts.build = \"PUBLIC_URL=$react_public_url react-scripts build\"" $react_project_dir/package.json)" > $react_project_dir/package.json
  else
    echo "the file '$react_project_dir/package.json' does not exist"
  fi
}

function add_react_deploy_command {
  echo '__________                      __    ________                .__                 _________                                           .___'
  echo '\______   \ ____ _____    _____/  |_  \______ \   ____ ______ |  |   ____ ___.__. \_   ___ \  ____   _____   _____ _____    ____    __| _/'
  echo ' |       _// __ \\__  \ _/ ___\   __\  |    |  \_/ __ \\____ \|  |  /  _ <   |  | /    \  \/ /  _ \ /     \ /     \\__  \  /    \  / __ | '
  echo ' |    |   \  ___/ / __ \\  \___|  |    |    `   \  ___/|  |_> >  |_(  <_> )___  | \     \___(  <_> )  Y Y  \  Y Y  \/ __ \|   |  \/ /_/ | '
  echo ' |____|_  /\___  >____  /\___  >__|   /_______  /\___  >   __/|____/\____// ____|  \______  /\____/|__|_|  /__|_|  (____  /___|  /\____ | '
  echo '        \/     \/     \/     \/               \/     \/|__|               \/              \/             \/      \/     \/     \/      \/ '

  double_echo

  if [ -f "$react_project_dir/package.json" ]; then
    echo "[\$]> echo \"\$(jq \".scripts.deploy = \\\"rsync -r -a -v -e ssh --delete build/ droplet:/root/www/$react_project_name\\\"\" $react_project_dir/package.json)\" > $react_project_dir/package.json"

    echo "$(jq ".scripts.deploy = \"rsync -r -a -v -e ssh --delete build/ droplet:/root/www/$react_project_name\"" $react_project_dir/package.json)" > $react_project_dir/package.json
  else
    echo "the file '$react_project_dir/package.json' does not exist"
  fi
}

function update_react_public_index_html {
  echo '__________                      __    __________     ___.   .__  .__         .___            .___                ___ ___________________  .____     '
  echo '\______   \ ____ _____    _____/  |_  \______   \__ _\_ |__ |  | |__| ____   |   | ____    __| _/____ ___  ___  /   |   \__    ___/     \ |    |    '
  echo ' |       _// __ \\__  \ _/ ___\   __\  |     ___/  |  \ __ \|  | |  |/ ___\  |   |/    \  / __ |/ __ \\  \/  / /    ~    \|    | /  \ /  \|    |    '
  echo ' |    |   \  ___/ / __ \\  \___|  |    |    |   |  |  / \_\ \  |_|  \  \___  |   |   |  \/ /_/ \  ___/ >    <  \    Y    /|    |/    Y    \    |___ '
  echo ' |____|_  /\___  >____  /\___  >__|    |____|   |____/|___  /____/__|\___  > |___|___|  /\____ |\___  >__/\_ \  \___|_  / |____|\____|__  /_______ \'
  echo '        \/     \/     \/     \/                           \/             \/           \/      \/    \/      \/        \/                \/        \/'

  double_echo

  if [ -f "$react_project_dir/public/index.html" ]; then
    echo "[\$]> echo \"\$(xq -x \".html.head.title = '$project_name_spaces' | (.html.head.meta[] | select(.'@name' == 'description') | .'@content') |= '$project_name_spaces'\" $react_project_dir/public/index.html)\" > $react_project_dir/public/index.html"

    echo "$(xq -x ".html.head.title = \"$project_name_spaces\" | (.html.head.meta[] | select(.\"@name\" == \"description\") | .\"@content\") |= \"$project_name_spaces\"" $react_project_dir/public/index.html)" > $react_project_dir/public/index.html

    double_echo

    if grep -q '<!DOCTYPE html>' $react_project_dir/public/index.html; then
      echo "<!DOCTYPE html> has already been added to $react_project_dir/public/index.html"
    else
      echo "[\$]> sed -i '' '1s/^/<!DOCTYPE html>\\\n/' $react_project_dir/public/index.html"

      # NOTE: add back "<!DOCTYPE html>" since it is removed when xq converts html to xml
      sed -i '' '1s/^/<!DOCTYPE html>\n/' $react_project_dir/public/index.html
    fi

    double_echo

    echo "[\$]> sed -i '' 's#></meta># />#g' $react_project_dir/public/index.html"

    sed -i '' 's#></meta># />#g' $react_project_dir/public/index.html

    double_echo

    echo "[\$]> sed -i '' 's#></link># />#g' $react_project_dir/public/index.html"

    sed -i '' 's#></link># />#g' $react_project_dir/public/index.html
  else
    echo "the file '$react_project_dir/public/index.html' does not exist"
  fi
}

function update_react_public_manifest_json {
  echo '__________                      __    __________     ___.   .__  .__            _____                .__  _____                __         ____. _________________    _______   '
  echo '\______   \ ____ _____    _____/  |_  \______   \__ _\_ |__ |  | |__| ____     /     \ _____    ____ |__|/ ____\____   _______/  |_      |    |/   _____/\_____  \   \      \  '
  echo ' |       _// __ \\__  \ _/ ___\   __\  |     ___/  |  \ __ \|  | |  |/ ___\   /  \ /  \\__  \  /    \|  \   __\/ __ \ /  ___/\   __\     |    |\_____  \  /   |   \  /   |   \ '
  echo ' |    |   \  ___/ / __ \\  \___|  |    |    |   |  |  / \_\ \  |_|  \  \___  /    Y    \/ __ \|   |  \  ||  | \  ___/ \___ \  |  |   /\__|    |/        \/    |    \/    |    \'
  echo ' |____|_  /\___  >____  /\___  >__|    |____|   |____/|___  /____/__|\___  > \____|__  (____  /___|  /__||__|  \___  >____  > |__|   \________/_______  /\_______  /\____|__  /'
  echo '        \/     \/     \/     \/                           \/             \/          \/     \/     \/              \/     \/                          \/         \/         \/ '

  double_echo

  if [ -f "$react_project_dir/public/manifest.json" ]; then
    echo "[\$]> echo \"\$(jq \".short_name = \\\"$project_name_spaces\\\" | .name = \\\"$project_name_spaces\\\"\" $react_project_dir/public/manifest.json)\" > $react_project_dir/public/manifest.json"

    echo "$(jq ".short_name = \"$project_name_spaces\" | .name = \"$project_name_spaces\"" $react_project_dir/public/manifest.json)" > $react_project_dir/public/manifest.json
  else
    echo "the file '$react_project_dir/public/manifest.json' does not exist"
  fi
}

function check_logo {
  echo '_________ .__                   __     .____                         '
  echo '\_   ___ \|  |__   ____   ____ |  | __ |    |    ____   ____   ____  '
  echo '/    \  \/|  |  \_/ __ \_/ ___\|  |/ / |    |   /  _ \ / ___\ /  _ \ '
  echo '\     \___|   Y  \  ___/\  \___|    <  |    |__(  <_> ) /_/  >  <_> )'
  echo ' \______  /___|  /\___  >\___  >__|_ \ |_______ \____/\___  / \____/ '
  echo '        \/     \/     \/     \/     \/         \/    /_____/         '

  double_echo

  if [ -f "$assets_dir/logo.svg" ]; then
    echo "the file '$assets_dir/logo.svg' exists"
  else
    echo "the file '$assets_dir/logo.svg' does not exist"
  fi
}

function create_logos {
  echo '_________                        __           .____                               '
  echo '\_   ___ \_______   ____ _____ _/  |_  ____   |    |    ____   ____   ____  ______'
  echo '/    \  \/\_  __ \_/ __ \\__  \\   __\/ __ \  |    |   /  _ \ / ___\ /  _ \/  ___/'
  echo '\     \____|  | \/\  ___/ / __ \|  | \  ___/  |    |__(  <_> ) /_/  >  <_> )___ \ '
  echo ' \______  /|__|    \___  >____  /__|  \___  > |_______ \____/\___  / \____/____  >'
  echo '        \/             \/     \/          \/          \/    /_____/            \/ '

  double_echo

  # macOS does not support readlink, but it does have perl
  system=$(uname -s)
  if [ "${system}" = 'Darwin' ]; then
    dir=$(perl -e 'use Cwd "abs_path"; use File::Basename; print dirname(abs_path(shift))' "$0")
  else
    dir=$(dirname "$(readlink -f "$0")")
  fi

  logo_svg=$assets_dir/logo.svg
  logo_png=$assets_dir/logo.png
  output=$react_project_dir/public

  if [ -f "$logo_svg" ]; then
    if [ -f "$logo_png" ]; then
      echo "the file '$logo_png' already exists"
    else
      rsvg-convert -a -w 1024 $dir/$logo_svg -o $dir/$logo_png
      convert -resize x64 $dir/$logo_png $dir/$output/favicon.ico
      sips -Z 192 $logo_png --out $dir/$output/logo192.png
      sips -Z 512 $logo_png --out $dir/$output/logo512.png
    fi
  else
    echo "the file '$logo_svg' does not exist"
  fi
}

function build_react_project {
  echo '__________      .__.__       .___ __________                      __       _____                 '
  echo '\______   \__ __|__|  |    __| _/ \______   \ ____ _____    _____/  |_    /  _  \ ______ ______  '
  echo ' |    |  _/  |  \  |  |   / __ |   |       _// __ \\__  \ _/ ___\   __\  /  /_\  \\____ \\____ \ '
  echo ' |    |   \  |  /  |  |__/ /_/ |   |    |   \  ___/ / __ \\  \___|  |   /    |    \  |_> >  |_> >'
  echo ' |______  /____/|__|____/\____ |   |____|_  /\___  >____  /\___  >__|   \____|__  /   __/|   __/ '
  echo '        \/                    \/          \/     \/     \/     \/               \/|__|   |__|    '

  double_echo

  if [ -d "$react_project_dir" ]; then
    echo "[\$]> npm run --prefix $react_project_dir build"

    newline

    npm run --prefix $react_project_dir build
  else
    echo "the react project '$react_project_dir' does not exist"
  fi
}

function deploy_react_project {
  echo '________                .__                 __________                      __       _____                 '
  echo '\______ \   ____ ______ |  |   ____ ___.__. \______   \ ____ _____    _____/  |_    /  _  \ ______ ______  '
  echo ' |    |  \_/ __ \\____ \|  |  /  _ <   |  |  |       _// __ \\__  \ _/ ___\   __\  /  /_\  \\____ \\____ \ '
  echo ' |    `   \  ___/|  |_> >  |_(  <_> )___  |  |    |   \  ___/ / __ \\  \___|  |   /    |    \  |_> >  |_> >'
  echo '/_______  /\___  >   __/|____/\____// ____|  |____|_  /\___  >____  /\___  >__|   \____|__  /   __/|   __/ '
  echo '        \/     \/|__|               \/              \/     \/     \/     \/               \/|__|   |__|    '

  double_echo

  if [ -d "$react_project_dir" ]; then
    echo "[\$]> npm run --prefix $react_project_dir deploy"

    newline

    npm run --prefix $react_project_dir deploy
  else
    echo "the react project '$react_project_dir' does not exist"
  fi
}

function print_public_url {
  echo '__________     ___.   .__  .__          ____ _____________.____     '
  echo '\______   \__ _\_ |__ |  | |__| ____   |    |   \______   \    |    '
  echo ' |     ___/  |  \ __ \|  | |  |/ ___\  |    |   /|       _/    |    '
  echo ' |    |   |  |  / \_\ \  |_|  \  \___  |    |  / |    |   \    |___ '
  echo ' |____|   |____/|___  /____/__|\___  > |______/  |____|_  /_______ \'
  echo '                    \/             \/                   \/        \/'

  double_echo

  echo $react_public_url
}

init
