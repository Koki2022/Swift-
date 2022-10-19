//: [Previous](@previous)

import Foundation

struct User {
    let name: String
    let age: Int
}

var users: [User] = []
users.append(User(name: "さくら", age: 20))
users.append(User(name: "太郎", age: 25))
users.append(User(name: "ジョン", age: 10))

for user in users {
    print("並び替え前:\(user)")
}

users.sort {
    $0.age < $1.age
}

for user in users {
    print("並べ替え後:\(user)")
}
