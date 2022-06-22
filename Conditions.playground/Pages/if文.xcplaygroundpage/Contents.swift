import UIKit

// if文：条件がtrueの場合は{}ブロック内のコードが実行され、falseの場合は{}ブロック内のコードは実行されない
// else文：if文が成立しなかった場合になんらかの処理を行いたい場合else節で処理

// if-else文:上から条件が一致するか確認
var score: Int = 80
if score > 50 {
    print("スコアは、50より大きいよ！")
} else if score <= 50  {
    print("スコアは、50以下だよ！")
} else if score <= 30  {
    print("スコアは、30以下だよ！")
} else {
    print("どの条件にも一致しなかった場合に実行されます")
}
