---
layout:        post
title:         "Perl6 (Raku) で要素が一つの配列の作り方"
menutitle:     "Perl6 (Raku) で要素が一つの配列の作り方"
date:          2017-02-21
category:      Raku
author:        tex2e
cover:         /assets/cover1.jpg
redirect_from: /perl6/one-element-array
comments:      false
published:     true
---

Perl6 (Raku) で要素が一つの配列（特にハッシュの配列または配列の配列）を定義しようとしたときに、Rubyのように書いていたらつまづいたので、ここにメモします。


よくやるパターン
---------------

次に示すように、ハッシュの配列を定義しようとすると、ペア（Pair）の配列になってしまう問題がある。
もちろん、これは期待していない振る舞いだ。

```perl6
my @list = [
    { name => "foo", id => 1 }
];
@list.perl.say;
```

上の出力（ペアの配列）

```perl6
[:id(1), :name("foo")]
```


解決法
---------------

`{ }` の末尾に `,` を入れることで、正しくハッシュと認識される。
この問題は 2次元配列でも起きるようだが、同様に `[ ]` の末尾に `,` を入れれば良い。

```perl6
my @list = [
    { name => "foo", id => 1 }, # <= カンマがあることに注目
];
@list.perl.say;
```

上の出力（ハッシュの配列）

```perl6
[{:id(1), :name("foo")},]
```