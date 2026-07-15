import SwiftUI

// 1. TODO MODEL
// Models in SwiftUI that are displayed in a List should conform to Identifiable.
struct TodoItem: Identifiable {
    let id = UUID() // Automatically generates a unique ID (like a key in React Native)
    var title: String
    var isCompleted: Bool = false
    
    public mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}

struct TodoView: View {
    // 2. STATE PROPERTIES
    // (Similar to useState in React Native)
    @State private var todos: [TodoItem] = [
        TodoItem(title: "Learn SwiftUI layout"),
        TodoItem(title: "Build Counter app", isCompleted: true)
    ]
    @State private var newTodoTitle: String = ""
    
    // Helper to add a new todo
    private func addTodo() {
        guard !newTodoTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        // --- YOUR TURN TO CODE! ---
        // TODO: Create a new TodoItem using `newTodoTitle`
        // TODO: Append it to the `todos` array
        // TODO: Clear the `newTodoTitle` string so the text input resets
        todos.append(TodoItem(title: newTodoTitle, isCompleted: false))
        newTodoTitle = ""
    }
    
    // Helper to delete a todo
    private func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    var body: some View {
        VStack {
            // 3. INPUT BAR
            HStack(spacing: 12) {
                // A two-way binding to state is created by using the `$` prefix
                TextField("Add a new task...", text: $newTodoTitle)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(12)
                
                Button(action: addTodo) {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green.gradient)
                        .cornerRadius(12)
                }
            }
            .padding()

            // 4. THE LIST
            List {
                // --- YOUR TURN TO CODE! ---
                // TODO: Replace this Text view with a ForEach loop over `$todos`.
                // Example: ForEach($todos) { $todo in ... }
                // Inside the loop, build an HStack with an Image (checkbox) and Text.
                // TODO: Add an onTapGesture to the checkbox to toggle `todo.isCompleted`.
                ForEach($todos) { $todo in
                    HStack() {
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(todo.isCompleted ? .green : .gray)
                            .font(.headline)
                            .onTapGesture {
                                todo.toggleCompletion()
                            }
                        Text(todo.title)
                            .strikethrough(todo.isCompleted)
                            .italic(todo.isCompleted)
                            .foregroundColor(todo.isCompleted ? .secondary : .primary)
                    }
                }
                .onDelete(perform: deleteTodo)
                
                // TODO: Attach the `.onDelete(perform: deleteTodo)` modifier to your ForEach
                // to enable swipe-to-delete.
            }
            .listStyle(.insetGrouped)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Todo List")
        .toolbar {
            EditButton() // Built-in iOS Edit button for lists
        }
    }
}

#Preview {
    NavigationStack {
        TodoView()
    }
}
