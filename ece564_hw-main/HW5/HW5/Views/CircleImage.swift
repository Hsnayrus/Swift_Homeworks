/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that clips an image to a circle and adds a stroke and shadow.
*/



/*
 This file was borrowed from the apple documentation's landmarks app's file cluster.
 The one linked by professor on sakai
 */
import SwiftUI

struct CircleImage: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable(capInsets: EdgeInsets())
            .aspectRatio(contentMode: .fit)
//                                .padding(.all)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.yellow, lineWidth: 4)
            }
            .shadow(radius: 7)
            .padding()
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: maleAvatar!)
    }
}
