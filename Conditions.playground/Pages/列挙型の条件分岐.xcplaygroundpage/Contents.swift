//: [Previous](@previous)

import Foundation

// 列挙型で条件を管理し、switch文で評価をすると網羅的にタイプミスの可能性もなく安全な分岐処理を記述することができる。

enum week {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

let day = week.monday
print(type(of: day)) 

switch day {
case .monday:
    print("筋トレをする日")
case .tuesday:
    print("英語を勉強する日")
case .wednesday:
    print("テニスをする日")
case .thursday:
    print("ヨガをする日")
case .friday:
    print("ランニングをする日")
default:
    print("アプリを作る日")
}
