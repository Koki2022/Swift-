//: [Previous](@previous)

import Foundation

// アンラップをした値を利用して何らかの処理を行いたい場合は、オプショナルバインディングを利用する


// ①if-let文
var message: String?
message = "こんにちは"
if let unwrappedMessage = message {
    print(unwrappedMessage)
} else {
    print("データなし")
}



// ②if-let文で複数のオプショナルを同時にアンラップ
// 複数のアンラップを行う場合は、ひとつでもnilが存在すると、オプショナルバインディングのブロック内のコードは実行されない
var fruit: String? = "りんご"
var origin: String? = "青森"
var price: Int? = 150

if let displayFruit = fruit, let dispkayOrigin = origin, let displayPrice = price {
    print("\(displayFruit)は、\(dispkayOrigin)で作られました。\(displayPrice)円です。") // りんごは、青森で作られました。150円です。
}




// ③guard文
// オプショナル値が nil の場合に、処理を終了する目的で利用、処理を返却するreturn を記述する必要がある
// nil でなければ、アンラップした定数・変数を利用して処理を行う
func squared(number: Int?) {
    guard let number = number else { // 入力パラメータのnumberはnilなので、guard文のブロックが実行されます。
        print("入力値は nil です")
        return                       // returnで関数の処理を戻しています。
    }

    print(number * number) // guard文のreturnで処理が関数実行元に戻されているので、このコードは実行されません。
}

let inputNumber: Int? = nil  // オプショナル型で宣言を行い、初期値にnilをセット
squared(number: inputNumber) // 関数を実行




// ④guard文で複数のオプショナルを同時にアンラップ
func squared(multiplicand: Int?, multiplier: Int?) -> Int? {
    guard let unwrapMultiplicand = multiplicand,    // 入力パラメータのmultiplicandは値があります。
          let unwrapMultiplier = multiplier  else { // 入力パラメータのmultiplierはnilなので、guard文のブロックが実行されます。
        print("入力値は nil です")
        return nil                                  // 戻り値の型と合わせる必要があります。今回は、Int型のオプショナルを戻り値としているので、nilを返却します。
    }
 
    return unwrapMultiplicand * unwrapMultiplier    // guard文のreturnで処理が関数実行元に戻されているので、このコードは実行されません。
}

let inputMultiplicand: Int? = 5    // オプショナル型で宣言を行い、初期値に値をセット
let inputMultiplier: Int? = nil    // オプショナル型で宣言を行い、初期値にnilをセット
let result = squared(multiplicand: inputMultiplicand, multiplier: inputMultiplier) // 関数を実行
print(result)
print(result ?? "データなし")




//if let / if varとguardの使い分け

// if let / if var
// 関数内でなくても、関数外でも利用ができます。
// 変数のnilチェックを行い、nilの有無によって処理を分岐させる場合に利用します。


// guard文
// 関数内でのみ利用ができます。
// guardのみで利用する場合は、関数の入力パラメータのチェックを行い、条件が成立しない場合に処理を終了します。
// gurd letで利用する場合は、関数の入力パラメータが nil の場合に関数の処理を終了します。
// guard文を利用する場合は、関数の入力パラメータがnil の場合に関数の処理を終了するために利用されます。
// guard文を記述する際に気をつけるのは、関数の最初にguard でチェックを行うということです。関数の途中でguard を利用すると、それまでの処理で変数の値が変更されたまま処理が終了し予期しないバグを発生させる可能性があります。
// 仕様変更に伴い処理を追加する場合に、guard の前に追加をすると上記のようなリスクを発生させることに成るので、guard でのチェックは必ず関数の冒頭でまとめて行うようにするのが望ましいです。





// 暗黙的にアンラップ:型に感嘆符「!」を付けることにより「nil」を含む可能性があるオプショナルに対してアンラップが不要になる。
// 強制アンラップと同様,予期せぬエラーが発生する可能性があるため、開発者が問題ないと確証できる場合以外は利用を避ける。
var number: Int! = 100
let twice = number * 2
print(number)
