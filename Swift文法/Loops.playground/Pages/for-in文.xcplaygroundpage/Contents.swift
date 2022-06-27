import UIKit


// 数値範囲をループ処理
for index in 1...5 {
    print("\(index) かける 5 は \(index * 5)")
}


// 配列をループ処理
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
for os in platforms {
    print("Swiftは \(os) で動くよ！")
}


// 配列の定数名の省略
// 配列の定数名の値を使用しないときは「_」を使用することができる
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) の \(power) 乗は \(answer)です。")


// Dictionaryをループ処理
// Dictionaryでは順序を確保していないため取り出される値は順不同
/*Dictionaryのキーのみを取り出すのは、シーケンスに「.keys」を付与,値のみを取り出すのは、シーケンスに「.values」を付与して取得*/
let wordList: [String: String] = ["apple": "りんご", "grape": "ぶどう", "strawberry": "いちご"]
for (english, japanese) in wordList {
    print("\(japanese) は、英語で \(english) だよ！")
}
// キーのみを定数に格納して処理を行う
for english in wordList.keys {
    print("\(english) は、キーだよ！")
}
// 値のみを定数に格納して処理を行う例
for japanese in wordList.values { // .valuesで、値のみを取り出して定数に格納し利用ができます。
    print("\(japanese) は、値だよ！")
}



// Dictionaryを順序を確保して取り出す
let fruits: KeyValuePairs = ["apple": "りんご", "grape": "ぶどう", "strawberry": "いちご"]
// キーと値をタプル型に格納して処理を行う
// 取り出される値は順序が確保される
for (english, japanese) in fruits { // キーと値のコレクションをタプルに格納して利用できます。
    print("\(japanese) は、英語で \(english) だよ！")
}


