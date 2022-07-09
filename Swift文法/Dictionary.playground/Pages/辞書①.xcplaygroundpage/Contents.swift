import UIKit

// 順序は保証されない
// キーは一意である必要がある

// ① キーをString型、値をInt型でDictionaryを定義
let fruitsPrice: Dictionary<String, Int> = ["りんご": 150, "みかん": 200, "スイカ": 1000]
print(type(of: fruitsPrice))
print(fruitsPrice)

// ② キーをInt型、値をString型でDictionaryをシンタックスシュガーで定義
let responseMessage: [Int: String] = [200: "OK", 403: "アクセス禁止", 500: "内部サーバエラー"]
print(type(of: responseMessage))
print(responseMessage)

// ③ キーをString型、値をBool型でDictionaryを型推論で定義
let sellFruits = ["apple": true, "orange": false, "meron": true]
print(type(of: sellFruits))
print(sellFruits)




// 空のDictionaryの定義方法
// ① キーをString型、値をInt型で空のDictionaryを定義
let fruits: Dictionary<String, Int> = Dictionary<String, Int>()
print(type(of: fruits))
print(fruits)

// ② キーをInt型、値をString型で空のDictionaryをシンタックスシュガーで定義
let response: [Int: String] = [:]
print(type(of: response))
print(responseMresponseessage)

// ③ キーをString型、値をBool型で空のDictionaryを型推論で定義
let sell = Dictionary<String, Int>()
print(type(of: sell))
print(sell)           
