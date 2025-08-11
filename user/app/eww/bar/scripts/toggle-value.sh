#!/usr/bin/env bash

case "$1" in
  *"true"*)
    eww update "$1"=false
    ;;
  *)
    eww update "$1"=true
    ;;
esac
