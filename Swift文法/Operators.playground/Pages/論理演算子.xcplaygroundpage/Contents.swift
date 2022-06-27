//: [Previous](@previous)

import Foundation

var areaAData = true
var areaBData = true

print(areaAData)
print(areaBData)

// 論理積(論理AND演算子)　a&&b
if areaAData && areaBData {
    print("論理積：エリアAとエリアBは共に真（true）")
} else {
    print("エリアAとエリアBは共に真（true）ではない")
}

// 論理和(論理OR演算子)　a||b
if areaAData || areaBData {
    print("論理和：エリアAとエリアBはどちらかが真（true）")
} else {
    print("エリアAとエリアBはどちらも真（true）ではない")
}

// エリアAの値をfalseに変更
areaAData = false
print(areaAData)
print(areaBData)

// 論理積
if areaAData && areaBData {
    print("論理積：エリアAとエリアBは共に真（true）")
} else {
    print("：エリアAとエリアBは共に真（true）ではない")
}

// 論理和
if areaAData || areaBData {
    print("論理和：エリアAとエリアBはどちらかが真（true）")
} else {
    print("エリアAとエリアBはどちらも真（true）ではない")
}


// エリアBの値をfalseに変更
areaBData = false
print(areaAData)
print(areaBData)

// 論理積
if areaAData && areaBData {
    print("論理積：エリアAとエリアBは共に真（true）")
} else {
    print("エリアAとエリアBは共に真（true）ではない")
}

// 論理和
if areaAData || areaBData {
    print("論理和：エリアAとエリアBはどちらかが真（true）")
} else {
    print("エリアAとエリアBはどちらも真（true）ではない")
}
