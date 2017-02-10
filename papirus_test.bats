#!/bin/bash

CONTAINER=papirus-os

@test "run without tool and version" {
  run docker exec $CONTAINER /bin/sh papirus.sh

  [ $status -eq 1 ]
  [ ${lines[0]} = "missing tool" ]
}

@test "run without version" {
  run docker exec $CONTAINER /bin/sh papirus.sh x

  [ $status -eq 1 ]
  [ ${lines[0]} = "missing version" ]
}
