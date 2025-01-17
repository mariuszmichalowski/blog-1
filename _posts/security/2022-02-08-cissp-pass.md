---
layout:        post
title:         "CISSP 認定試験に合格した話"
date:          2022-02-08
category:      Security
cover:         /assets/cover14.jpg
redirect_from:
comments:      true
published:     true
latex:         false
photoswipe:    false
syntaxhighlight: false
# sitemap: false
# feed:    false
---

CISSPに合格しましたので、勉強の方法とか試験の流れとかについて書いていきます。

受験前のスペックは、情報処理安全確保支援士試験合格 (未登録)、CompTIA Security+ (2021) などを持っています。

### 1. 公式CBKトレーニングに参加する

NRIセキュアのCISSP CBKトレーニングに参加しました。
12月中旬に、Zoomでオンライントレーニングに5日間連続で参加しました (オンサイトはCOVID-19の影響で開催されません)。
トレーニング費用は44万円(税込)と高額ですが、テキストを読んでもわかりにくいところを講師が例を交えて説明したり、絵や図を描いて説明したりされるので、テキストだけよりも理解しやすいと思います。
また、トレーニングの内容は全て録画されていて、終了後180日間は録画内容を見返すことも可能です。
さらに、終了後のアンケートに答えると、日本語CISSP公式問題集(電子版) を無料で honto で受け取ることができます。

公式CBKトレーニングで受け取ったものは、おおむね以下の通りです：
- トレーニング1週間前：
  - Student Guide 日本語版（紙のテキストは郵送。電子版はVitalSource Bookshelfで閲覧）
  - Student Guide 英語版 (電子版のみ。目次でジャンプできない日本語版よりも全体を歩きやすい)
  - CBK 公式トレーニング 確認問題 (180問)
  - CBK 公式トレーニング 応用シナリオ (各チャプターの概念を実務の状況に当てはめて考える設問)
  - (ISC)²が提供するPDIコース (3つ選んで無料で視聴できる。$240相当)
- トレーニング中：
  - トレーニング内容の録画データ (講師の説明を聞き逃した場合はここで確認)
- トレーニング3週間後くらい：
  - CISSP公式問題集(電子版) (約1300問, hontoのアカウント作成後にhontoで閲覧)
  - CISSP公式問題集セミナー (各講師によるCISSPの考え方や問題集の答えの解説などの動画視聴)

テキストについて、公式CBKトレーニングで使用するテキストは「Student Guide」と呼ばれるもので、Amazonとかで販売されてる「CISSP CBK公式ガイドブック」とは違います。
両方持っている訳ではないので比較はできないですが、Student Guide と CISSP公式問題集 だけで合格できたので、公式CBKトレーニングを受ける場合は、焦って公式ガイドブックを買う必要はないと思います。

トレーニングでは、テキストの説明の他にCISSPとしての考え方についての話があります。
問題集には、どちらを答えても正解に見える問題や、技術的に最良の解答だと間違えてしまう問題があります。
その時に、CISSPにはひっかけ問題がいっぱいある！ではなくて、その背景にはCISSPの考え方があり、答えにはちゃんとした理由があることを認識するときに、CISSPとしての考え方が役に立ちます。

一週間のトレーニングが終わったら、試験の日程を早めに決めて予約しておきましょう。
平日を選んでも少なくとも一ヶ月は待たないと受けられない状態なので、締め切り駆動で勉強していくためにもまずは予約をします (試験日の再設定には手数料が取られるので、安易なリスケは止めましょう)。

### 2. 各チャプターの概要をノートにまとめる

公式CBKトレーニングは「Student Guide」のテキストに沿って行われるのですが、860ページもあるので、大切な部分とわかりにくい部分だけが説明されて、細かい部分は説明されないです。
なので復習のためにも、トレーニング中に書いたメモを読み返したり、テキストを改めて読んだり、録画データを見たりしながら、各チャプターの概要のまとめを自分で作っておくと良いと思います。
各チャプターの概要のまとめは、テキストファイルや電子データでまとめておくと、後で追加したり修正したりするときに便利です。

あとは、テキストの日本語はオリジナルの英語を訳したものなので、若干揺らぎがあります。
例えば、Administrative は「管理」や「行政」や「運営」などと訳されるように、言葉を日本語で覚えるのは危険です。
可能な限り、英語での元の単語は何かを確認することをお勧めします。

### 3. CISSP公式問題集を解く

各チャプターの概要のまとめを作っていると飽きてくるので、1つのチャプターをまとめたら関連するドメインの問題集を解いてみます。
問題集をやると、忘れている・知らない単語が出てくるのですが、電子版のテキストで検索してその周辺をもう一度読み込んで、各チャプターの概要のまとめをアップデートします。
テキストに存在しない単語も、関連するチャプターのまとめに追加して、後で確認できるようにします。

問題の解答時に、自信がない時は「?」マークを付けておくと、よくわかっていないのに正解だったからOK、という安易な過ちを回避できるようになります。
自信がない問題は、ちゃんと内容を理解した上で答えられるようにします。

そして一番大事なのは、公式問題集の問題を過学習しすぎないことです。
問題集に頼りすぎると、設問の問題にこの単語が含まれるときはこの解答を選ぶ、みたいなワンパターンの思考になってしまいます。
定期的に、自分で作った各チャプターの概要のまとめを読み返して、全体像を把握するようにします。
私の場合は、問題集は1.5周くらいしか取り組みませんでした。

問題集には日本語の下に英語が書かれているので、少なくとも単語の選択肢のときの英単語だけでも読んでおくと、試験の時に翻訳が怪しい日本語が出てきても自信を持って解答できるようになります。

### 4. CISSP認定試験を受ける

住んでいる場所の近くに試験会場がなくて、試験開始の午前8:00の30分前 (つまり、7:30) に集合することが困難な場合は、前泊します。
私は試験会場をピアソンプロフェッショナルセンター新宿にしていたので、そこから歩いて1分の西鉄イン新宿に泊まりました。

ビル内のエレベータ前で通話で自動ドアを開けてもらい、8Fに上がると、待合室＆受付があるので、そこで受付をします。

本人確認は、顔写真付き証明書と、署名付き証明書の2点が必要なので、私は運転免許証とマイナンバーカードを提出しました。
「署名付き証明書」は、臓器提供に関する意思表示欄の本人署名(自筆)を書いておけば、大丈夫みたいです。

その後は、署名のチェック、スマホの電源オフのチェック、手のひらスキャン、メガネのチェックと進んでいきます。
確認が終わると、カバンをロッカーの奥に入れて、ロッカー内の手前に飲み物や軽食を置いておきます。
試験時に持ち歩くことができるものは身分証明書1つとロッカーの鍵だけです。

名前を呼ばれたら、部屋の奥の方に進み、本人確認をしてポケットの中を確認し、試験の説明を聞いて質問がなければ、パソコンの席まで誘導されます。
監視員が受ける試験を選択して、準備ができたら席に座る、という流れです。
試験のポリシーに5分以内に同意をして、試験を開始します。

流れはピアソンVUEのサイトの[受験当日のテストセンターでの流れ](https://www.pearsonvue.co.jp/Test-takers/security.aspx)の動画が一番わかりやすいです。
初めての方は一度目を通しておくことをおすすめします。

受験した日のCISSP受験者は私一人しかいないようで、私だけ個室みたいな部屋で受けていました (もちろん背後は外から監視できるドアです)。
私が試験している間に後ろでは、新しい人が入ったり、試験を終えたか休憩かで人が出たりしていたので、他の試験が同時並行で進んでいた感じだと思います。

CISSPの試験は、1000点満点中700点を取ると合格です。次の問題に進むと前に戻れない形式です。試験時間が最長6時間で、全部で250問あるので、1時間で50問ずつ解答し続ける感じです。
試験は日本語だと6時間、英語だと3時間なので、半分は英語が変な感じに翻訳されていないかを確認するための時間という心構えで受けると良いです。

休憩する際は手を上げて監視員を呼んで画面をロックしてもらい、首にストラップをかけた状態で休憩します。
私は、真ん中の125問目を解いたところで10分休憩しました。
飲み物や軽食が可能で、トイレに行くことも可能です。
戻る時は、再度本人確認とポケットの中の確認をしてから、席に着いて、画面ロックを解除してもらいます。

250問全て解き終わったら、手を上げて監視員の案内に従って移動し、受付で結果を受け取りました。

### 終わりに

帰りの新幹線に乗りながら、無事合格したことを会社に報告できることと、余計な心配をせずに会社に経費精算できることを考えていたら、あっという間に終点に着きました。
COVID-19のオミクロン株の影響があるなかで、いろんな意味でドキドキしながら受けましたが、無事合格できてよかったです。

CISSPとして認定されるには4〜5年の実務経験が必要なのですが、私はまだ条件を満たしていないので、まずは (ISC)2 準会員として登録しようと思います。

最後に、この記事がCISSPを目指す方の意思決定の材料になれば幸いです。

### 参考文献

- [CISSP に挑戦した話(再投稿) – morihi-soc](https://www.morihi-soc.net/?p=83)
- [エンジニア経験ゼロの文系ギャルが「CISSP®認定試験」を受ける - ラック・セキュリティごった煮ブログ](https://devblog.lac.co.jp/entry/20220117)
- [(ISC)² Japan - Computer Based Testing(CBT)試験](https://japan.isc2.org/examination_application.html)
