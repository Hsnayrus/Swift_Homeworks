//
//  CircleImageRow.swift
//  HW5
//
//  Created by Loaner on 2/13/22.
//

import SwiftUI

struct CircleImageRow: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable(capInsets: EdgeInsets())
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fill)
//                                .padding(.all)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.yellow, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImageRow_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageRow(image: maleAvatar!)
    }
}
