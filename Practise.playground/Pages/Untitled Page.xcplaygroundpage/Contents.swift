import UIKit

// 最初は可能な限りシンプルなプログラムコードで実現できるかを考えるのがポイント
// 最初は、Xcodeプロジェクトでコードを書く前に、Playgroundを使いコードを書いて検証
// コードを書く時には、最初にやりたいことを日本語化

// .onAppear{ Viewが表示された時のアクション }
// .onDisappear{ Viewが消えた時のアクション }



List(1..<101) { number in // Listに直接範囲演算子を指定して動的に表示
    // inの後に処理を実行
    // 偶数行：オレンジ
    if number % 2 == 0 {
        Text(String(number))
            .listRowBackground(Color.orange) // Listのセル単体の背景色の変更
        // 奇数行：赤
    } else {
        Text(String(number))
            .listRowBackground(Color.red) // Listのセル単体の背景色の変更
    }
}

// 3の約数で背景色黄色
// 0の時も適応されてしまうので論理積で条件分岐
var count: Int = 0
if count % 3 == 0 && count != 0 {
    Color.yellow
        .ignoresSafeArea()
}

// 円形のデザイン
    .background(
        Circle()
            .fill(Color.pink)
            .frame(width: 120, height: 120)
    )

// HStack、VStackの中に保有しているオブジェクトの間隔の調整
VStack(spacing: 100) {
    // 省略
}
HStack(spacing: 100) {
    // 省略
}

@State private var inputText: String = ""
   @State private var todoList: String = ""
   @State private var isError: Bool = false
   var body: some View {
       VStack {
           // TextField用意
           TextField("曜日を入力してください", text: $inputText)
               .padding()
           // Text
           Text(todoList)
           // Button
           Button(action: {
               // 入力欄が未入力の時アラート表示
               if inputText.isEmpty {
                   isError = true
               } else {
           // todoリスト
                   switch inputText {
                   case "月曜日":
                       todoList = "胸のトレーニング"
                   case "火曜日":
                       todoList = "背中のトレーニング"
                   case "水曜日":
                       todoList = "休養日"
                   case "木曜日":
                       todoList = "下半身のトレーニング"
                   case "金曜日":
                       todoList = "肩のトレーニング"
                   case "土曜日":
                       todoList = "休養日のトレーニング"
                   case "日曜日":
                       todoList = "腕のトレーニング"
                   default:
                       todoList = "曜日を間違えています"
                   }
               }
           }) {
               Text("🔍やることチェック🔍")
                   .padding(.all, 10)
                   .background(Color.blue)
                   .foregroundColor(Color.white)
                   .cornerRadius(10)
           }
       }
       // アラート設定
       .alert(isPresented: $isError) {
           Alert(title: Text("曜日を入力してください"), dismissButton: .default(Text("OK")))
       }
   }

// TextEditor:複数行のテキストが編集可能
TextEditor(text: Binding<String>)
               .padding()
               .frame(width: 300, height: 100) // フレームサイズ指定
               .border(Color.gray, width: 1)  // フレーム外枠の色と太さ指定

