//
//  CardView.swift
//  AppSlots
//
//  Created by Marcin on 01/11/2022.
//

import SwiftUI

struct CardView: View {
  @Binding var symbol:String
  @Binding var background:Color
  private let transition: AnyTransition = AnyTransition.move(edge: .bottom)

  var body: some View {
//    VStack {
      Image(symbol)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .transition(transition)
//    }
    .background(background.opacity(0.5))
    .cornerRadius(20)
  }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      CardView(symbol: Binding.constant("cherry"),
               background: Binding.constant(Color.white))
    }
}
