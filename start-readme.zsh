#!/usr/bin/env zsh

set -vuex

cd $(dirname $0)

source .venv/bin/activate 

maturin develop -m ../xvc.py/Cargo.toml

for d in test-data .xvc .git ; do
  if [ -d Readme/$d ] ; then
    chmod -R +w Readme/${d}
    rm -rf Readme/${d}
  fi
done

PORT=7979
if [[ -z "$(ps ax | rg jupyter-lab | rg -v ps | rg $PORT)" ]] ; then
  jupyter lab --port=$PORT --notebook-dir=Readme/ &
  open http://localhost:${PORT}/lab/workspaces/auto-H/tree/Readme.ipynb
fi


