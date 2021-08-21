---
layout:        post
title:         "AES (Rijndael) の MixColumns を理解する"
menutitle:     "AES (Rijndael) の MixColumns を理解する (Adv.Cal. 2019)"
date:          2019-12-11
category:      Crypto
author:        tex2e
cover:         /assets/cover4.jpg
redirect_from:
comments:      true
published:     true
latex:         true
# sitemap: false
# draft:   true
---

AES (Rijndael) には攪拌するための処理の一つに MixColumns という処理があります。
AES を説明する記事は大量にあるにも関わらず、この MixColumns の処理は数学(数論)の知識が必要というだけで敬遠されているようなので、MixColumns について説明していきます。

AES [^NIST] の暗号処理は、内部に 4×4 の状態を持ち、ラウンド関数を繰り返す SPN 構造 [^SPN] となっていて、ラウンド関数は、暗号処理の基本となる置換 (Substitution) と転置 (Permutation) を組み合わせたものです [^Okamoto2019] [^AES-round]。
MixColumns の処理は「転置」にあたる部分の処理です。

```fig
  +---+---+---+---+           +---+---+---+---+
  | 0 | 4 | 8 | c |           | 0'| 4'| 8'| c'|
  +---+---+---+---+           +---+---+---+---+
  | 1 | 5 | 9 | d |           | 1'| 5'| 9'| d'|
  +---+---+---+---+           +---+---+---+---+
  | 2 | 6 | a | e |           | 2'| 6'| a'| e'|
  +---+---+---+---+           +---+---+---+---+
  | 3 | 7 | b | f |           | 3'| 7'| b'| f'|
  +---+---+---+---+           +---+---+---+---+
    |   |   |   |               ^   ^   ^   ^
    +---|---|---|---------------+   |   |   |
        +---|---|-------------------+   |   |
            +---|-----------------------+   |
                +---------------------------+
                  列ごとにMixColumnsの処理を行う
```

### 数式

MixColumns の処理を数式で表すと次のようになります。つまり行列の掛け算です。
変換前が $b_i$ で、変換後が $d_i$ です。

$$
\begin{bmatrix}
  d_0 \\
  d_1 \\
  d_2 \\
  d_3
\end{bmatrix}
=
\begin{bmatrix}
  \text{02} & \text{03} & \text{01} & \text{01} \\
  \text{01} & \text{02} & \text{03} & \text{01} \\
  \text{01} & \text{01} & \text{02} & \text{03} \\
  \text{03} & \text{01} & \text{01} & \text{02}
\end{bmatrix}
\begin{bmatrix}
  b_0 \\
  b_1 \\
  b_2 \\
  b_3
\end{bmatrix}
$$

ただし注意ですが、各要素は16進数による表現で、拡大体 $\mathrm{GF}(2^8)$ (法既約多項式 : $x^8 + x^4 + x^3 + x + 1$) の要素です。なので、足し算と掛け算は次のように定義されます。

#### 足し算

足し算は2つの要素の**XOR** ($\oplus$) をとります。
例えばバイナリ表現で2つの要素が $$\{a_7 a_6 a_5 a_4 a_3 a_2 a_1 a_0\}$$ と $$\{b_7 b_6 b_5 b_4 b_3 b_2 b_1 b_0\}$$ のとき、足し算の結果は $$\{c_7 c_6 c_5 c_4 c_3 c_2 c_1 c_0\}$$ (ただし $c_i = a_i \oplus b_i$) となります。

以下の数式は全て正しく、表現形式は異なりますが全て同じ意味です。

$$
\begin{aligned}
(x^6 + x^4 + x^2 + x + 1) + (x^7 + x + 1) &= x^7 + x^6 + x^4 + x^2 & \text{(多項式による表現)} \\
\{\text{01010111}\} \oplus \{\text{10000011}\} &= \{\text{11010100}\} & \text{(バイナリによる表現)} \\
\{\text{57}\} \oplus \{\text{83}\} &= \{\text{d4}\} & \text{(16進数による表現)}
\end{aligned}
$$

#### 掛け算

掛け算は要素を多項式と見なして、**多項式同士の掛け算**を行います。
ただし、既約多項式 $x^8 + x^4 + x^3 + x + 1$ を法とする多項式環上で演算を行います。
要素の掛け算を表す記号は「$\cdot{}$」です。

例えば、$$\{\text{57}\} \cdot{} \{\text{83}\} = \{\text{c1}\}$$ となります。
式変形して考えてみると：

$$
\begin{aligned}
\{\text{57}\} \cdot{} \{\text{83}\}
&= (x^6 + x^4 + x^2 + x + 1) (x^7 + x + 1) \\
&= x^{13} + x^{11} + x^9 + x^8 + x^7 + \\
&\phantom{=}\;\; x^7 + x^5 + x^3 + x^2 + x + \\
&\phantom{=}\;\; x^6 + x^4 + x^2 + x + 1 \\[2pt]
&= x^{13} + x^{11} + x^9 + x^8 + x^6 + x^5 + x^4 + x^3 + 1
\end{aligned}
$$

これを、法既約多項式で剰余をとると、右辺と一致します。

$$
\begin{aligned}
&\phantom{=}\;\; x^{13} + x^{11} + x^9 + x^8 + x^6 + x^5 + x^4 + x^3 + 1 \pmod{x^8 + x^4 + x^3 + x + 1} \\[2pt]
&= x^7 + x^6 + 1 \\
&= \{\text{11000001}\} \\
&= \{\text{c1}\}
\end{aligned}
$$

#### 行列の掛け算

上述した足し算「$\oplus$」と掛け算「$\cdot{}$」を使って行列の掛け算を行うと次のようになります。

$$
\begin{bmatrix}
  d_0 \\
  d_1 \\
  d_2 \\
  d_3
\end{bmatrix}
=
\begin{bmatrix}
  \text{02} & \text{03} & \text{01} & \text{01} \\
  \text{01} & \text{02} & \text{03} & \text{01} \\
  \text{01} & \text{01} & \text{02} & \text{03} \\
  \text{03} & \text{01} & \text{01} & \text{02}
\end{bmatrix}
\begin{bmatrix}
  b_0 \\
  b_1 \\
  b_2 \\
  b_3
\end{bmatrix}
$$

$$
\begin{aligned}
  d_0 &= (\{\text{02}\} \cdot{} b_0) \oplus (\{\text{03}\} \cdot{} b_1) \oplus
         (\{\text{01}\} \cdot{} b_2) \oplus (\{\text{01}\} \cdot{} b_3) \\
  d_1 &= (\{\text{01}\} \cdot{} b_0) \oplus (\{\text{02}\} \cdot{} b_1) \oplus
         (\{\text{03}\} \cdot{} b_2) \oplus (\{\text{01}\} \cdot{} b_3) \\
  d_2 &= (\{\text{01}\} \cdot{} b_0) \oplus (\{\text{01}\} \cdot{} b_1) \oplus
         (\{\text{02}\} \cdot{} b_2) \oplus (\{\text{03}\} \cdot{} b_3) \\
  d_3 &= (\{\text{03}\} \cdot{} b_0) \oplus (\{\text{01}\} \cdot{} b_1) \oplus
         (\{\text{01}\} \cdot{} b_2) \oplus (\{\text{02}\} \cdot{} b_3) \\
\end{aligned}
$$

次の章では、これを計算するためのプログラムを作る方法について説明していきます。

<br>

### アルゴリズム

足し算にあたる「$\oplus$」は `^` で計算できます。
なので、実装する必要があるのは、要素同士の掛け算にあたる「$\cdot{}$」です。

#### 掛け算のアルゴリズム

要素の掛け算を行うためには多項式同士の掛け算を行うためのプログラムを書く必要があります。
とりあえず SageMath を使えば簡単に計算できます (以下は $$\{\text{57}\} \cdot{} \{\text{83}\}$$ を計算する SageMath のコードです)。

```python
F.<X> = PolynomialRing(GF(2^8))
R.<x> = F.quotient(X^8 + X^4 + X^3 + X + 1)

R(x^6 + x^4 + x^2 + x + 1) * R(x^7 + x + 1)
# => x^7 + x^6 + 1
```

しかし、SageMath は数学屋さんか暗号屋さんくらいしかインストールしていないと思いますので、素直に実装していきましょう。

まず、ある要素 $b(x)$ は次のように書けます。

$$
b_7 x^7 + b_6 x^6 + b_5 x^5 + b_4 x^4 + b_3 x^3 + b_2 x^2 + b_1 x^1 + b_0
$$

このとき、ある要素 $b(x)$ に $x$ を掛けた多項式は次のように書けます。

$$
b_7 x^8 + b_6 x^7 + b_5 x^6 + b_4 x^5 + b_3 x^4 + b_2 x^3 + b_1 x^2 + b_0 x
$$

このとき、$x \cdot{} b(x)$ を法既約多項式で剰余する必要があります。
なぜなら、要素の最大次数は $x^7$ だからです。

剰余する方法としては $x \cdot{} b(x)$ の計算結果で $b_7 = 1$ であれば、結果から法既約多項式 $x^8 + x^4 + x^3 + x + 1$ を引き算します。
足し算が XOR なら引き算も XOR でできます (GF(2) なので)。
この法既約多項式をバイナリ表現にすると $$\{\text{0000000100011011}\} = \{\text{011b}\}$$ となりますが、計算上は `unsigned char` (1byte)で計算するため、桁あふれ分は考慮しません。
なので、引き算 (XOR) する値は $$\{\text{1b}\}$$ です。
最終的に、$x$ を掛け算する処理というのは「多項式 $b(x)$ に $x$ を掛けて $b_7 = 1$ のときは $$b = b \oplus \{\text{1b}\}$$ する」という流れになります。

この処理を `xtime(b)` という関数にしておきます。C言語で書くと次のようになります。
ここで、`b` は多項式、`<< 1` は $x$ の掛け算、`^` は引き算、`b & 0x80` は $b_7 = 1$ のとき真、`0x1b` は法既約多項式の値を表します。

```c
unsigned char xtime(unsigned char b)
{
    return (b << 1) ^ ((b & 0x80) ? 0x1b : 0x00);
}
```

より高い次元の $x$ を掛け算するときは `xtime` を繰り返します。
多項式に $x$ を掛け算することは、バイナリ表現における左1ビットシフトであり、16進数表現では値を2倍することと同じ意味です。
これによって、任意の値の掛け算を実装することができます。

例えば、先ほど示した例の $$\{\text{57}\} \cdot{} \{\text{83}\} = \{\text{c1}\}$$ をプログラム的に計算してみます。
まずは、forループで $$\{\text{57}\}$$ と $1,2,4,8,16,...,128$ を掛け算したときの結果を用意します。

$$
\begin{matrix}
\{\text{57}\} \cdot{} \{01\} &                                &= \{\text{57}\}\\
\{\text{57}\} \cdot{} \{02\} &= \mathrm{xtime}(\{\text{57}\}) &= \{\text{ae}\}\\
\{\text{57}\} \cdot{} \{04\} &= \mathrm{xtime}(\{\text{ae}\}) &= \{\text{47}\}\\
\{\text{57}\} \cdot{} \{08\} &= \mathrm{xtime}(\{\text{47}\}) &= \{\text{8e}\}\\
\{\text{57}\} \cdot{} \{10\} &= \mathrm{xtime}(\{\text{8e}\}) &= \{\text{07}\}\\
\{\text{57}\} \cdot{} \{20\} &= \mathrm{xtime}(\{\text{07}\}) &= \{\text{0e}\}\\
\{\text{57}\} \cdot{} \{40\} &= \mathrm{xtime}(\{\text{0e}\}) &= \{\text{1c}\}\\
\{\text{57}\} \cdot{} \{80\} &= \mathrm{xtime}(\{\text{1c}\}) &= \{\text{38}\}\\
\end{matrix}
$$

よって、バイナリ法の考え方で

$$
\begin{aligned}
\{\text{57}\} \cdot{} \{83\}
&= \{\text{57}\} \cdot{} ( \{80\} \oplus \{02\} \oplus \{01\} ) \\
&= (\{\text{57}\} \cdot{} \{80\}) \oplus (\{\text{57}\} \cdot{} \{02\}) \oplus (\{\text{57}\} \cdot{} \{01\}) \\
&= \{\text{38}\} \oplus \{\text{ae}\} \oplus \{\text{57}\} \\
&= \{\text{c1}\}
\end{aligned}
$$

となり、これを応用すれば任意の要素同士の掛け算を行うことができます。
この処理を `dot(x, y)` という関数にして、C言語で書くと次のようになります。

```c
unsigned char dot(unsigned char x, unsigned char y)
{
    unsigned char mask;
    unsigned char product = 0;

    for (mask = 0x01; mask; mask <<= 1) {
        if (y & mask) {
            product ^= x;
        }
        x = xtime(x);
    }
    return product;
}
```

#### 行列の掛け算のアルゴリズム

足し算「$\oplus$」と掛け算「$\cdot{}$」がプログラムで計算できるようになったので、MixColumns の処理である行列の掛け算が実装できるようになります。
繰り返しになりますが、変換前が $b_i$、変換後が $d_i$ とすると、変換は次の数式で書けます。

$$
\begin{bmatrix}
  d_0 \\
  d_1 \\
  d_2 \\
  d_3
\end{bmatrix}
=
\begin{bmatrix}
  \text{02} & \text{03} & \text{01} & \text{01} \\
  \text{01} & \text{02} & \text{03} & \text{01} \\
  \text{01} & \text{01} & \text{02} & \text{03} \\
  \text{03} & \text{01} & \text{01} & \text{02}
\end{bmatrix}
\begin{bmatrix}
  b_0 \\
  b_1 \\
  b_2 \\
  b_3
\end{bmatrix}
$$

$$
\begin{aligned}
  d_0 &= (\{\text{02}\} \cdot{} b_0) \oplus (\{\text{03}\} \cdot{} b_1) \oplus
         (\{\text{01}\} \cdot{} b_2) \oplus (\{\text{01}\} \cdot{} b_3) \\
  d_1 &= (\{\text{01}\} \cdot{} b_0) \oplus (\{\text{02}\} \cdot{} b_1) \oplus
         (\{\text{03}\} \cdot{} b_2) \oplus (\{\text{01}\} \cdot{} b_3) \\
  d_2 &= (\{\text{01}\} \cdot{} b_0) \oplus (\{\text{01}\} \cdot{} b_1) \oplus
         (\{\text{02}\} \cdot{} b_2) \oplus (\{\text{03}\} \cdot{} b_3) \\
  d_3 &= (\{\text{03}\} \cdot{} b_0) \oplus (\{\text{01}\} \cdot{} b_1) \oplus
         (\{\text{01}\} \cdot{} b_2) \oplus (\{\text{02}\} \cdot{} b_3) \\
\end{aligned}
$$

この処理を `mix_columns(s)` という関数にして、C言語で実装すると次のようになります。
なお $$\{\text{01}\} \cdot{} b_i = b_i$$ なので、係数が1の要素はそのまま使います。

```c
static void mix_columns(unsigned char s[][4])
{
  int c;
  unsigned char t[4];

  for (c = 0; c < 4; c++) {
    t[0] = dot(2, s[0][c]) ^ dot(3, s[1][c]) ^        s[2][c]  ^        s[3][c];
    t[1] =        s[0][c]  ^ dot(2, s[1][c]) ^ dot(3, s[2][c]) ^        s[3][c];
    t[2] =        s[0][c]  ^        s[1][c]  ^ dot(2, s[2][c]) ^ dot(3, s[3][c]);
    t[3] = dot(3, s[0][c]) ^        s[1][c]  ^        s[2][c]  ^ dot(2, s[3][c]);
    s[0][c] = t[0];
    s[1][c] = t[1];
    s[2][c] = t[2];
    s[3][c] = t[3];
  }
}
```

<br>

### InvMixColumns (逆演算)

MixColumns が暗号化プロセスならば、InvMixColumns は復号プロセスです。
InvMixColumns では次の行列を使って逆変換を行います。

$$
\begin{bmatrix}
  b_0 \\
  b_1 \\
  b_2 \\
  b_3
\end{bmatrix}
=
\begin{bmatrix}
  \text{0e} & \text{0b} & \text{0d} & \text{09} \\
  \text{09} & \text{0e} & \text{0b} & \text{0d} \\
  \text{0d} & \text{09} & \text{0e} & \text{0b} \\
  \text{0b} & \text{0d} & \text{09} & \text{0e}
\end{bmatrix}
\begin{bmatrix}
  d_0 \\
  d_1 \\
  d_2 \\
  d_3
\end{bmatrix}
$$

なぜこの数字になるかというと、$\mathrm{GF}(2^8)$上の法を $x^4 + 1$ とする多項式環について、まず、暗号化の多項式 $a(x)$ が次のように書けます。

$$
a(x) = \{\text{03}\} x^3 + \{\text{01}\} x^2 + \{\text{01}\} x + \{\text{02}\}
$$

そして、その逆元 $a^{-1}(x)$ は次のように書けるからです。

$$
a^{-1}(x) = \{\text{0b}\} x^3 + \{\text{0d}\} x^2 + \{\text{09}\} x + \{\text{0e}\}
$$

実際に、この2つの暗号化多項式と復号多項式を SageMath を使って、$\mathrm{GF}(2^8)$上で法を $x^4 + 1$ とする多項式環上で掛け算したプログラムを以下に示します。

```python
G.<k> = GF(2^8)
F.<X> = PolynomialRing(G)
R.<x> = F.quotient(X^4 + 1)
enc = R(G.fetch_int(0x03)*x^3 + G.fetch_int(0x01)*x^2 + G.fetch_int(0x01)*x + G.fetch_int(0x02))
dec = R(G.fetch_int(0x0b)*x^3 + G.fetch_int(0x0d)*x^2 + G.fetch_int(0x09)*x + G.fetch_int(0x0e))

enc
# => (k + 1)*x^3 + x^2 + x + k
dec
# => (k^3 + k + 1)*x^3 + (k^3 + k^2 + 1)*x^2 + (k^3 + 1)*x + k^3 + k^2 + k
enc * dec
# => 1
```

2つを掛け算すると単位元 $1$ になることから、確かに、暗号化多項式の逆元が復号多項式になっていることが確認できます。
つまり、暗号化多項式を掛けた後に、復号多項式を掛けると、元に戻ることがわかります。

話を戻して、復号における行列の掛け算を表す変換式は次のように書けます。

$$
\begin{bmatrix}
  b_0 \\
  b_1 \\
  b_2 \\
  b_3
\end{bmatrix}
=
\begin{bmatrix}
  \text{0e} & \text{0b} & \text{0d} & \text{09} \\
  \text{09} & \text{0e} & \text{0b} & \text{0d} \\
  \text{0d} & \text{09} & \text{0e} & \text{0b} \\
  \text{0b} & \text{0d} & \text{09} & \text{0e}
\end{bmatrix}
\begin{bmatrix}
  d_0 \\
  d_1 \\
  d_2 \\
  d_3
\end{bmatrix}
$$

$$
\begin{aligned}
  b_0 &= (\{\text{0e}\} \cdot{} d_0) \oplus (\{\text{0b}\} \cdot{} d_1) \oplus
         (\{\text{0d}\} \cdot{} d_2) \oplus (\{\text{09}\} \cdot{} d_3) \\
  b_1 &= (\{\text{09}\} \cdot{} d_0) \oplus (\{\text{0e}\} \cdot{} d_1) \oplus
         (\{\text{0b}\} \cdot{} d_2) \oplus (\{\text{0d}\} \cdot{} d_3) \\
  b_2 &= (\{\text{0d}\} \cdot{} d_0) \oplus (\{\text{09}\} \cdot{} d_1) \oplus
         (\{\text{0e}\} \cdot{} d_2) \oplus (\{\text{0b}\} \cdot{} d_3) \\
  b_3 &= (\{\text{0b}\} \cdot{} d_0) \oplus (\{\text{0d}\} \cdot{} d_1) \oplus
         (\{\text{09}\} \cdot{} d_2) \oplus (\{\text{0e}\} \cdot{} d_3) \\
\end{aligned}
$$

この処理を `inv_mix_columns(s)` という関数にして、C言語で実装すると次のようになります。

```c
static void inv_mix_columns(unsigned char s[][4])
{
  int c;
  unsigned char t[4];

  for (c = 0; c < 4; c++) {
    t[0] = dot(0x0e, s[0][c]) ^ dot(0x0b, s[1][c]) ^ dot(0x0d, s[2][c]) ^ dot(0x09, s[3][c]);
    t[1] = dot(0x09, s[0][c]) ^ dot(0x0e, s[1][c]) ^ dot(0x0b, s[2][c]) ^ dot(0x0d, s[3][c]);
    t[2] = dot(0x0d, s[0][c]) ^ dot(0x09, s[1][c]) ^ dot(0x0e, s[2][c]) ^ dot(0x0b, s[3][c]);
    t[3] = dot(0x0b, s[0][c]) ^ dot(0x0d, s[1][c]) ^ dot(0x09, s[2][c]) ^ dot(0x0e, s[3][c]);
    s[0][c] = t[0];
    s[1][c] = t[1];
    s[2][c] = t[2];
    s[3][c] = t[3];
  }
}
```

これで、MixColumns における復号の処理ができるようになりました。

補足ですが、説明の都合上、暗号化・復号の行列が先で、暗号化・復号の多項式が後になりましたが、NIST FIPS 197での本来の説明では、多項式から行列を導出していますのでご了承ください。


### おわりに

以上が AES (Rijndael) の MixColumns の処理でやっている行列の掛け算の説明になります。
もっと詳しく知りたい人は [Rijndael MixColumns -- Wikipedia](https://en.wikipedia.org/wiki/Rijndael_MixColumns) や [FIPS 197, Advanced Encryption Standard (AES)](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf) あたりを読むと、より理解を深めることができると思います。

最近は中学生がAES暗号化アルゴリズムを実装する時代ですから... [^kkent030315]


🎄
この記事は「[セキュリティキャンプ 修了生進捗 Advent Calendar 2019](https://adventar.org/calendars/4047)」の12日目です
🎄

----

[^SPN]: SPN (Substitution Permutation Network Structure) 構造とは、シャノンが対象鍵ブロック暗号について提案した「多くの階層を使うか、拡散 (Diffusion) と攪拌 (Confusion) の繰り返しを使う混合変換 (Mixing Transformation) で安全で実用的な合成暗号は作成できる」というアイデアに基づいています
[^NIST]: AESは米国連邦標準の暗号規格 [FIPS 197, Advanced Encryption Standard (AES) ](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf) として公開されています
[^Okamoto2019]: 岡本 龍明「現代暗号の誕生と発展：ポスト量子暗号・仮想通貨・新しい暗号」近代科学社 2019
[^AES-round]: AES の鍵長が 128, 192, 256 のとき、ラウンド関数を繰り返す回数は 10, 12, 14 回となります
[^kkent030315]: [C#でAES暗号化アルゴリズムを外部ライブラリに一切頼らず完全実装してみた - Qiita](https://qiita.com/kkent030315/items/ab0792aa1e8948b57490) の著者は自己紹介で(2019/12時点では)「もうすぐ高校1年生です」と書いているので中学生と判断しました
