import UIKit

列挙型（Enumeration Types）


列挙型は、複数の識別子を定数（immutable：イミュータブル）としてまとめることができる値型のひとつです。

識別子は、様々な対象から特定の一つを識別、特定するのに用いられる名前や符号、数字等のことです。

共有のカテゴリに属する値を網羅的にグルーピングして、ひとつの型として定義することができます。ですので、データの種類が決められていて網羅的に管理したいようなデータの管理に適しています。

実際に必要な状況を見ていきましょう。定数や変数に保持されている値によって処理を変えたいことはよくあります。

下記の例は、果物の種類を受けて金額を返却する関数です。

💻 必ずPlaygroundで実際にコードを入力しながら確認してください。
Playgroundの利用方法はこちらをご参照ください。

OBJECTIVEC
func purchased(fruit: String) -> String {
    if fruit == "Apple" {
        return "りんごは、150円です。"
    } else if fruit == "Orange" {
        return "オレンジは、300円です。"
    } else if fruit == "Meron" {
        return "メロンは、1000円です。"
    }
    return "お求めの果物はありません。"
}

print(purchased(fruit: "Apple")) // ⭕️ りんごは、150円です。
print(purchased(fruit: "apple")) // ❌ お求めの果物はありません。
SwiftのString型は、大文字小文字を識別します。なので、"Apple"や"apple"のように綴（つづり）はあっていても大文字小文字が違うと一致せず、別のデータとして扱われます。

この状態は予期せぬバグが発生する可能性が高くなります。

開発するアプリの規模によっては、膨大なコード量に成るため、このようなリスクを極力排除する仕組みが欲しいところです。

その際に、Swiftでは列挙型（enum）が有効な解決策になります。

■定義方法
型名にenum キーワード、列挙値にcaseキーワードを指定しブロックの中に列挙します。

enum 型名 {
  case 列挙値
  case 列挙値
  case 列挙値
}
この列挙型にアクセスするときは、下記のような書き方でアクセスできます。

型名.列挙値
先程の果物を列挙型で定義をしてアクセスをしてみます。

最後に、typeメソッド（型名が確認できるメソッド）を活用して、enumキーワードで指定した型名であることを確認しています。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
}

// caes値へのアクセス
print(ShopItem.apple)  // apple
print(ShopItem.orange) // orange
print(ShopItem.melon)  // melon
// 型を確認
print(type(of: ShopItem.apple)) // ShopItem
列挙型は、定数・変数に代入してインスタンス化することもできます。

let インスタンス名 = 型名.列挙値
OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
}

// インスタンス生成
var fruit = ShopItem.apple
// インスタンスの値を確認
print(fruit) // apple
// 型を確認
print(type(of: fruit)) // ShopItem
型名を指定してインスタンスを生成する場合は、Swiftの型推論が作用するので、下記のように .列挙値として代入することも出来ます。

let インスタンス名: 型名 = .列挙値
OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
}

// インスタンス生成
var fruit: ShopItem = .apple
// インスタンスの値を確認
print(fruit) // apple
// 型を確認
print(type(of: fruit)) // ShopItem

// インスタンスの上書き
fruit = .melon
// インスタンスの値を確認
print(fruit) // melon
// 型を確認
print(type(of: fruit)) // ShopItem
列挙型の宣言と利用方法が確認できたら、冒頭のバグの発生リスクの高い purchesed 関数にどのように適用するか確認をしましょう。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
}

func purchased(fruit: ShopItem) -> String {
    if fruit == .apple {
        return "りんごは、150円です。"
    } else if fruit == .orange {
        return "オレンジは、300円です。"
    } else if fruit == .melon {
        return "メロンは、1000円です。"
    }
    return "お求めの果物はありません。"
}

// インスタンス生成
let selected: ShopItem = .apple
// 定数に格納したインスタンスを引数に指定できます。
print(purchased(fruit: selected))       // りんごは、150円です。
// インスタンスを直接引数に指定することも可能です。
print(purchased(fruit: ShopItem.melon)) // メロンは、1000円です。
関数の引数を、String型から作成したShopItem型に変更して、if文の比較条件式も "Apple" のようなString型から、 .appleに置き換えてます。

Swiftでは、if文で比較をしたり、何らかの計算を行う場合は型を合わせる必要がありました。型の不一致の状態では、エラーが発生します。

そのため今回は、比較演算子の左辺の fruit は、ShopItem型なので、右辺の比較対象もShopItem型でなければエラーが発生してしまいます。

if文でString型の値を比較していた時は、大文字小文字の不一致で予期せぬエラーが発生する可能性のあったリスクが、列挙型で比較することによって解消されています。

このように型安全であるSwiftの特性と、まとめたい値を列挙して型として扱える列挙型を組み合わせて、安全にデータの比較を行うことができます。



■switchによる列挙値のマッチング
上記の例では、if文と列挙型を組み合わせて条件分岐を行いましたが、列挙型はswitch文と組み合わせるほうが有効に使えます。

if文をswitch文に置き換えてみましょう。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
}

func purchased(fruit: ShopItem) -> String {
    switch fruit {
    case .apple:
        return "りんごは、150円です。"
    case .orange:
        return "オレンジは、300円です。"
    case .melon:
        return "メロンは、1000円です。"
    }
}

let selected: ShopItem = .apple
// 定数に格納したインスタンスを引数に指定
print(purchased(fruit: selected))       // りんごは、150円です。
// インスタンスを直接引数に指定
print(purchased(fruit: ShopItem.melon)) // メロンは、1000円です。
どうでしょう？列挙型で比較するときは、if文よりもswitch文のほうが、条件が見やすく使いやすいことを確認できたと思います。



■イニシャライザ
初期化（イニシャライズ）とは、データオブジェクトや変数に初期値を割り当てることです。

他の型である、構造体・クラス同様に、initキーワードを利用してイニシャライザを定義することができます。

構造体のイニシャライザでも解説をしていますので、確認しておきましょう。

下記の例では、イニシャライザで文字列を受け取り一致する列挙値で初期化を行っています。

列挙値、String型の文字列値の両方からShopItem型のインスタンスを生成できるようにしています。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
    case other
    
    // 文字列から初期化を行うイニシャライザを定義
    init(fruit: String) {
        switch fruit {
        case "Apple":
            self = .apple
        case "Orange":
            self = .orange
        case "Meron":
            self = .melon
        default:
            self = .other
        }
    }
}

// ShopItemのcase値からインスタンス生成
let apple: ShopItem = .apple
print(type(of: apple)) // ShopItem
print(apple)           // apple

// String型からインスタンス生成
let orange: ShopItem = ShopItem(fruit: "Orange")
print(type(of: orange)) // ShopItem
print(orange)           // orange

// インスタンス生成
let meron = ShopItem(fruit: "meron")  // Meronをmeronとスペルミスした場合
print(meron)          // 文字列が一致しないので、defaultで返却している other が確認できます。
■プロパティ
列挙型では、単純に値を格納する格納型プロパティ（stored property）は定義することはできません。

計算型プロパティと、タイププロパティが利用できます。



計算型プロパティ
値の参照と更新の機能を手続きで構成（計算）できるプロパティのことです。

関数のように計算する機能を持たすことができることから計算型（computed）と呼ばれます。

下記の例では、列挙値（case）に応じて果物の価格を計算型プロパティの priceに格納しています。

✅ここがポイント：計算型プロパティのポイントとしては、自分自身を指し示す「self」をswitch文で判定して、どの列挙値に一致するのかを返却します。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
    
    var price: Int {
        switch self { // ✅ selfを評価して、一致するケースを返却している
        case .apple:
            return 150
        case .orange:
            return 300
        case .melon:
            return 1000
        }
    }
}

let fruit: ShopItem = .apple
print(type(of: fruit)) // ShopItem
print(fruit)           // apple
print(fruit.price)     // 150
タイププロパティ
タイププロパティは、型のインスタンスではなく、その型自身に紐づくプロパティです。

インスタンスを生成せずに「static」を付与することで直接型から利用できるプロパティです。

インスタンスを生成しないため、このプロパティのコピーは1つになります。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
    
    var price: Int {
        switch self {
        case .apple:
            return 150
        case .orange:
            return 300
        case .melon:
            return 1000
        }
    }
    
    // 「static」を付与して、タイププロパティを定義できます
    static let market: String = "日本"
}

// インスタンス化せずに、直接アクセス
print(ShopItem.market) // 日本
let fruit: ShopItem = .apple
print(fruit.market)     // ❌ インスタンス生成後のオブジェクトからは、呼び出しできずコンパイルエラーが発生します
■メソッド
列挙型も他の型と同様にメソッドを定義することができます。

下記の例では、sellPrice で通常の価格（price）に対して、入力パラメータで受け取った割引比率で、セール価格を返却するメソッドを定義しています。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
    
    var price: Int {
        switch self {
        case .apple:
            return 150
        case .orange:
            return 300
        case .melon:
            return 1000
        }
    }
    
    // セール価格を返却するメソッドを定義
    func sellPrice(ratio: Double) -> Int {
        switch self {
        case .apple:
            return Int(Double(self.price) * ratio)
        case .orange:
            return Int(Double(self.price) * ratio)
        case .melon:
            return Int(Double(self.price) * ratio)
        }
    }
}

var fruit: ShopItem = .melon
print(fruit)                       // melon
print(fruit.price)                 // 1000：通常の価格
print(fruit.sellPrice(ratio: 0.8)) // 800：80%オフでのセール時の価格
計算型プロパティとメソッドの使い分け
下記のような方針で、計算型プロパティとメソッドの使い分けを理解すると整理しやすいです。

列挙体自体の値を利用して何らかのデータを返却したい時は、計算型プロパティに格納。
入力パラメータを受け取って、加工をしたデータを返却したい場合は、メソッドを利用。
mutating属性

Swiftの列挙型は、計算型プロパティの他にもメソッドも定義することができます。

列挙型は、複数の識別子を定数（imutable）としてまとめることができる値型のひとつです。
と説明しましたが、下記のように、mutating属性をメソッド（func）に付与することで列挙型自身（self）を変更することができます。

OBJECTIVEC
// 果物の種類を列挙して型として定義
enum ShopItem {
    case apple
    case orange
    case melon
    
    mutating func reset() {
        self = .apple // 「self」にケースを代入して、インスタンスを上書きしている
    }
}

var fruit: ShopItem = .melon
print(fruit)   // melon
fruit.reset()  // ShopItem型の、resetメソッドを実行
print(fruit)   // apple
■ネスト（入れ子）
列挙型をネスト（入れ子）にして管理することもできます。

下記の例では、お店で販売するアイテムの列挙型の中に、果物を管理する列挙型、野菜を管理する列挙型を保持しています。

このように管理したいデータのまとまりを分類して、管理構造を階層に落とし込むことができます。

OBJECTIVEC
// ショップアイテム列挙型
enum ShopItem {
    // 果物を管理する列挙型
    enum Fruits {
        case apple
        case orange
        case melon
        
        var price: Int {
            switch self {
            case .apple:
                return 150
            case .orange:
                return 300
            case .melon:
                return 1000
            }
        }
    }
    
    // 野菜を管理する列挙型
    enum Vegetables {
        case carrot
        case celery
        case onion
        
        var price: Int {
            switch self {
            case .carrot:
                return 300
            case .celery:
                return 150
            case .onion:
                return 200
            }
        }
    }
}

// ショップアイテムの中の、フルーツ構造体
print(ShopItem.Fruits.apple)       // apple
print(ShopItem.Fruits.apple.price) // 150

// ショップアイテムの中の、ベジタブル構造体
print(ShopItem.Vegetables.carrot)       // carrot
print(ShopItem.Vegetables.carrot.price) // 300

// 型の確認
print(type(of: ShopItem.Fruits.apple))      // Fruits
print(type(of: ShopItem.Vegetables.carrot)) // Vegetables
■Raw Value
列挙型の列挙値には、Raw Value（デフォルト値）を設定することができます。Raw Valueの値は、すべて同じデータ型で指定します。

Raw Valueには、String型、Character型、Int型、Double型のいずれかを指定することがでます。その他の型を指定することはできません。列挙値に設定できる値は、その列挙宣言の中で一意（重複なし）で、かつ同じデータ型である必要があります。

OBJECTIVEC
// String型のデフォルト値を設定
enum Fruits: String {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}

let fruit: Fruits = .orange
print(fruit)
print(fruit.rawValue) // オレンジがデフォルト値

// Int型のデフォルト値を設定
enum Fruits2: Int {
    case apple = 1
    case orange = 2
    case melon = 3
}

let fruit2: Fruits2 = .melon
print(fruit2)
print(fruit2.rawValue) // 3 がデフォルト値
暗黙的に指定される Raw Values
また下記は、データ型だけの指定で、case値にRaw Valuesを設定しない例です。

暗黙的に、Raw Valuesが割り当てられます。

Int型の場合は、上から順番にcase値に対して「0」から整数が割り当てられています。

String型の場合は、case値に指定したキーワードをString型で取得することができます。

OBJECTIVEC
// Int型の指定だけすると、自動的に「0」からデフォルト値を取得できます。
enum Fruits: Int {
    case apple
    case orange
    case melon
}

let fruit: Fruits = .apple
print(fruit)          // apple
print(fruit.rawValue) // 0がデフォルト値

// String型の指定をすると、自動的にcase値をString型として取得できます。
enum Fruits2: String {
    case apple
    case orange
    case melon
}

let fruit2: Fruits2 = .melon
print(fruit2)          // melon
print(fruit2.rawValue) // melon がデフォルト値

// データ型の確認
print(type(of: fruit2))          // Fruits
print(type(of: fruit2.rawValue)) // String
Int型の場合は、最初のcase値を指定すると、ほかのcase値はひとつインクリメント（増加）して設定されます。下記のコードで確認しましょう。

OBJECTIVEC
enum Fruits: Int {
    case apple = 1, orange, melon
}

let fruit: Fruits = .melon
print(fruit)          // melon
print(fruit.rawValue) // 3 rawValueでデフォルト値を取得
Raw Valuesからの初期化
下記のように列挙型が保持している、Raw Valueの値から、初期化を行うこともできます。

この初期化の方法は、Raw Valueが存在しない可能性があるので、オプショナル型で初期化されます。そのため、生成されるオブジェクトはオプショナル型になります。（このコード例では、fruitのことです）

OBJECTIVEC
// Raw Valuesを設定してる列挙型
enum Fruits: Int {
    case apple = 1
    case orange = 2
    case melon = 3
}

let fruit = Fruits(rawValue: 2) // 初期化したい Raw Valueを指定
print(fruit)           // Optional(__lldb_expr_422.Fruits.orange)：警告が表示される
print(fruit?.rawValue) // Optional(2)：警告が表示される
print(type(of: fruit)) // Optional<Fruits>
■Associated Values（共有型の列挙型）
列挙型は単純な値を格納するだけでなく、それぞれのケースに関連した値を格納することができます。

これにより、列挙型に付加情報を付けて、より細かなデータを表現することが可能になります。

列挙型のcaseの後ろにタプル型を付加できます。

列挙値にメソッドのように「引数名：データ」を付加することができます。

下記の例の、runnningというcaseには、String型とInt型のタプル型を追加で保持することができます。destinationとminutesが引数です。

この列挙値を使うときは、logRunningメソッドのようにdestinationとminutesを引数として値を取得して利用することができます。

注意したいポイントは、Associated Values と Raw Values を同時に利用することはできないことです。

OBJECTIVEC
enum Activity {
    case bored
    case running(destination: String, minutes: Int)
    case talking(topic: String)
    case singing(title: String, singer: String)
    
    func logRunning(running: Activity) -> String {
        switch running {
        case .running(let destination, let minutes):
            return "\(destination)まで、\(minutes)分で到着しました。"
        default:
            return "活動なし"
        }
    }
}

let userA = Activity.running(destination: "代々木公園", minutes: 30)
print(userA)                             // running(destination: "代々木公園", minutes: 30)
print(type(of: userA))                   // Activity
print(userA.logRunning(running: userA)) // 代々木公園まで、30分で到着しました。
■列挙型の繰り返し処理
列挙型で、CaseIterableプロトコル（すべての値のコレクションを提供する型）に準拠をすると、allCases プロパティを使用できるようになります。

allCases プロパティを活用すると、すべてのcase値のコレクションにアクセスすることができます。

OBJECTIVEC
// CaseIterableに準拠
enum Fruits: CaseIterable {
    case apple
    case orange
    case melon
}

for fruit in Fruits.allCases { // allCasesで全てのcaseにアクセス可能
    print(fruit)
}

// apple
// orange
// melon
下記の例では、Raw Valuesを設定後に、CaseIterableに準拠することで、全てのcase値にアクセスしています。

OBJECTIVEC
// String型のRaw Valuesを設定して、CaseIterableに準拠
enum Fruits: String, CaseIterable {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}

for fruit in Fruits.allCases { // allCasesで全てのcaseにアクセス可能
    print("\(fruit)は、\(fruit.rawValue)だよ！")
}

// appleは、りんごだよ！
// orangeは、オレンジだよ！
// melonは、メロンだよ！
配列のインスタンスメソッドである、mapメソッドを利用して Raw Valuesを配列に変換することもできます。

mapメソッドの利用方法は、Arrayの一般的なインスタンスメソッドをご参照ください。

OBJECTIVEC
enum Fruits: String, CaseIterable {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}

let fruitList: [String] = Fruits.allCases.map {$0.rawValue}
print(type(of: fruitList)) // Array<String>
print(fruitList)           // ["りんご", "オレンジ", "メロン"]
