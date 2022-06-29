import UIKit

// 要素数を指定して、同じデータを格納する方法
let fiveDoubles = Array(repeating: 1.0, count: 5)
print(type(of: fiveDoubles))
print(fiveDoubles)

// 配列の結合
let fourDoubles = Array(repeating: 1.0, count: 4)
let twoDoubles = Array(repeating: 10.0, count: 2)
let sixDoubles = fourDoubles + twoDoubles
print(twoDoubles)
print(sixDoubles)
