#!/bin/bash

alacritty msg create-window "$@" || exec alacritty "$@"
