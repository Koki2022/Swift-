import UIKit

構造体とは、自分で作ることができる（ユーザーが定義できる）データ型のことです。扱いたいデータを同じ構造（テンプレート：雛形）でインスタンス化を行い、コード上で処理を行うことができます。



■構造体のイメージ


■プロパティの種類


格納型プロパティと宣言型プロパティの違いを比較してみましょう。

今まで基本的に定数・変数に値を代入して利用してきましたが、その方法が格納型プロパティです。

計算型プロパティは、関数のように何らかの計算をした結果を格納することができるプロパティで、型アノテーション（データ型を明記する）を付与して宣言する必要があるのと、変数しか保持できない（定数は不可）という違いがあります。

▼プロパティの種類と機能の比較
プロパティの種類    特徴    宣言時のキーワード    型名の省略
格納型プロパティ（stored property）    変数や定数が値を保持する機能を提供するプロパティ。値を保持するのが目的なので格納型（stored）と呼ばれます。    var もしくは let    可能
計算型プロパティ（computed property）    値の参照と更新の機能を手続きで構成するプロパティ。関数のように計算する機能を持たすことができることから計算型（computed）と呼ばれます。    var のみ    不可能
この2つのプロパティの違いを、コードで確認してみます。

User構造体を定義して、データを型に落とし込んで確認してみましょう。構造体名に指定した名前が、そのまま型の名前になります。

データの型を調べることができる type(:of)メソッドで確認をしてみましょう。

構造体名に付けた Userが型名として確認できます。

💻 必ずPlaygroundで実際にコードを入力しながら確認してください。
Playgroundの利用方法はこちらをご参照ください。

OBJECTIVEC
struct User {
    let name: String  // 格納型プロパティ（stored property）
    let rank: String  // 格納型プロパティ（stored property）
    let point: Int    // 格納型プロパティ（stored property）
    
    var bonus: Int {  // 計算型プロパティ（computed property）
        if rank == "Gold" {
            return point * 3
        } else {
            return point * 2
        }
    }

    func showScore() { // メソッド
        print("\(name)さんのポイントは、\(point)点！")
    }
    
    func showBonus() { // メソッド
        print("\(name)さんのボーナスは、\(bonus)点！")
    }
}

let sakura = User(name: "さくら", rank: "Standard", point: 300) // インスタンスを生成
sakura.showScore()      // さくらさんのポイントは、200点！
sakura.showBonus()      // さくらさんのボーナスは、400点！
print(type(of: sakura)) // ✅ 構造体名に付けた Userが型名として確認できます。

let jone = User(name: "ジョン", rank: "Gold", point: 150)       // インスタンスを生成
jone.showScore()       // ジョンさんのポイントは、150点！
jone.showBonus()       // ジョンさんのボーナスは、450点！
print(type(of: jone))  // ✅ 構造体名に付けた Userが型名として確認できます。
■イニシャライザ（初期化）
イニシャライザ（初期化）とは、ある物を使用可能の状態にする処理のことです。Swiftでは、構造体、クラス、列挙型のインスタンスを利用できるようにするための【準備をするプロセス】を意味します。



このプロセスでは、インスタンスに保存されている各プロパティに初期値を設定し（必ず初期値を設定する必要があります！）、新しいインスタンスが使用できるようになるまでに必要な、その他の設定や初期化を実行します。

イニシャライザ
イニシャライザを作るときは init キーワードを利用します。

init() {
    // ここで初期化を行う
}
イニシャライザの定義には、次のルールがあります。

・init 以外のキーワードを利用することはできない
・init キーワードのコードブロック {} には初期化のための手続きを記述
・init キーワードのコードブロック {} 内では、構造体のプロパティに自由にアクセス可能
・複数個のイニシャライザを定義することが可能
上記のルールが具体的にどういうことなのか、コードで確認してみましょう。

下記の、User構造体には保持している2つのプロパティに初期値をセットする init()と1つだけ引数を受け取るinit(inputName: String)が定義されています。

このように、複数のイニシャライザを用意して用途に応じた初期化を行うことができます。

OBJECTIVEC
struct User {
    let name: String
    var point: Int
    
    // init 以外のキーワードを利用することはできない
    init() {
        name = "名無し" // init キーワードのコードブロック {} には初期化のための手続きを記述
        point = 1000   // init キーワードのコードブロック {} 内では、構造体のプロパティに自由にアクセス可能
    }
    
    init(inputName: String) { // 複数個のイニシャライザを定義することが可能
        name = inputName
        point = 2000
    }
}
let defaultUser = User() // 引数を持たないイニシャライザーを利用してインスタンス生成
print(defaultUser) // User(name: "名無し", point: 1000)

let sakura = User(inputName: "さくら") // inputNameを引数として持つイニシャライザーを利用してインスタンス生成
print(sakura)      // User(name: "さくら", point: 2000)
ストアドプロパティ（格納型プロパティ）の初期値設定
クラスや構造体は、そのインスタンスが生成されるまでに、すべてのストアドプロパティを適切な初期値に設定する必要があります。ストアドプロパティに何も値が保持されていない、不確定な状態のままにしておくことはできません。

対して、計算型プロパティは、インスタンス生成時に計算した何らかの値で初期化するので引数に指定する必要はありません。

イニシャライザの方法には、さきほど紹介した「initキーワード」での方法と、次の「全項目イニシャライザ」を使う方法があります。

全項目イニシャライザ（memberwise initializer）
イニシャライザの定義(init)の省略形です。

構造体で個々のプロパティの値を指定してインスタンスを生成する初期化方法を全項目イニシャ ライザ(memberwise initializer)といいます。このときは init キーワードを省略できます。

全項目イニシャライザには、次のルールがあります。

・構造体で初期値を設定していないプロパティは、インスタンス生成時に初期値の設定が必要
・構造体で初期値を設定しているプロパティは、インスタンス生成時の初期値の設定を省略可能
・引数はプロパティが宣言されている順番で指定
コードで確認してみましょう。

OBJECTIVEC
struct User {
    // 格納型プロパティはインスタンス生成時に引数で受け取り初期化する必要があります。
    let name: String
    let rank: String
    let point: Int
    
    // 計算型プロパティは、何らかの値で初期化を行うためインスタンス生成時に引数を受け取る必要はありません。
    var bonus: Int {
        if rank == "Gold" {
            return point * 3
        } else {
            return point * 2
        }
    }
}

// 全ての格納型プロパティの値を引数として指定する必要があります。
let sakura = User(name: "さくら", rank: "Standard", point: 30) // ⭕️ 全てのパラメータを指定しているので、インスタンスを生成
print(sakura.name)  // さくら
print(sakura.rank)  // Standard
print(sakura.point) // 30
print(sakura.bonus) // 60

let jone = User(name: "ジョン") // ❌ 初期化のためのパラメーターが足りていないので、インスタンス生成不可
構造体の並び替え
カスタム構造体やクラスで任意にソートしたい場合は、指定したフィールドでソートする末尾のクロージャを使用して sortメソッド、もしくは、sortedメソッドを呼び出す必要があります。

それぞれのメソッドの違いを確認しましょう。

sort（破壊的なソート）
sortの特徴は、実行したタイミングで、対象の構造体を直接並び替えて変更します。

このような動作を、破壊的な変更、または破壊的なソートという風に言います。または、副作用ともいいます。

プログラミングの世界の副作用とは、関数が何かを行うために、その引数の外にあるものに依存したり、それを変更したりすることです。sortメソッドは副作用があるメソッドです。

OBJECTIVEC
// ユーザ構造体を定義
struct User {
    let name: String
    let age: Int
}

// User型の配列を宣言
var users: [User] = []
// User型を利用して、ユーザのデータを生成
users.append(User(name: "さくら", age: 20))
users.append(User(name: "たろう", age: 25))
users.append(User(name: "ジョン", age: 10))

// 並び替え前の中身の確認
for user in users {
    print("並び替え前：\(user)")
}
// 並び替え前：User(name: "さくら", age: 20)
// 並び替え前：User(name: "たろう", age: 25)
// 並び替え前：User(name: "ジョン", age: 10)

// ✅ 末尾のクロージャでsortメソッドを実行
users.sort {
    // 指定したプロパティで昇順にソート
    $0.age < $1.age // $0.age > $1.age と矢印の向きを反対にすると降順にソートを行います。
}

// 並び替え後の中身の確認
for user in users {
    print("並び替え後：\(user)")
}
// 並び替え後：User(name: "ジョン", age: 10)
// 並び替え後：User(name: "さくら", age: 20)
// 並び替え後：User(name: "たろう", age: 25)
sorted（非破壊的なソート）
対して、sortedメソッドは並び替えを直接変数に上書きすることはありません。

副作用のないメソッドと言えます。元の構造体を変更したくない場合に、sortedメソッドを利用して並び替えを行います。

OBJECTIVEC
// ユーザ構造体を定義
struct User {
    let name: String
    let age: Int
}

// User型の配列を宣言
var users: [User] = []
// User型を利用して、ユーザのデータを生成
users.append(User(name: "さくら", age: 20))
users.append(User(name: "たろう", age: 25))
users.append(User(name: "ジョン", age: 10))

// 並び替え前の中身の確認
for user in users {
    print("並び替え前：\(user)")
}
// 並び替え前：User(name: "さくら", age: 20)
// 並び替え前：User(name: "たろう", age: 25)
// 並び替え前：User(name: "ジョン", age: 10)

// ✅ 末尾のクロージャでsortedメソッドを実行
let sortUsers = users.sorted {
    // 指定したプロパティで昇順にソート
    $0.age < $1.age // $0.age > $1.age と矢印の向きを反対にすると降順にソートを行います。
}

// 並び替え後の中身の確認
for user in sortUsers {
    print("並び替え後：\(user)")
}
// 並び替え後：User(name: "ジョン", age: 10)
// 並び替え後：User(name: "さくら", age: 20)
// 並び替え後：User(name: "たろう", age: 25)
