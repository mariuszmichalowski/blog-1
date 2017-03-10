#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "ArguemntError: wrong number of arguments (given $#, expected 2)"
  exit 1
fi

cat > _posts/$1/$(date +%Y-%m-%d)-${2:-post}.md <<EOS
---
layout:        post
title:         "This_is_Awesome"
menutitle:     "Menu_Title"
date:          $(date +%Y-%m-%d)
tags:          Programming Language Foo_Bar
category:      Foo_Bar
author:        tex2e
cover:         /assets/cover1.jpg
redirect_from:
comments:      true
published:     true
---

preface

EOS
