import UIKit

// 順序は保証されない
// 値は一意である必要がある

// 値を重複して保持させない
// ①Set型のStringを宣言する方法
var fruits: Set<String> = ["りんご", "みかん", "メロン", "りんご"]
print(type(of: fruits))
print(fruits)
// 順序は保証されない
for fruit in fruits {
    print(fruit)
}


// ②型推論でSet型のStringを宣言する方法
let kudamono: Set = ["りんご", "みかん", "メロン", "りんご"]
print(type(of: kudamono))
print(kudamono)

// 空のSetを定義する方法
// ① 空のString型集合
let fruits2: Set<String> = Set<String>()
print(type(of: fruits2))
print(fruits2)

// ② 型推論での空のInt型集合
let numbers = Set<Int>()
print(type(of: numbers))
print(numbers)

// Set（集合）へのアクセス //
// count:要素数を調べる
let fruits3: Set<String> = ["りんご", "みかん", "メロン", "りんご"]
print(fruits3)

// isEmpty:Setが空であるかを調べるメソッド
let fruits4: Set<String> = ["りんご", "みかん", "メロン", "りんご"]
print(fruits4.isEmpty) // 値あり。false

if fruits.isEmpty {
    print("まだ空だよ")
} else {
    print("フルーツの集合はあるよ")
}


// contains:Setに特定のアイテムが含まれているか確認
let fruits5: Set<String> = ["りんご", "みかん", "メロン", "りんご"]
print(fruits5.contains("りんご")) // 要素あり。true
print(fruits5.contains("スイカ")) // 要素なしfalse

if fruits5.contains("りんご") {
    print("りんごはあるよ")
} else {
    print("りんごはないよ")
}

if fruits5.contains("スイカ") {
    print("スイカはあるよ")
} else {
    print("スイカはないよ")
}

// insert:新しいアイテムをSetに追加
var fruits6: Set<String> = ["りんご" ,"みかん" ,"メロン"]
print(fruits6)

// insertの結果である、成功の可否と追加したアイテムがタプル型で返却されます。
let aditionalFruit = fruits.insert("スイカ")
print(aditionalFruit)  // (inserted: true, memberAfterInsert: "スイカ")
print(aditionalFruit.inserted)          // true
print(aditionalFruit.memberAfterInsert) // スイカ
print(fruits)          // ["みかん", "メロン", "りんご", "スイカ"]

// remove:Setからアイテムを削除
var fruits7: Set<String> = ["りんご" ,"みかん" ,"メロン"]
print(type(of: fruits7))
print(fruits7)
let removeFruit = fruits7.remove("みかん")
print(fruits7)
print(removeFruit)

var numbers2: Set<Int> = [100,200,300]
print(type(of: numbers2))
print(numbers2)
let removeNumber = numbers2.remove(500)
print(numbers2)
print(removeNumber)

// removeAll:Set内のすべてのアイテムを削除
var fruits8: Set<String> = ["りんご" ,"みかん" ,"メロン"]
print(type(of: fruits8))
print(fruits8)
fruits8.removeAll()
print(fruits8)


// sorted: 並び替え
let numbers3: Set<Int> = [10, 5, 30, 20]
print(numbers3)
print(numbers3.sorted())      // 引数なしは、昇順で並び替え
print(numbers3.sorted(by: <)) // < の指定で、昇順で並び替え
print(numbers3.sorted(by: >)) // > の指定で、降順で並び替え
print(numbers3)               // 順不同のまま




// Hashableプロトコル
// Setはアイテムを一意に識別するために使用するハッシュ値を持っている
// Hashableに準拠することでSetはすべての要素が集合の中で一度しか現れないことを保証
struct Person: Hashable { // Hashableプロトコルに準拠
    let name: String
}

var people: Set<Person> = []
people.insert(Person(name: "さくら"))
people.insert(Person(name: "たろう"))
people.insert(Person(name: "ジョン"))
print(people)
for person in people {
    print(person)
}

// ArrayではなくSetを利用するケース //
// 大量のデータを一意（ユニーク）に保持する場合。
// データの順序を気にする必要がない場合。
// Arrayを必要とするAPIを使用する必要がない場合。

// 集合の操作（集合演算）
let aTypeDigits: Set = [1, 2, 3]
let bTypeDigits: Set = [1, 3, 5, 7]

// 和集合
let unionDigits =  aTypeDigits.union(bTypeDigits) // [1, 2, 3, 5, 7] ※要素の並びは順不同で表示される
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

// Set型同士の比較
let a2TypeDigits: Set = [3, 2, 1]
let b2TypeDigits: Set = [1, 3, 5, 7]
let c2TypeDigits: Set = [1, 2, 3]    // aTypeDigitsとは違った順番で初期化

print(a2TypeDigits == c2TypeDigits) // 初期化の順番に関係なく、アイテムが一致するので true
print(a2TypeDigits == b2TypeDigits) // アイテムは一致しないので false

// isSubset:引数のSetに対して、指定されたSetのアイテム全てが含まれているかどうかを評価します。
let houseAnimals: Set = ["犬", "猫"]
let farmAnimals: Set = ["牛", "鶏", "羊", "犬", "猫"]
let cityAnimals: Set = ["鳥", "鼠"]

// 引数のSetに対して、指定されたSetのアイテム全てが含まれているかどうかを評価
print(houseAnimals.isSubset(of: farmAnimals))    // true：houseAnimalsの全てのアイテムが、farmAnimalsに含まれている
print(farmAnimals.isSubset(of: houseAnimals))    // false：farmAnimalsの全てのアイテムが、houseAnimalsに含まれていない

// isSuperset:指定されたSetに対して、引数のSetのアイテムが含まれているかどうかを評価します。
// 指定されたSetに対して、引数のSetのアイテムが術t含まれているかどうかを評価
print(farmAnimals.isSuperset(of: houseAnimals))  // true：farmAnimalsには、houseAnimalsの全てのアイテムが含まれている
print(houseAnimals.isSuperset(of: farmAnimals))  // false：houseAnimalsには、farmAnimalsの全てのアイテムが含まれていない

// isDisjoint:2つのSetに共通の値がないかどうかを評価します。
// 2つのSetに共通の値がないかどうかを評価
print(farmAnimals.isDisjoint(with: cityAnimals))  // true：共通するアイテムがない
print(houseAnimals.isDisjoint(with: farmAnimals)) // false：共通するアイテムがある
