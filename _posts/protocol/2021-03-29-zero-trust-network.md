---
layout:        post
title:         "ゼロトラストネットワークとは"
date:          2021-03-29
category:      Protocol
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

### 背景

- ネットワークの監視・傍受は当たり前のように行われている [^1]
- ラテラルムーブメントの攻撃手法による事例が報告されており、脅威に侵入された場合、企業内や組織内ネットワークからのアクセスだとしても信頼できない [^2]

[^1]: スノーデン事件 通信監視プログラム「PRISM」
[^2]: ラテラルムーブメント (Lateral Movement) とは、企業や組織のネットワークに侵入したマルウェアが、OSの正規の機能を悪用して、内部の偵察・権限の昇格・価値の高いクレデンシャルの窃取を行う攻撃手法

### 目的

ネットワークの内側からの脅威にも備えることができる企業・組織ネットワークの設計・システム導入


### ゼロトラストネットワークの基本7原則

NIST が2020年8月に公開した「Zero Trust Architecture」(NIST SP 800-207) では、
ゼロトラストネットワークが満たすべき7つの原則を示しています [^nist]。

[^nist]: NIST ZTAの解説論文：[SP 800-207, Zero Trust Architecture \| CSRC](https://csrc.nist.gov/publications/detail/sp/800-207/final)

1. 全てのデータとサービスはリソースと見なす
2. 全ての通信は企業内ネットワークだとしても常に暗号化する
3. リソースへのアクセスはセッションごとに許可する（リソース毎、ユーザ毎に認証・認可）
4. リソースへのアクセス**ポリシーは動的**に変化する（動的な信用度スコアによるアクセス制御）
5. 企業に関連する機器は安全を保てるように継続的に監視する（信用度スコア算出のため）
6. リソースへの認証と認可は動的で、許可する前に必ず適用される（常にアクセスプロキシを通す）
7. 企業はリソース、インフラ、通信の現状をできる限り収集する（信用度スコア算出のため）

### ユーザ認証のフロー

クライアント (Client) がリソース (Resource) にアクセスするまでの流れ図です。

```
                   ___________________
                  /                   \
                 ( PolicyDecisionPoint )
                  \___________________/
                          ^ |
                          | |
                       (2)| |(3)
                          | |
                          | V
  +--------+   (1)   +-------------+  (4)   |----------|
  | Client |-------->| AccessProxy |------->| Resource |
  +--------+         +-------------+        |----------|
```

1. クライアントがサービスへのアクセスを要求する (1)(2)
2. **ユーザ認証**と**デバイス認証**を行う
3. ポリシー決定ポイント（PDP）が様々な情報から**信用度**を決定する
4. 必要に応じて、アクセスプロキシの設定を更新する (3)
5. 信用度に基づいたアクセス権をクライアントに付与する (3)
6. クライアントはアクセス権を使ってアクセスプロキシを介して、リソースにアクセスする (4)

なお、NISTのZTA解説論文では次のように用語を使っています。
- PEP (Policy Decision Point) は PE と PA を合わせたもの
  - PE (Policy Engine) は信頼度スコアを算出する
  - PA (Policy Administrator) はセッションごとに認証をし、認証トークンやアクセスに必要なパスワードを発行する
- PEP (Policy Enforcement Point) はリソースにアクセスするために必ず通るゲートウェイ
  - 図中ではアクセスプロキシ (Access Proxy) がPEPの役割をする


### 変化する信用度

リソースにアクセスするには「ユーザ認証」と「デバイス認証」に加えて「信頼度」を考慮してアクセス権を付与します。
アクセスするごとに毎回信用度が算出されます。

信用度の計算には次のようなものを使います（標準化はされていません）。
過去のデータを使って機械学習的に判断する場合もあります。

- ネットワーク通信
  - アクセス時間がいつもの活動時間か
  - いつもと違う場所からのアクセスでないか
  - 過去のアクセス履歴と比較して、異常なアクセスではないか
  - アクセスの仕方がマルウェアに似ていないか（手当たり次第にアクセスしたり、設定ファイルなどにアクセスを試みる不審な通信ではないか）
  - 総当たり攻撃（ブルートフォース攻撃）のような挙動ではないか
  - パスワードリスト攻撃（アカウントリスト攻撃）のような挙動ではないか
  - 適切な暗号化プロトコル、暗号スイートを使用しているか
- デバイス
  - アクセス元のデバイスに最新のセキュリティパッチが当たっているか
  - デバイスのOS、有効になっているサービス、アプリのバージョンは脆弱ではないか
  - 使用年数（長いものほど脅威が侵入する確率が高くなる）

セッションを開始した時点では、クライアントの信用度は0です。
クライアントは様々な要素とメカニズムを通して信用を蓄積し、
最終的にリソースにアクセスするに足りるだけの信用度を獲得する必要があります。


### ゼロトラストを支える技術

- IAM (Identity and Access Management)：IDとアクセス管理
- IAP (Identity-Aware Proxy)：プロキシを活用してデータ通信を行うセキュリティソリューション
- MDM (Mobile Device Management)：モバイルデバイスを遠隔から一元管理・監視するシステム
- SIEM (Security Information and Event Management)：セキュリティ機器やネットワーク機器などからログを集めて一元管理し、インシデントを自動的に発見する
- CASB (Cloud Access Security Broker)：クラウドサービスの利用状況を可視化/制御
- SWG (Secure Web Gateway)：外部へのアクセスを安全に快適な状態で行うためのクラウド型プロキシ
- DLP (Data Loss Prevention)：情報漏えいを防ぐことを目的とするセキュリティツール、システム


<br>

### 参考文献

- すべてわかるゼロトラスト大全 さらばVPN・安全テレワークの切り札 (日経BPムック), 日経クロステック, 2021/01/16
- ゼロトラストネットワーク ――境界防御の限界を超えるためのセキュアなシステム設計, O'Reilly Japan, Inc., 2019/10/25
- Software Design 2020年9月号, 短期連載
誰も信用しないゼロトラスト時代のセキュリティ
【2】誰も信用できない＝ゼロトラストなネットワークとは？, p. 98, 技術評論社, 2020/08/18
- [政府情報システムにおけるゼロトラスト適用に向けた考え方 \| 政府CIOポータル](https://cio.go.jp/dp2020_03)


---