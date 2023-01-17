//
//  Test.swift
//  HW6
//
//  Created by Loaner on 2/27/22.
//

import SwiftUI

struct Test: View {
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            Button("Press to show details") {
                withAnimation {
                    showDetails.toggle()
                }
            }
            
            if showDetails {
                // Moves in from the bottom
                Text("Details go here.")
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
