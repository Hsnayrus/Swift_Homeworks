//
//  GifView.swift
//  HW6
//
//  Created by Loaner on 3/9/22.
//

import SwiftUI


func loadImages() -> [UIImage]{
    var imageArray: [UIImage] = []
    let imagePrefix: String = "InvokerGif-"
    let imageExtension: String = ".jpg"
    for i in 0..<50{
        let imageName: String = imagePrefix + "\(i)" + imageExtension
        imageArray.append(UIImage(named: imageName)!)
    }
//    var i: Int = 49
//    while(i != 0){
//        let imageName: String = imagePrefix + "\(i)" + imageExtension
//        imageArray.append(UIImage(named: imageName)!)
//        i -= 1
//    }
    return imageArray
}


/*
 Was made in reference to:
 https://stackoverflow.com/questions/57151335/how-to-animate-images-in-swiftui-to-play-a-frame-animation
 
 */
struct workoutAnimation: UIViewRepresentable {
    
    func makeUIView(context: Self.Context) -> UIView {
        let animatedImage = UIImage.animatedImage(with: loadImages(), duration: 2.5)
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 550))
        let someImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 550))
        someImage.clipsToBounds = true
        someImage.layer.cornerRadius = 20
        someImage.autoresizesSubviews = true
        someImage.contentMode = UIView.ContentMode.scaleAspectFill
        someImage.image = animatedImage
        someView.addSubview(someImage)
        return someView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<workoutAnimation>) {
        
    }
}

struct GifView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10) {
            workoutAnimation()
        }
    }
}

struct GifView_Previews: PreviewProvider {
    static var previews: some View {
        GifView()
    }
}
