#!/usr/bin/env bash
pushd tools
unzip -p check now | bash --noprofile --norc "$@"
popd
