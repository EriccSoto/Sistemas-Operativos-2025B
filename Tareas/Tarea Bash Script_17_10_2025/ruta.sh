#!/bin/bash
sampleFunction () {
  mkdir -p $1
  cd $1
  pwd
}
sampleFunction myDir
