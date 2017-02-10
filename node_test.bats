#!/bin/bash

CONTAINER=papirus-os

@test "node and npm installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh node 4.0.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER node --version
  [ $status -eq 0 ]

  run docker exec $CONTAINER npm --version
  [ $status -eq 0 ]
}
