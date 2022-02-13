class: middle, center

<img src="./assets/logo.svg" align="center" width="200" />

モダンな JavaScript/TypeScript 実行環境 Deno

---
class: middle, center

「Deno」

聞いたことありますか? 🙋‍♀️ 🙋‍♂️

---
class: middle, center

「Deno」

使ったことありますか? 🙋‍♀️ 🙋‍♂️

---
# 話す人

<img src="./assets/hinosawa.jpg" align="right" width="300" />

日野澤歓也 twitter @kt3k

Web 開発者

- GREE (2012 - 2013)
- Recruit (2015 - 2019)
- Deno Land (2021 -)

<small>2018年から Deno にコントリビュートを開始。2020年作者に誘われ Deno Land に転職。現在はフルタイムで Deno と Deno Deploy を開発中。</small>

---
本日のアジェンダ

- Node.js のおさらい
- Deno とは
- Deno の特徴

おまけ

- 自分が Deno 社に入社した経緯と入社後の話

---
class: middle center

Node.js

---
Node.js

- サーバーサイド JavaScript
- 2009年に発表
- C10K 問題への解としてサーバーサイドで流行
- フロントエンド開発の基盤
- Electron などのデスクトップアプリの基盤 (Slack, VSCode)
- React Native などモバイルアプリ機能も充実

---
class: middle center

Deno とは

---
class: inverse middle center

今から3年半前

---
class: inverse middle center

とあるカンファレンス

---
class: jsconfeu2018

JSConf EU 2018

---
「Node.js について後悔している10の事」

- Node.js の作者 Ryan Dahl が Node.js の現状のデザインについて、今の視点からみて後悔している7つの事を発表
- それを克服する新しい処理系として Deno プロジェクトを提案

<p style="text-align: center">
  <img src="assets/jsconfeu2018-2.jpg" width="400" />
</p>

---
7つの後悔

- 後悔1: Promise を使わなかった
- 後悔2: Security Sandbox を使わなかった
- 後悔3: GYP を使い続けてしまった
- 後悔4: package.json
- 後悔5: node_modules
- 後悔6: モジュール解決時の拡張子省略
- 後悔7: index.js

Node.js の「あたりまえ」を否定

---
対案としての Deno 、そのゴール

1. セキュリティ
2. ES Module
3. TypeScript ビルトイン
4. 単体の実行ファイルで動く
5. モダンな開発環境を使う
6. 可能な限り Web 互換

などの目標が掲げられた

---
class: middle center

Deno とは

---
class: middle center

Deno とは "改良版" Node.js

---
class: middle center

<img src="./assets/node-sort-deno-tweet.png" align="center" width="600" />

---
class: middle center
Deno の特徴

---
Deno の特徴
- Web 互換性
- TypeScript サポート
- V8 サンドボックスセキュリティの活用
- 開発用コマンドのビルトインサポート

---
class: inverse middle center

Web 互換性

---
Web 互換性

- Deno には可能な限り Web 互換 API を取り入れるというデザイン方針がある
- サーバーサイドでも意味がある Web API を出来るだけ取り入れる

---
Web 互換性

Deno に実装されている Web API の例

- http client - fetch API
- バイナリ処理 - TypedArray API (Uint8Array, etc)
- ストリーミング処理 - Web Stream API
- URL parse - URL API
- PubSub - EventTarget API

---
Web 互換性

Deno に実装されている Web API の例

- 暗号 - Web Crypto API
- GPU - WebGPU
- http server - Request, Response API
- データ保存 - Web Storage API

---
Web 互換性 - 最近の進捗 - WPT

- 2021年1月 Web Platform テストを CI に導入
- Web Platform Test = ブラウザが共通で通している Web API のテストスイート
- コミット毎に Web 互換性をチェックするように

<p class="text-align: center">
<a href="https://wpt.fyi/results/?label=master&product=chrome%5Bexperimental%5D&product=edge%5Bexperimental%5D&product=firefox%5Bexperimental%5D&product=safari%5Bexperimental%5D&product=deno&aligned">
<img src="./assets/wpt.png" align="center" width="600" /></a>
</p>

---
Web 互換性 - 最近の進捗 - MDN

- 2021年8月 MDN への掲載が始まる

<p class="text-align: center">
  <img src="./assets/mdn.png" width="600" />
</p>

---
class: inverse middle center

TypeScript サポート

---
TypeScript サポート

- TypeScript をそのまま実行できる。

```ts
// sample.ts
const res = await fetch("https://example.com")
console.log(res.body.text);
```

```
$ deno run sample.ts  
Check file:///Users/kt3k/sample.ts
error: TS2531 [ERROR]: Object is possibly 'null'.
console.log(res.body.text);
            ~~~~~~~~
```

↑ 実行時エラーではなく型エラー

---
TypeScript サポート - 最近の進捗

- 2020年8月 `deno lsp` コマンドの導入
- VSCode とシームレスな連携 & Deno 固有な型情報の補完が出来るように

<p class="text-align: center">
  <img src="./assets/deno-vscode.png" width="600" />
</p>

---
TypeScript サポート `deno lsp`

- ネットワーク越しの TypeScript も型補完が可能

<p class="text-align: center">
  <img src="./assets/deno-lsp-network.png" width="600" />
</p>

---
class: inverse middle center

サンドボックスセキュリティ

---
サンドボックスセキュリティ

前提の話

- Deno は内部的に V8 エンジンを使っている。
- ブラウザ上で JavaScript を安全に実行するため、V8 エンジンの実行環境は厳格にサンドボックス化されている。
- => V8 の外に影響を及ぼせないようになっている

---
サンドボックスセキュリティ

<p class="text-align: center">
  <img src="./assets/deno-diagram.svg" width="750" />
</p>

---
サンドボックスセキュリティ

- V8 Sandbox から出て runtime の機能を使う際に opcallSync / opcallAsync という関数を必ず通るデザインになっている
- その際に使おうとしてる機能に即したパーミッションを持っているかどうかをチェックする

---
サンドボックスセキュリティ

- 7種類のパーミッションがあり、コマンドライン引数で渡す
- `--allow-read` ファイル読み取り
- `--allow-write` ファイル書き込み
- `--allow-net` ネットワーク
- `--allow-env` 環境変数読み取り
- `--allow-run` プロセス実行
- `--allow-ffi` ネイティブ拡張の使用を許可
- `--allow-hrtime` 高精度タイマーの使用を許可

---
サンドボックスセキュリティ

各セキュリティに範囲指定が実装されています

カレントディレクトリのみ読み込み許可
```
deno run --allow-read=. program.ts
```

`dist/` ディレクトリのみ書き込み許可

```
deno run --allow-write=dist/ program.ts
```

---
サンドボックスセキュリティ

特定のドメイン・ポートのみネットワークアクセス許可

```
deno run --allow-net=example.com:80 program.ts
```

※攻撃コードが混入してしまった時に威力を発揮

---
サンドボックスセキュリティ - 最近の進捗

AWS のクレデンシャルの環境変数のみ使用許可

```
deno run \
  --allow-env=AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY \
  program.ts
```

git コマンドだけ使用許可

```
deno run --allow-run=git program.ts
```

---
class: middle center

Deno のユニークなデザインは<br />一定の評価を受けつつある

---
Deno の採用例 - GitHub

次世代 Data Access API

<p style="text-align: center">
  <a href="https://next.github.com/projects/flat-data">
    <img src="./assets/flat-data.png" width="750" />
  </a>
</p>

---
Deno の採用例 - Slack

<p style="text-align: center">
  <a href="https://deno.com/blog/slack">
    <img src="./assets/slack-deno.png" width="600" />
  </a>
</p>

---
class: inverse middle center

疑問: Deno は今すぐ使って良い技術なのか?

---
Q. Deno は今すぐ使って良い技術なのか?

---
Q. Deno は今すぐ使って良い技術なのか?

A. やりたいタスクによる

---
Q. Deno は今すぐ使って良い技術なのか?

A. やりたいタスクによる

- 簡単なスクリプティング -> ✅ OK

---
Q. Deno は今すぐ使って良い技術なのか?

A. やりたいタスクによる

- そこまで複雑ではない Web アプリ -> ✅ OK
  - oak というウェブフレームワークが定番
- 例えば、特定の express middleware (e.g. passport) に依存した Web アプリ -> ❌ NG
  - express 自体は Deno では動かないため

---
Q. Deno は今すぐ使って良い技術なのか?

A. やりたいタスクによる

- そこまで複雑ではない フロントエンド -> ✅ OK
  - aleph (next.js 相当), packup (parcel 相当) などのツールがあります
- 特定の webpack loader に依存したフロントエンド開発 -> ❌ NG
  - webpack 自体は Deno では動かないため

---
Q. Deno は今すぐ使って良い技術なのか?

- 普通の言語に備わっているべきベーシックな機能はほとんど揃っています。
- また、一般的に必要になるライブラリ・フレームワーク類もかなり充実してきています。

---
Q. Deno は今すぐ使って良い技術なのか?

- 普通の言語でできる事が期待される事は Deno でも出来ると思って良いと言える状態になってきている。
- ただし、特定の npm モジュールに強く依存した作業の場合は、そのモジュールが使えない事がネックになる可能性があります。

---
class: middle, center

<img src="./assets/logo.svg" align="center" width="200" />

Deno 自体の話はここまで

---
まとめ

- Deno は "改良版" Node.js を目指すプロジェクト
- Deno は Web 互換性、セキュリティ、TypeScript サポートに力を入れてきて、一定の成果をあげた
- Deno は今使い出しても問題ないが、自分が必要とするライブラリがあるかどうかのチェックが必要

---
class: middle, center

Deno 社に入社するまでと入社してからの話

---

入社するまでのコントリビューション 2018 - 2020

- 純粋に技術的に面白そうという理由で開発に参加
- この時点ではそもそも会社が存在していなかったし、会社になる気配も無かった

=> 純粋に contribute していた時代

---

2020年中盤 Deno Land Inc. 設立

- US の登記情報のようなサイトが検索で引っかかる
- Node.js contributor の一人が Deno Land Inc. に入ると issue 上でコメント
- ただし公式アナウンスは無し

---
メール

- 2020/10 作者ライアン・ダールから「ちょっと個人的に話さない?」という内容のメールがくる。
- この時点ではライアン・ダールと個人的な連絡を取った経験はなし。PR 上でのやり取りのみの関係。

---
面接

- Meet で会ってみると、やはり Deno で働かないかという話だった。
- 面白そうと思ったのでその場でオファーを承諾。その後 CTO とも面接し、2021/1 から稼働開始 (リモート)

---
入社後

- まず、個人にタスクをアサインする事はないと告げられる。
- 各人が Deno にとって良いと思った事をする。
- 自由で良い反面、なぜその作業が Deno にとって良いのかという理由づけを常に説明できる必要がある

=> Great power comes with great responsibility

---
Deno 社で大変な事

- タスクを考える事が大変
- 何が Deno にとって良いのか、という本質を常に考える必要がある
- なおかつ他のメンバーとの対比で自分のバリューを発揮しやすいタスクを見つける事が必要

=> 最近は個人としては、標準ライブラリ、PaaS 開発を中心に作業

---
Deno 社で大変な事

- chat の消化、github 通知の消化
- すごい量の英語を読まないといけない
  - => いまだに未解決問題

---
Deno での1年

- 初めての英語環境での就業
- 仕事としての OSS 開発
- 世界レベルで有名な人との協業
- Web 開発スキルは普通に通用すると実感
- 周辺業務領域への気づき

=> ものすごく挑戦のある環境

---
class: middle center

<img src="./assets/logo.svg" align="center" width="200" />

End
