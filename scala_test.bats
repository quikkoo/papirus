#!/bin/bash

CONTAINER=papirus-os

@test "scala installer" {
  run docker exec $CONTAINER /bin/sh papirus.sh scala 2.10.0
  [ $status -eq 0 ]

  # don't check status because it's different in some o.s.
  run docker exec $CONTAINER scala -version
  [ $output = "Scala code runner version 2.10.0 -- Copyright 2002-2012, LAMP/EPFL" ]
}
