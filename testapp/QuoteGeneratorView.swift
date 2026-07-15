import SwiftUI

struct Quote: Codable {
    let q: String
    let a: String
}

struct QuoteCard: View {
    var quote: Quote?
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                if let safeQuote = quote {
                    Text("\"\(safeQuote.q)\"")
                        .foregroundColor(.black)
                        .font(.system(size: 40, design: .serif))
                        .tracking(-2)
                        .lineSpacing(0)
                    
                    Text("— \(safeQuote.a)")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(.footnote, design: .rounded, weight: .bold))
                        .tracking(2)
                        .textCase(.uppercase)
                        .multilineTextAlignment(.trailing)
                } else {
                    Text("No quote was loaded.")
                        .foregroundColor(.black)
                }
            }
            .padding(30)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, minHeight: 200)
                .background(.orange.gradient.opacity(0.8))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            
        }
        .padding()
    }
}

struct QuoteGeneratorView: View {
    @State var quote: Quote? = nil
    @State var errorMessage: String = ""
    @State var isError: Bool = false
    @State var isLoading: Bool = false
    
    private func loadQuote() async {
        isLoading = true
        isError = false
        errorMessage = ""
        quote = nil
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://zenquotes.io/api/random")!)
            let quotes = try JSONDecoder().decode([Quote].self, from: data)
            quote = quotes[0]
            isLoading = false
        } catch {
            print(error)
            isError = true
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        VStack {
            if isLoading { ProgressView().padding(.vertical, 100) }
            else {
                ScrollView {
                    QuoteCard(quote: quote)
                    HStack(alignment: .center, spacing: 0) {
                        Text("via zenquotes.io • ")
                            .textCase(.uppercase)
                            .tracking(2)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                        Button(action: {
                            Task {
                                await loadQuote()
                            }
                        }) {
                            Text("Load Another")
                                .foregroundColor(.blue)
                                .font(.system(size: 12))
                        }
                    }
                }
            }
        }
        .alert("Failed to fetch quote: \(errorMessage)", isPresented: $isError) {
            Button("Close", role: .close) {
                isError = false
                errorMessage = ""
            }
        }
        .task {
             await loadQuote()
//            quote = Quote(q: "Something cool and inspirational I guess.", a: "pomas catt")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the background color covers the whole screen
        .background(Color(.systemGroupedBackground))      // <--- THE MAGIC BACKGROUND COLOR
        .navigationTitle("Quote Generator")
    }
}

#Preview {
    NavigationStack {
        QuoteGeneratorView()
    }
}
