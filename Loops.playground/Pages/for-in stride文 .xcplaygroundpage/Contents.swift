//: [Previous](@previous)

import Foundation
import CoreGraphics
import Darwin

// stride文を付与することで、一定の間隔で処理を繰り返すことができる
// for 定数名 in stride(from: 開始値, to: 終了値, by: 間隔)
let start: Int = 0
let end: Int = 20
let interval: Int = 5

for strideNumber in stride(from: start, to: end, by: interval) {
    print(strideNumber)
}
