#!/usr/bin/env bash

ssh -p 2422 -i ~/.vagrant.d/insecure_private_key vagrant@127.0.0.1 mozc_emacs_helper "$@"
