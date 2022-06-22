//: [Previous](@previous)

import Foundation

// switch文
let day = "土曜日"

switch day {
case "日曜日":
    print("燃えるゴミの日")
case "水曜日":
    print("不燃物の日")
case "土曜日":
    print("資源のゴミの日") 
default:
    print("ゴミの日ではありません")
}


// fallthrough（フォールスルー）: 意図的に直下のcaseの処理を実行することができる

for index in 1...6 {
    switch index {
    case 1...3:
        print("\(index)：1〜3の場合に実行")
     case 4 :
        print("\(index):4の場合に実行")
        fallthrough  // 直下の処理も行う指定
     default:
        print("\(index)：4〜6の場合に実行") // ひとつ前の条件で fallthrough が指定されているので4の場合にも実行される
    }
}

// if文とswitch文の使い分け


// ①網羅的に条件分岐を行う必要がある場合
// ifやelse-ifではどの条件にも一致せずにどの処理も行われない可能性がある
// switch文はdefaultを必ず記述する必要があるので、網羅的に条件分岐を行える。



// ②実行速度に影響する可能性がある場合
//switchを使って複数の可能な結果に対して値をチェックする場合は、その値は一度だけ読み込まれます。
// ifで評価を行うと複数回読み込まれる。
// シンプルな条件であれば影響ないが、関数を呼び出して評価をするような場合は実行速度が遅くなる可能性がある。


// ③評価する条件が多い場合
// 3つ以上の可能性のある状態について同じ値をチェックしたい場合、何もなければ異なる条件を書くよりも、同じ値を繰り返しチェックしていることが明確になるため switch の記述のほうが見やすく記述できます。


// 結論：網羅的にかつ3つ以上の条件を評価する場合は、switch文の方が簡潔に実行速度に影響が少ないコードを記述できる。
