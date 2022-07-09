import UIKit

/* 関数の定義
 // func 関数名(入力パラメータ: 型,入力パラメータ: 型) -> 戻り値の型　{
 // 実行する処理
 return 戻り値
 }
 //関数の呼び出し()
 関数名(入力パラメータ: 値,入力パラメータ: 値)     */


// 引数なし、戻り値なし
func bothNoneFunction() {
    print("引数なし、戻り値なし")
}
bothNoneFunction()
print(type(of: bothNoneFunction))

// 引数あり、戻り値なし
func onArgumentFunction(inputData: String) {
    print("引数\(inputData)、戻り値なし")
}
onArgumentFunction(inputData: "あり")
print(type(of: onArgumentFunction))

// 引数なし、戻り値あり
// 処理が一行のみの場合
func onRetunFunction() -> String {
    "引数なし、戻り値あり" // 関数の処理が1行の場合「return」は省略できる
}

var message = onRetunFunction()
print(message)
print(type(of: onRetunFunction))

// 処理が複数行の場合
func onRetunNameFunction() -> String {
    let lastName = "やまだ"
    let firstName = "たろう"
    return lastName + firstName
}

message = onRetunNameFunction()
print(message)
print(type(of: onRetunNameFunction))

// 引数あり、戻り値あり
func onBothFunction(inputData: String) -> String {
    "引数\(inputData)、戻り値あり"
}

let message2 = onBothFunction(inputData: "あり")
print(message2)
print(type(of: onBothFunction))

// 複数の引数を指定
func createLottery(id: Int, name: String) -> String {
    let lotteryNumber = Int.random(in: 1...3)
    let lottery: String
    if lotteryNumber == 1 {
        lottery = "大吉"
    } else if lotteryNumber == 2 {
        lottery = "中吉"
    } else {
        lottery = "笑吉"
    }
    return "会員番号\(id)：\(name)さんは、\(lottery)です！"
}
let message3 = createLottery(id: 1, name: "たろう")
print(message3)
print(type(of: createLottery))

// 引数と戻り値に配列を指定
func testResults(name: String, scores: [Int]) -> [String] {
    var messages: [String] = []
    for score in scores {
        if score > 80 {
            messages.append("\(name)さん、すごいね！")
        } else if score > 60 {
            messages.append("\(name)さん、がんばったね！")
        } else {
            messages.append("\(name)さん、のびしろ！")
        }
    }
    return messages
}
let forMessage: [String] = testResults(name: "はなこ", scores: [70, 55, 95])
print(forMessage)
print(type(of: testResults))

// 引数にデフォルトの値を指定
func greet(name: String = "名無し", isLogin: Bool) {
    print("\(name)さん、こんにちは！")
    if isLogin {
        print("今日もプログラミングをしよう！")
    } else {
        print("ログインをしてプログラミングを始めよう！")
    }
}
greet(name: "たろう", isLogin: true)
greet(isLogin: true)

// 可変個引数関数
func sum(numbers: Int...) -> Int { // データ型の指定の後に「...」を付与することで可変の引数を受け取れる
    print(type(of: numbers)) // 可変個引数は配列で受け取る
    var total: Int = 0
    for number in numbers {
        total += number
    }
    return total
}
var result = sum(numbers: 10, 3, 5)
print(result)
result = sum(numbers: 5, -20, 10, 3, 15, 1)
print(result)
