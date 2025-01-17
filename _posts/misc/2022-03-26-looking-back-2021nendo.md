---
layout:        post
title:         "2021年度振り返り"
date:          2022-03-26
category:      Misc
cover:         /assets/cover2.jpg
redirect_from:
comments:      true
published:     true
latex:         false
photoswipe:    false
# sitemap: false
# feed:    false
---

2021年度に対する個人的な駄文です。一言でまとめると、今年はセキュリティの年でした。

4月、CompTIA Security+ の資格取得に向けた勉強を開始しました。1回目は不合格でしたが、2回目でなんとか合格しました。
部署異動する前に応用情報の予約もしていたので、2つの日程が近い状態で受けてしまったのが良くなかったですが、合格できてよかったです。

5月、プラットフォーム診断のグループに配属となりました。
/
プライベート面では、眼への負担を減らすために、度数の異なる眼鏡を2つ購入しました。
1つは遠くも見える運転用の眼鏡、もう1つはパソコン作業用（距離: 60〜70cm) の眼鏡です。
/
さらに同じ時期に、M1のiMacを購入しました。
イベントにリモートで参加するために別部屋に配置するPCがもう一台必要だったので購入しました。

6月、Webの脆弱性を利用したペネトレーションテストの技術検証をしていました。また、4〜6月の間に Hack The Box でトレーニングを積んでいました。
RCEなどを実施する中で、権限昇格の攻撃が通らない環境ではSELinuxやAppArmorが有効になっており、強制アクセス制御 (MAC) の偉大さを改めて知りました。
/
自宅では、Hack The Box に VPN 接続できるように、IPv6 対応しているプロバイダーに乗り換えました。
Wi-FiルータもWPA3対応済みのものにリプレイスしたので、より高速で安全な通信環境になりました。
/
会社では、Udemy Businessのアカウントを利用して様々な講座を無料で見ることができました。
今回のこの仕組みで英語の講座を含めた色々な講座を見ることができてよかったです。

7月、Web診断のグループに配属となりました。また、この頃にはセキュリティ・キャンプ全国大会のチュータとして参加することが決まっていたので、以前技術検証したマイナンバーカードで署名する方法を復習したり、LT大会用の発表資料作成など、キャンプに向けた準備を進めていました。

8月、セキュリティ・キャンプ全国大会2021 オンラインの「暗号の脆弱性や攻撃手法を理解して説明しようゼミ」のチュータとして参加しました。
詳細は「[seccamp2021チュータ参加記](https://tex2e.github.io/blog/misc/seccamp2021)」をご覧ください。

9月、他の人が書いた手順書の中の参考文献に、自分が作成・運営しているRFC翻訳サイトへのリンクが貼ってあるのを発見しました。
RFCの英語を読むのが苦手な人の助けになっていて、役に立っているなと感じました。
/
趣味では、QUICのハンドシェイクをPythonで実装していました。
QUICの一番最初の通信であるInitial Packetを復号するところから始めていました。
詳細は「[QUIC の Initial Packet を復号する](https://tex2e.github.io/blog/protocol/quic-initial-packet-decrypt)」をご覧ください。
その後、Handshake Packet も復号するところまで実装して通信できるところまで作りました。
/
社内ではいくつかの社内システムが新しくなり、特に勤怠管理の入力がより綺麗で使いやすいUIになりました。
IEサポート終了に伴って、IE依存の全てのシステムが無くなることを切に願っております。

10月、Hardening Project に参加することが決まり、SELinuxの導入と運用を目標に、チートシートの作成などの事前準備をしていました。
その他、某CTF向けに TLS 1.3 の知識を使って Wireshark と Python で解けるようなネットワーク問題を2問作成し、問題を提供しました。

11月、Hardening Project の競技に参加しました。
個人目標である「SELinuxの導入と運用」の技術検証をし、RCEの脆弱性に対する攻撃などを防ぐことができました。
Team8としての取り組みが評価され、受賞したスポンサー賞の副賞は美味しくいただきました。
詳細は「[Hardening 2021 Active Fault 参加記](https://tex2e.github.io/blog/misc/hardening2021af)」をご覧ください。

12月、2年前に書いた個人ブログの記事「[AES (Rijndael) の MixColumns を理解する](https://tex2e.github.io/blog/crypto/aes-mix-columns)」の説明内容が曖昧との指摘を受け、NISTの仕様書やAESに関する論文を改めて読みながら、暗号化行列として使われるMDS行列について理解を深めました。

1月、WASNight 2022のHardening Sessionで振り返りという名のSELinuxについての発表を10分程度しました。
/
SNS周りのアイコンを新しいものに変更しました。

2月、CISSP認定試験を受けました。6時間という長い時間でしたが無事合格できました。
CISSPを通して、セキュリティの知識だけはなく、意思決定のプロセスについても学ぶことができ、大変学びのある試験でした。
実務経験が足りないので、まずは ISC2 準会員として登録して毎年 15 CPE を獲得していきたいと思います。

3月、今年度SELinuxについて勉強したことを、章立てしてまとめてブログで公開しました。
詳細は [1. SELinux/アクセス制御の仕組み](https://tex2e.github.io/blog/linux/1-access-control) をご覧ください。
また、直近で公表された Dirty Pipe の脆弱性について、SELinux で攻撃を緩和できる話を [Dirty Pipeの脆弱性をSELinuxで緩和する](https://tex2e.github.io/blog/linux/dirty-pipe) にブログ記事で公開して 10 CPE を獲得しました。

今年度は、技術面では QUIC と SELinux などに詳しくなりました。
プライベートではMacOSやLinuxをよく使う一方で、仕事では相変わらずWindowsを使っています。
昔は、WindowsよりもLinux系の方が強いのだ！と思っていましたが、Windowsの長所を無視して短所だけに注目して関わらないのは、対人関係と同じで、Windowsに対して無知な自分を受け入れられないか、Windowsの作業で失敗する可能性から回避するためにWindowsの短所に注目して関わらないようにする、という心理状態になっていたのではないかと思っています。
Linuxの方が詳しいのにWindowsの仕事をやらせるのは、会社は私の技術力を正しく評価できていないのでは... と思ったりもしますが、会社に評価されることが私の人生の最優先事項ではないので、プライベートではできないことを会社ではやっていきたいよね、学んだ技術をより多くの人に還元できる場所があればいいよね、くらいの気持ちで来年度も仕事に取り組んでいきたいと思います。
仕事は金銭を稼ぐための手段ですが、仕事の本質は他者への貢献です。
人間は分業システムによって、お互いの劣等性を補うために社会という構造を作りました。
高度に分業化された社会においては、利己的に自分のスキルや技術を極めることが、結果として利他的になり、社会貢献につながると信じています。

来年度は、異動でまた公共システムを開発している部署に戻るので、また開発畑の人になりそうです。
仕事内容は一変しますが、来年度も引き続き面白そうなところに足を突っ込んでいきたいと思います。
