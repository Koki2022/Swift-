import UIKit

// 順序は保証されない
// 値は一意である必要がある

// Set（集合）へのアクセス //
// count:要素数を調べる
// isEmpty:Setが空であるかを調べるメソッド
// contains:Setに特定のアイテムが含まれているか確認
// insert:新しいアイテムをSetに追加
// remove:Setからアイテムを削除
// removeAll:Set内のすべてのアイテムを削除

// sorted: 並び替え
let numbers: Set<Int> = [10, 5, 30, 20]
print(numbers)
print(numbers.sorted())      // 引数なしは、昇順で並び替え
print(numbers.sorted(by: <)) // < の指定で、昇順で並び替え
print(numbers.sorted(by: >)) // > の指定で、降順で並び替え
print(numbers)               // 順不同のまま




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
