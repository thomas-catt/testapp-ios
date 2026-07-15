import SwiftUI

struct CounterView: View {
    // 1. STATE PROPERTY:
    // In React Native, this is like: const [count, setCount] = useState(0)
    // In Compose, this is like: var count by remember { mutableStateOf(0) }
    @State private var count: Int = 0
    
    private func changeCount(_ c: Int) {
        withAnimation(.spring()) {
            count += c
        }
    }
    
    private func resetCount() {
        withAnimation(.spring()) {
            count = 0
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Score Display Panel
            VStack(spacing: 10) {
                Text("Tap Score")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text("\(count)")
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(count >= 0 ? .blue : .red)
                    .contentTransition(.numericText()) // Animate number transitions
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .padding(.horizontal)
            
            // Buttons Section
            HStack(spacing: 20) {
                // Increment Button
                Button(action: {
                    changeCount(1)
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.gradient)
                    .cornerRadius(16)
                }
                
                // --- YOUR TURN TO CODE! ---
                // TODO: Add a Decrement Button here
                // It should subtract 1 from the count.
                // Feel free to style it with a different color (like red or orange).
                Button(action: {
                    changeCount(-1)
                }) {
                    HStack {
                        Image(systemName: "minus.circle.fill")
                        Text("Subtract")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.gradient)
                    .cornerRadius(16)
                }
            }
            .padding(.horizontal)
            
            // TODO: Add a Reset Button at the bottom to reset count to 0
            
            HStack(spacing: 20) {
                Button(action: {
                    resetCount()
                }) {
                    Text("Reset Counter")
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Counter Game")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CounterView()
}
