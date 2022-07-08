//: [Previous](@previous)

import Foundation

let aTypeDigits: Set = [1, 2, 3]
let bTypeDigits: Set = [1, 3, 5, 7]

// 和集合
let unionDigits =  aTypeDigits.union(bTypeDigits)
print(unionDigits)

// 積集合
let intersectionDigits = aTypeDigits.intersection(bTypeDigits).sorted()
print(intersectionDigits)

// 対称差集合
let symmetricDifferenceDigits = aTypeDigits.symmetricDifference(bTypeDigits).sorted()
print(symmetricDifferenceDigits)

// 差集合
let subtractingDigits = aTypeDigits.subtracting(bTypeDigits).sorted()
print(subtractingDigits)



// Set型同士の比較 //
// 比較演算子
// isSubset:引数のSetに対し指定されたSetのアイテム全てが含まれているかを評価
// isSuperset:指定されたSetに対して引数のSetのアイテムが含まれているかどうかを評価
// isDisjoint:2つのSetに共通の値がないかどうかを評価
