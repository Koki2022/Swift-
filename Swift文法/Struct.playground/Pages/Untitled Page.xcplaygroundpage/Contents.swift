import UIKit

struct User {
    let name: String
    let rank: String
    let point: Int
    
    var bonus: Int {
        if rank == "Gold" {
            return point * 3
        } else {
            return point * 2
        }
    }
    func showScore() {
        print("\(name)さんのポイントは\(point)点!")
    }
    func showBonus() {
        print("\(name)さんのポイントは\(bonus)点!")
    }
}
let sakura = User(name: "さくら", rank: "Standard", point: 300)
sakura.showScore()
sakura.showBonus()
print(type(of: sakura))

let jone = User(name: "ジョン", rank: "Gold", point: 150)
jone.showScore()
jone.showBonus()
print(type(of: jone))


