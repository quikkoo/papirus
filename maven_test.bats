#!/bin/bash

CONTAINER=papirus-os

@test "maven installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh maven 3.1.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER mvn -version
  [ $status -eq 0 ]
}
