---
layout:        post
title:         "Windowsのセキュリティログで注目すべきイベントID"
date:          2021-11-05
category:      Windows
cover:         /assets/cover1.jpg
redirect_from:
comments:      true
published:     true
latex:         false
photoswipe:    false
syntaxhighlight: true
# sitemap: false
# feed:    false
---

Windowsの イベントビューアー(eventvwr.msc /s)＞Windowsログ＞セキュリティ で見ることができるセキュリティログで注目すべきイベントIDには以下のものがあります。

| イベントID | 説明
|------|----
| **4624** | アカウントが正常にログオンしました。
| 4672 | 新しいログオンに特権が割り当てられました。
| 4688 | 新しいプロセスが作成されました。
| **4697** | サービスがシステムにインストールされました。
| **4698** | スケジュールされたタスクが作成されました。
| **4702** | スケジュールされたタスクがアップデートされました。
| 4768 | Kerberos 認証チケット (TGT) が要求されました (ADサーバ)。
| 4769 | Kerberos サービス チケットが要求されました (ADサーバ)。
| 5140 | ネットワーク共有オブジェクトにアクセスしました。
| 5145 | クライアントに必要なアクセスを付与できるかどうかについて、ネットワーク共有オブジェクトがチェックされました。

以上です。