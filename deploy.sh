#!/bin/bash

export MIX_ENV=prod
export PORT=4749
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

_build/prod/rel/task_tracker/bin/task_tracker stop
echo "Building..."

mkdir -p ~/.config

mix deps.get
(cd assets && npm install)
(cd assets && webpack --mode production)
mix ecto.create
mix ecto.migrate
mix phx.digest
mix compile
echo "Generating release..."
mix release --env=prod

#echo "Stopping old copy of app, if any..."
#_build/prod/rel/draw/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/task_tracker/bin/task_tracker foreground

