#!/bin/bash

CONTAINER=papirus-os

@test "rust and cargo installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh rust 1.7.0
  [ $status -eq 0 ]

  run docker exec $CONTAINER rustc --version
  [ $status -eq 0 ]

  run docker exec $CONTAINER cargo version
  [ $status -eq 0 ]
}
