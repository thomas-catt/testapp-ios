import SwiftUI

struct TodoView: View {
    var body: some View {
        VStack {
            Text("Todo List Screen")
                .font(.largeTitle)
        }
        .navigationTitle("Todo List")
    }
}

#Preview {
    TodoView()
}
