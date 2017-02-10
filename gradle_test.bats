#!/bin/bash

CONTAINER=papirus-os

@test "gradle installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh gradle 3.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER gradle -version
  [ $status -eq 0 ]
}
