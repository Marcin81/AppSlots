//
//  ContentView.swift
//  Slots-Challenge
//
import SwiftUI

struct ContentView: View {
    static private var names = ["apple", "cherry", "star"]
    private var betAmount = 5
    @State private var credits = 1000
    @State private var slots = Dictionary(uniqueKeysWithValues: zip(0...ContentView.names.count, ContentView.names))
    @State private var backgrounds = [Color.white, Color.white, Color.white]

    var body: some View {
        VStack(spacing: 20.0) {
            Spacer()
            Text("SwiftUI Slots").font(.largeTitle)
            Spacer()
            
            Text("Credits \(credits)")

          
            HStack {
              ForEach(Array(slots.keys), id:\.self) { key in
                CardView(symbol: Binding.constant(slots[key]!),
                         background: $backgrounds[key])
              }
            }
            Spacer()
            Button("Spin") {
              randomizeIcons()
                
              if allIconsEqual() {
                credits += betAmount * 10
                self.backgrounds = backgrounds.map { _ in
                  Color.blue
                }
              } else {
                credits -= betAmount
                self.backgrounds = backgrounds.map { _ in
                  Color.white
                }
              }
            }
            // Set padding for all edges
            .padding()
            // Then adjust the left and right padding to be bigger
            .padding([.leading, .trailing], 40)
            .foregroundColor(.white)
            .background(Color(.systemPink))
            .cornerRadius(25)
            .font(.system(size: 18, weight: .bold, design: .default))
            Spacer()
        }
        
    }
  
  private func allIconsEqual() -> Bool {
    Array(slots.values).allSatisfy({ Array(slots.values).first == $0})
  }
  
  private func randomizeIcons() {
    slots.keys.forEach{ key_index in
      slots[key_index]! = ContentView.names.randomElement()!
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
