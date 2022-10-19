//: [Previous](@previous)

import Foundation

struct User {
    let name: String
    var point: Int
    
    init() {
        name = "名無し"
        point = 1000
    }
    
    init(inputName: String) {
        name = inputName
        point = 2000
    }
}
let defaultUser = User()
print(defaultUser)

let sakura = User(inputName: "さくら")
print(sakura)

// クラスや構造体は、そのインスタンスが生成されるまでに、すべてのストアドプロパティを適切な初期値に設定する必要があります。
// 計算型プロパティは、インスタンス生成時に計算した何らかの値で初期化するので引数に指定する必要はありません。
// イニシャライザの方法には、さきほど紹介した「initキーワード」での方法と、次の「全項目イニシャライザ」を使う方法があります。
