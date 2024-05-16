#!/usr/bin/env zsh

set -vuex

source .venv/bin/activate 

maturin develop -m ../xvc.py/Cargo.toml

for d in test-data .xvc .git ; do
  if [ -d Readme/$d ] ; then
    chmod -R +w Readme/${d}
    rm -rf Readme/${d}
  fi
done

jupyter lab --notebook-dir=Readme/ &
open http://localhost:8000/lab/workspaces/auto-H/tree/Readme.ipynb

