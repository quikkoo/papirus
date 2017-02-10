#!/bin/bash

CONTAINER=papirus-os

@test "go installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh go 1.5.1
  [ $status -eq 0 ]

  run docker exec $CONTAINER /bin/sh -c "export GOROOT=/opt/golang && go version"
  [ $status -eq 0 ]
}
