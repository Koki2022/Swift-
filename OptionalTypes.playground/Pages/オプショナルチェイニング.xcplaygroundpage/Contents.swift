//: [Previous](@previous)

import Foundation

// アンラップ時にコードをより複雑にしないためのテクニック
// ①nil合体演算子
// ②オプショナルチェイニング

let area: [String] = ["Shibuya", "Shinjuku", "Ueno", "Asakusa"]
let upperArea = area.first?.uppercased() //  アンラップを行うことなく「?」でチェーン（連鎖）をしてuppercasedメソッドを実行ができる。
print(upperArea ?? "データなし") // SHIBUYA




// 配列が空の場合
let ice: [String] = []
print(ice)                              // 空の配列を示す [] が出力されます。
print(ice.first)                        // 取得する要素が無いのでオプショナル型のfirstメソッドはnilを返却します。
let upperIce = ice.first?.uppercased() // オプショナルチェイニングが失敗すると、nilを返却します。
print(upperIce ?? "データなし")         // ??によって「データなし」と出力されます。




// 階層構造のオプショナル型
let firstName: String?? = "さくら" // 2重のオプショナル型を宣言
print(firstName)                  // Optional(Optional("さくら"))
print(type(of: firstName))        // Optional<Optional<String>>
if let unwrapFirstName = firstName {             // 1回めのアンラップ
    if let unwrapInFirstName = unwrapFirstName { // 2回めのアンラップ
        print(unwrapInFirstName)     // さくら
    }
}




// 階層構造のオプショナルをオプショナルチェイニング
let nameList: [String?] = ["Sakura", "Taro", "John"] // 2重のオプショナル型を宣言
print(type(of: nameList))        // Array<Optional<String>>
print(type(of: nameList.first))  // Optional<Optional<String>>
print(nameList.first??.uppercased()) // Optional("SAKURA") 2重のオプショナルに対して、2重のオプショナルバインディング「??」でアクセスをしています。






// オプショナルチェイニングとnil合体演算子
// オプショナルチェイニングでは、オプショナル変数や定数のプロパティにアクセスする際に、オプショナルにnilという値が含まれているかどうかを最初にチェックする必要がなく、nil合体演算子を利用すると更に簡潔にコードを記述することができる。
var town: [String] = []                                 // 空の配列を宣言
var upperTown = town.first?.uppercased() ?? "データなし" // オプショナルチェイニングとnil合体演算子「??」を併用しています。firstでnilが検出されて、nil合体演算子で文字が返却されます。
print(upperTown)                                       // データなし

town.append("Asakusa")                                 // 配列の追加
town.append("Omotesando")                              // 配列の追加
upperTown = town.first?.uppercased() ?? "データなし"   // 配列の1番めが取得できるので、uppercasedまで実行が行われます。
print(upperTown)





// 自作関数でオプショナルチェイニング&nil合体演算子を行う例
func fruitTranslation(name: String) -> String? { // 戻り値を、オプショナル型のStringを指定しています。
    switch name {
    case "りんご": return "Apple"
    case "ぶどう": return "grape"
    case "メロン": return "melon"
    default: return nil
    }
}

var fruitPrice = fruitTranslation(name: "りんご")?.uppercased() ?? "果物が見つかりません。"
print("\(fruitPrice)") // Apple

fruitPrice = fruitTranslation(name: "林檎")?.uppercased() ?? "果物が見つかりません。"
print("\(fruitPrice)") // 果物が見つかりません。
