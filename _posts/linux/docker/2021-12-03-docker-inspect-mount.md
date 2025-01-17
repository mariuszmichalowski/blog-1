---
layout:        post
title:         "起動しているDockerコンテナのマウントを調査する"
date:          2021-12-03
category:      Linux
cover:         /assets/cover14.jpg
redirect_from:
comments:      true
published:     true
latex:         false
photoswipe:    false
# sitemap: false
# feed:    false
---

起動しているDockerコンテナがホストのディレクトリをマウントしているかや、どのディレクトリがマウントされているかは「docker inspect」コマンドで調べることができます。
```bash
~]$ docker ps -a
~]$ docker inspect コンテナID
```
以下はコンテナ起動時に -v /var/mnt:/var/mnt を指定したときの結果です。
Sourceがホスト側のディレクトリ、Destinationがコンテナ側のディレクトリです。
```bash
~]$ docker inspect コンテナID | grep -A9 Mounts
        "Mounts": [
            {
                "Type": "bind",
                "Source": "/var/mnt",
                "Destination": "/var/mnt",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],
```
以上です。
