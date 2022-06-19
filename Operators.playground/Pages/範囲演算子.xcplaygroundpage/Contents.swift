//: [Previous](@previous)

import Foundation

// 閉範囲演算子
// randomメソッドを利用して範囲演算子を指定
print(Int.random(in: 1...5)) // 1〜5までの数値で乱数を発生

// for文（繰り返し）を利用して範囲演算子を指定
for index in 1...5 {
    print("\(index)回目の繰り返し")
}





// 半開放範囲演算子
// randomメソッドを利用して範囲演算子を指定
print(Int.random(in: 1..<5)) // 1〜4までの数値で乱数を発生

// for文（繰り返し）を利用して反映演算子を指定
for index in 1..<5 {
    print("\(index)回目の繰り返し") // n回目の繰り返し と4回表示されます
}

