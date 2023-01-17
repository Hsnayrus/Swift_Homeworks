//
//  DrawingView.swift
//  HW6
//
//  Created by Loaner on 3/7/22.
//

import SwiftUI


struct DrawingView: View {
    var body: some View {
        ScrollView{
            
            GunView()
            
            Spacer()
            VStack{
                Text("Invoker, Dota2")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(AngularGradient(gradient: Gradient(colors: [Color.purple, Color.white]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/))
                GifView()
                    .frame(width: 375, height: 550, alignment: .center)
            }
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
