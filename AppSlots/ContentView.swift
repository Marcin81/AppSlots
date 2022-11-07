//
//  ContentView.swift
//  Slots-Challenge
//
import SwiftUI

struct ContentView: View {
  static private let names = ["apple", "cherry", "star"]
  private var betAmount = 5
  static private let rowsLimit = 3
  @State private var credits = 1000
  @State private var win = false
  @State private var slots = Dictionary(uniqueKeysWithValues: zip(0...names.count * rowsLimit, Array(repeating: names, count: rowsLimit).flatMap { $0 }))
  @State private var backgrounds = Array(repeating: Color.white, count: names.count * rowsLimit)

  var body: some View {
    ZStack {
      VStack(spacing: 20.0) {
        Spacer()
        Text("SwiftUI Slots").font(.largeTitle)
        Spacer()
        
        Text("Credits \(credits)")
          .foregroundColor(.black)
          .padding(.all, 10)
          .background(win ? Color.blue.opacity(0.5) : Color.white.opacity(0.5))
          .animation(.none)
          .cornerRadius(20)
          .scaleEffect(win ? 1.2 : 1.0)
          .animation(.spring(response: 0.2, dampingFraction: 0.5))
        
        ForEach(rows(), id:\.self) { key in
          HStack {
            ForEach(0..<ContentView.rowsLimit, id:\.self) { row in
              CardView(symbol: Binding.constant(slots[key+row]!),
                       background: $backgrounds[(key+row)]).animation(.easeInOut(duration: 0.3))
            }
            Spacer()
          }
        }
        
        Button("Spin") {
          randomizeIcons()
          
          let currentMatchedRows = matchedRows()
          self.win = !currentMatchedRows.isEmpty
          if (win) {
            credits += betAmount * 10
          } else {
            credits -= betAmount
          }
          
          markMachedIcons(currentMatchedRows: currentMatchedRows)
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
//    .animation(.easeInOut(duration: 0.6))
      
  }
  
  private func matchedRows() -> [Int] {
    matchRowsIndexes().filter { indexes in
      let selected = slots.filter { indexes.contains($0.key) }
      return Array(selected.values).allSatisfy({ Array(selected.values).first == $0})
    }.reduce([], +)
  }
  
  
  private func randomizeIcons() {
    slots.keys.forEach{ key_index in
      slots[key_index]! = ContentView.names.randomElement()!
    }
  }
  
  private func rows() -> [Int] {
    Array(slots.keys).sorted().filter { key in
      key % 3 == 0
    }
  }
  
  private func matchRowsIndexes() -> [[Int]] {
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  }
  
  private func markMachedIcons(currentMatchedRows: [Int]) {
    self.backgrounds = backgrounds.enumerated().map { index, _background in
      !currentMatchedRows.isEmpty && currentMatchedRows.contains(index) ? Color.blue : Color.white
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//// 0, 1, 2
//// 3, 4, 5
//// 6, 7, 8
