#!/bin/bash

CONTAINER=papirus-os

@test "groovy installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh groovy 2.3.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER groovy -version
  [ $status -eq 0 ]
}
