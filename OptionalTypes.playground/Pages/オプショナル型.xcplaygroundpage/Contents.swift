import UIKit

var name: String? = nil
print(name)

// Expression implicitly coerced from 'String?' to 'Any'
//（式が暗黙のうちに 'String?' から 'Any' に強制される）

// アンラップした値を直接表示をしたい場合の解決方法
// 解決方法① Provide a default value to avoid this warning
// Nil結合演算子を利用してデフォルト値を設定する方法

// var name: String? = nil
// print(name ?? "データなし")




// 解決方法② Provide a default value to avoid this warning
// 強制アンラップを行う方法：「nil」を取得した場合エラーとなりアプリが落ちてしまうので、必ず値が入っていると断言できる場合のみ利用

// name = "たろう"
// print(name!)





// 解決方法③ Explicitly cast to 'Any' with 'as Any' to silence this warning
// Any型（Optional型を含むあらゆる型）にキャスト（変換）を行う方法
// Any型にキャストする場合は最終的にはInt型やString型に変換して戻す必要があるので、特別な理由がない限りはあまり選択されることはない


// var name: String? = nil
// print(name as Any)           // nilの場合はAny型に変換されて、nilと表示されます。
// print(type(of: name as Any)) // Optional<String>
