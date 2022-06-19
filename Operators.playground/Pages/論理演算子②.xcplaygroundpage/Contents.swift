//: [Previous](@previous)

import Foundation

// 明示的な括弧:括弧を明示的に記載し条件の意図を明示することもできる
let areaAData = true
let areaBData = false
let areaCData = false

// 論理積
if (areaAData && areaBData) || areaCData {
    print("エリアAとエリアBが共に真か、またはエリアCが真の状態")
} else {
    print("エリアAとエリアBが共に真か、またはエリアCが真以外の状態")
}
