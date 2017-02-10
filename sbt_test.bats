#!/bin/bash

CONTAINER=papirus-os

@test "sbt installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh sbt 0.13.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER sbt sbt-version
  [ $status -eq 0 ]
}
