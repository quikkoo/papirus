#!/bin/bash

CONTAINER=papirus-os

@test "leiningen installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh leiningen 2.5.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER /bin/sh -c "export LEIN_ROOT=true && lein version"
  [ $status -eq 0 ]
}
