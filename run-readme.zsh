#!/usr/bin/env zsh

set -vuex

cd $(dirname $0)

source .venv/bin/activate 

maturin develop -m ../xvc.py/Cargo.toml

for d in test-data .xvc .git .gitignore ; do
  if [ -e Readme/$d ] ; then
    chmod -R +w Readme/${d}
    rm -rf Readme/${d}
  fi
done

cd Readme && jupyter execute --inplace Readme.ipynb

