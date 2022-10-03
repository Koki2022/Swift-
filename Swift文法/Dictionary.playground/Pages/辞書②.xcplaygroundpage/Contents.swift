//: [Previous](@previous)

import Foundation

// Dictionaryの特徴
// 順序は保証されない
// キーは一意（ユニーク）である必要がある

// Dictionaryを初期化する例
// ① キーをString型、値をInt型でDictionaryを定義
var fruitsPrice: Dictionary<String, Int> = ["りんご": 150, "みかん": 200, "スイカ": 1000]

// Dictionaryの値の更新・追加
// Dictionaryに値が存在する場合は更新となり、存在しない場合は追加
fruitsPrice["りんご"] = 300
print(fruitsPrice)

// Dictionaryの値の追加
fruitsPrice["メロン"] = 2000
print(fruitsPrice)

// Dictionaryの値の削除
// removeValueメソッドにキーを指定して削除
fruitsPrice.removeValue(forKey: "みかん")
print(fruitsPrice)

// キーをインデックスにして、nilを代入して削除
// 値をnilでセットする方法は、キーに対して値をnilに更新するわけではなくて、Dictionaryからキーと値そのものが削除されます。
fruitsPrice["スイカ"] = nil
print(fruitsPrice)

// Dictionaryの全ての値を削除
fruitsPrice.removeAll() // 全ての値を削除
print(fruitsPrice)



// ② キーをInt型、値をString型でDictionaryをシンタックスシュガーで定義
let responseMessage: [Int: String] = [200: "OK", 403: "アクセス禁止", 500: "内部サーバエラー"]
print(type(of: responseMessage))
print(responseMessage)

// ③ キーをString型、値をBool型でDictionaryを型推論で定義
let sellFruits = ["apple": true, "orange": false, "meron": true]
print(type(of: sellFruits))
print(sellFruits)

// 空のDictionaryを定義
// ① キーをString型、値をInt型で空のDictionaryを定義
let fruitsPrice2: Dictionary<String, Int> = Dictionary<String, Int>()
print(type(of: fruitsPrice2))
print(fruitsPrice2)

// ② キーをInt型、値をString型で空のDictionaryをシンタックスシュガーで定義
let responseMessage2: [Int: String] = [:]
print(responseMessage2)
print(responseMessage2)

// ③ キーをString型、値をBool型で空のDictionaryを型推論で定義
let sellFruits2 = Dictionary<String, Int>()
print(type(of: sellFruits2))
print(sellFruits2)


// Dictionaryの値へのアクセス方法
let fruitsPrice3: [String: Int] = ["りんご": 150, "みかん": 200, "スイカ": 1000]
print(fruitsPrice3["スイカ"])

let responseMessage3: [Int: String] = [200: "OK", 403: "アクセス禁止", 500: "内部サーバエラー"]
print(responseMessage3[200])

// Dictionaryの内容を繰り返し処理する
// すべてのDictionaryは、キーと値のペアの順序付けられていないコレクションです。for-ループを使用してディクショナリを反復処理し、in各キーと値のペアをタプルの要素に分解できます。
let responseMessage4: [Int: String] = [200: "アクセス可能", 403: "アクセス禁止", 500: "内部サーバエラー"]
for (responce, message) in responseMessage4 {
    print("レスポンスコード\(responce)は、\(message)です")
}


// Dictionaryの内容から特定の値を検索する一例
// contains(where:)：与えられたパラメータを満たす要素を含んでいるかどうかを評価するBool値を返却します。
// firstIndex(where:)：与えられたパラメータに一致する、コレクションの要素の最初のインデックスを返却します。
// hasPrefix(_:)：文字列が指定された接頭辞で始まるかどうかを評価するBool値を返却します。

/* インラインクロージャについて
{ $0.value.hasPrefix("/glyphs") }は、クロージャです。

単一の式で表されるクロージャでは、暗黙的にその値が返るので return も省略できます。したがって、このように記述ができます。インラインクロージャとも呼ばれます。

Swift はインラインクロージャのために自動的に省略した引数名を提供しています。$0という記述がその省略された引数です。

この引数はひとつだけでなく、クロージャの中の引数を、$0, $1, $2 のように指定して使用することができます。*/

let imagePaths = ["star": "/glyphs/star.png",
                  "portrait": "/images/content/portrait.jpg",
                  "spacer": "/images/shared/spacer.gif"]

let glyphIndex = imagePaths.firstIndex(where: { $0.value.hasPrefix("/glyphs")})

if let index = glyphIndex {
    print("glyphIndexディレクトリの中には、\(imagePaths[index].key)というファイル名の\(imagePaths[index].value)が保存されています。")
} else {
    print("画像はありません")
}

// ■Dictionaryを入れ子にして保持する方法
let fruits: [String: String] = ["apple": "りんご", "grape": "ぶどう", "strawberry": "いちご"]
let vegetables: [String: String] = ["carrot": "にんじん", "onion": "たまねぎ", "pumpkin": "かぼちゃ"]
let foods: [String: [String: String]] = ["fruits": fruits, "vegetables": vegetables]
print(type(of: foods))
print(foods)
print(foods["fruits"])
print(foods["vegetables"])

// 直接入れ子構造を辞書に登録する例
let foods2: [String: [String: String]] = ["fruits": ["apple": "りんご", "grape": "ぶどう", "strawberry": "いちご"], "vegetables": ["carrot": "にんじん", "onion": "たまねぎ", "pumpkin": "かぼちゃ"]]
print(foods2)
print(foods2["fruits"])
print(foods2["vegetables"])

// Arrayの中にDictionaryを保持する方法
// データ構造が同じ複数の情報を管理する
let songs: [[String: String]] = [["title": "bad guy", "singer": "Billie Eilish", "year": "2019"],
                                 ["title": "Run the World", "singer": "Beyoncé", "year": "2011"],
                                 ["title": "What Do You Mean?", "singer": "Justin Bieber", "year": "2015"]]
print(type(of: songs))
// Arrayは順序が確保されているが、Dictionaryは順不同で取得される
print(songs[0])
print(songs[1])
print(songs[2])
// 曲名を取得
print(songs[0]["title"])
print(songs[1]["title"])
print(songs[2]["title"])

// 歌手を取得
print(songs[0]["singer"])
print(songs[1]["singer"])
print(songs[2]["singer"])

// リリース年を取得
print(songs[0]["year"])
print(songs[1]["year"])
print(songs[2]["year"])
