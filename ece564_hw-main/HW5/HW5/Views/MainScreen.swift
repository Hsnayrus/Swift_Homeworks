//
//  MainScreen.swift
//  HW4
//
//  Created by Loaner on 2/9/22.
//

import SwiftUI

func refreshServer()
{
    var _: DownloadView = DownloadView()
    navBarSaveFunction()
}



struct MainScreen: View {
    var body: some View {
                NavigationView{
                    ZStack{
                    AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                    VStack {
                        Spacer()
                        NavigationLink(destination: ListView()) {
                            Text("List View")
                                .font(.title)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        
                        NavigationLink(destination: DownloadView()) {
                            Text("Refresh From Server")
                                .font(.title)
                                .foregroundColor(Color(hue: 0.225, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        .navigationBarHidden(true)
                        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        
                        Spacer()
                    }
                }
                }
        }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
