import SwiftUI

struct ColorRow: View {
    @Binding var value: Double
    var label: String
    var body: some View {
        HStack() {
            Text(label)
                .frame(width: 50, alignment: .leading)
            Slider(value: $value, in: 0...255)
            Text("\(Int(value))")
                .frame(width: 50)
        }
        .padding(.horizontal)
    }
}

struct ColorOutput: View {
    var r: Double
    var g: Double
    var b: Double
    
    private struct ColorRect: View {
        var r: Double
        var g: Double
        var b: Double
        var body: some View {
            Rectangle()
                .fill(Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.regularMaterial, lineWidth: 1))
                .frame(width: 150, height: 150)
        }
    }
        
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            VStack(spacing: 20) {
                Text("Output Color")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                VStack(alignment: .leading) {
                    Text("Red: \(Int(r))")
                    Text("Green: \(Int(g))")
                    Text("Blue: \(Int(b))")
                }
            }
            ColorRect(r: r, g: g, b: b)
        }
        .padding(20)
        .frame(alignment: .center)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)

    }
}

struct ColorMixerView: View {
    @State private var sliderR: Double = 255
    @State private var sliderG: Double = 255
    @State private var sliderB: Double = 255
    var body: some View {
        VStack() {
            ColorRow(value: $sliderR, label: "Red")
            ColorRow(value: $sliderG, label: "Green")
            ColorRow(value: $sliderB, label: "Blue")
            
            ColorOutput(r: sliderR, g: sliderG, b: sliderB)
        }
        .frame(alignment: .leading)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the background color covers the whole screen
        .background(Color(.systemGroupedBackground))      // <--- THE MAGIC BACKGROUND COLOR
        .navigationTitle("Color Mixer")
    }
}

#Preview {
    NavigationStack() {        
        ColorMixerView()
    }
}
