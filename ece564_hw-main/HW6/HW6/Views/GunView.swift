import SwiftUI
import PureSwiftUI
import AVFAudio


private let layoutGun = LayoutGuideConfig.grid(columns: 60, rows: 40)
private typealias bCurve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct basicGun: Shape{
    
    let debug: Bool
    
    init(debug: Bool = false){
        self.debug = debug
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = layoutGun.layout(in: rect)
        
        //Barrel front top
        let p1 = g[12, 15]
        //Barrel front bottom
        let p2 = g[12, 16]
        //Top thing
        //        let p3 = g[7, 3]
        //Top thing end
        //        let p4 = g[7, 4]
        //Barrel back top
        let p5 = g[45, 15]
        //Barrel back curve bottom
        //        let p5d1 = g[44, 14]
        //Barrel back bottom
        let p6 = g[45, 18]
        //Arm rest
        let p7 = g[41, 20]
        //Arm rest end
        let p8 = g[44, 30]
        //Bottom left
        let p9 = g[37, 32]
        //Gun inside, without trigger
        let p10 = g[32, 18]
        //Five seven bottom near barrel after trigger
        let p11 = g[15, 18]
        //        //Trigger bottom
        //        let p12 = g[17, 12]
        //        //Trigger middle
        //        let p13 = g[12, 12]
        //        //Trigger left
        //        let p14 = g[12, 9]
        
        var curves = [bCurve]()
        
        curves.append(bCurve(p1, p1, p1))
        curves.append(bCurve(p5, p5, p5))
        //        curves.append(bCurve(p5d1, g[44, 12], p5d1))
        //        curves.append(bCurve(p6, p6, p6))
        curves.append(bCurve(p7, p6, p6))
        curves.append(bCurve(p8, p8, p8))
        curves.append(bCurve(p9, g[44, 32], g[44, 32]))
        //        curves.append(bCurve(p12, p12, p12))
        curves.append(bCurve(p10, g[36, 32], g[36, 32]))
        //        curves.append(bCurve(p14, p13, p13))
        curves.append(bCurve(p11, p11, p11))
        
        //        curves.append(bCurve(p12, p12, p12))
        //        curves.append(bCurve(p13, p13, p13))
        //        curves.append(bCurve(p14, p14, p14))
        curves.append(bCurve(p2, g[12, 18], p2))
        
        path.move(to: p1)
        
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: debug)
        }
        return path
    }
}

struct gunTrigger: Shape{
    let debug: Bool
    
    init(debug: Bool = false){
        self.debug = debug
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = layoutGun.layout(in: rect)
        
        //Trigger bottom
        let p1 = g[34, 24]
        //Trigger middle
        let p2 = g[24, 24]
        //Trigger left
        let p3 = g[24, 18]
        //Gun inside
        let p4 = g[32, 18]
        
        var curves = [bCurve]()
        curves.append(bCurve(p3, p2, p2))
        curves.append(bCurve(p4, p4, p4))
        path.move(to: p1)
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: debug)
        }
        return path
    }
}

struct gunBarrel: Shape{
    var factor: CGFloat
    
    let debug: Bool
    
    init(animating: Bool, debug: Bool = false) {
        self.factor = animating ? 1 : 0
        self.debug = debug
    }
    
    var animatableData: CGFloat {
        get {
            factor
        }
        set {
            factor = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = layoutGun.layout(in: rect)
        
        //Barrel left bottom
        let p1 = g[12, 15].to(g[27, 15], factor).to(g[12, 15], factor)
        //Barrel left top
        let p2 = g[13, 12].to(g[28, 12], factor).to(g[13, 12], factor)
        //Barrel back top
        let p3 = g[43, 12].to(g[58, 12], factor).to(g[43, 12], factor)
        //Barrel back curve bottom
        let p4 = g[45, 15].to(g[60, 15], factor).to(g[45, 15], factor)
        //Control points
        let p2c = g[12, 12].to(g[27, 12], factor).to(g[12, 12], factor)
        let p4c = g[44, 12].to(g[59, 12], factor).to(g[44, 12], factor)
        //Trigger left
        //        let p3 = g[24, 18]
        //Gun inside
        //        let p4 = g[32, 18]÷
        
        var curves = [bCurve]()
        curves.append(bCurve(p2, p2c, p2c))
        curves.append(bCurve(p3, p3, p3))
        curves.append(bCurve(p4, p4c, p4c))
        path.move(to: CGPoint(p1.x, p1.y))
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: debug)
        }
        return path
    }
}

struct bullet: Shape{
    let x: Int
    let y: Int
    let debug: Bool
    let top: Bool
    let magTop: Bool
    let shell: Bool
    
    var factor: CGFloat
    
    var animatableData: CGFloat {
        get {
            factor
        }
        set {
            factor = newValue
        }
    }
    
    init(x startX: Int, y startY: Int, animating: Bool, top: Bool, magTop: Bool, shell: Bool, debug d: Bool = false){
        self.x = startX
        self.y = startY
        self.factor = animating ? 1 : 0
        self.debug = d
        self.top = top
        self.magTop = magTop
        self.shell = shell
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = layoutGun.layout(in: rect)
        
        //Bullet bottom right
        let p1 = g[x, y]
            .to(top ? g[x + 50, y - 200] : (magTop ? g[x - 1, y - 3] : g[x - 100, y]), factor)
            .to(top ? g[x + 100, y - 100] : (magTop ? g[x - 1, y - 3] : g[x - 100, y]), factor)
            .to(top ? g[40, 60] : (magTop ? g[x - 1, y - 3] : g[x - 100, y]), factor)
        
        let p2 = g[x - 2, y]
            .to(top ? g[x + 48, y - 200] : (magTop ? g[x - 3, y - 3] : g[x - 102, y]), factor)
            .to(top ? g[x + 100, y - 100] : (magTop ? g[x - 3, y - 3] : g[x - 100, y]), factor)
            .to(top ? g[40, 60] : (magTop ? g[x - 3, y - 3] : g[x - 100, y]), factor)
        
        let p3 = g[x - 2, y - 2]
            .to(top ? g[x + 48, y - 202] : (magTop ? g[x - 3, y - 5] : g[x - 102, y - 2]), factor)
            .to(top ? g[x + 100, y - 100] : (magTop ? g[x - 3, y - 5] : g[x - 100, y]), factor)
            .to(top ? g[40, 60] : (magTop ? g[x - 3, y - 5] : g[x - 100, y]), factor)
        //Point to move on, bullet's tip
        let p3m = g[x - 3, y - 1]
            .to(top ? g[x + 47, y - 201] : (magTop ? g[x - 4, y - 4] : g[x - 103, y - 1]), factor)
            .to(top ? g[x + 100, y - 100] : (magTop ? g[x - 4, y - 4] : g[x - 100, y]), factor)
            .to(top ? g[40, 60] : (magTop ? g[x - 4, y - 4] : g[x - 100, y]), factor)
        
        let p4 = g[x, y - 2]
            .to(top ? g[x + 50, y - 202] : (magTop ? g[x - 1, y - 5] : g[x - 100, y - 2]), factor)
            .to(top ? g[x + 100, y - 100] : (magTop ? g[x - 1, y - 5] : g[x - 100, y]), factor)
            .to(top ? g[40, 60] : (magTop ? g[x - 1, y - 5] : g[x - 100, y]), factor)
        var curves = [bCurve]()
        
        curves.append(bCurve(p1, p1, p1))
        curves.append(bCurve(p2, p2, p2))
        curves.append(bCurve(p3, shell ? p3 : p3m, shell ? p3 : p3m))
        curves.append(bCurve(p4, p4, p4))
        
        path.move(p1)
        
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: debug)
        }
        
        return path
    }
}


struct GunView: View {
    @State var x: Int = 0
    @State private var triggered: Bool = false
    @State private var animationDuration: Double =  1.0
    @State private var audioPlayer: AVAudioPlayer!
    @State private var bulletOut: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("Faster")
                    .font(.title2)
                Spacer()
                Text("Slower")
                    .font(.title2)
            }
            .padding()
            Slider(value: $animationDuration, in: 0...10)
                .padding()
            Text("\(animationDuration)x")
                .padding()
            ZStack {
                basicGun(/*debug: true*/)
                    .foregroundColor(.blue)
                    .frame(width: 312, height: 213, alignment: .center)
                Button(action: {
                    if(audioPlayer != nil){
                        if(self.audioPlayer.isPlaying){
                            self.audioPlayer.stop()
                            if(self.animationDuration >= 1){
                                self.audioPlayer.rate = 20.0 / Float(self.animationDuration)
                            }
                            else{
                                self.audioPlayer.rate = 1.0 / Float(self.animationDuration)
                            }
                            self.audioPlayer.prepareToPlay()
                            self.audioPlayer.play()
                        }
                        else{
                            if(self.animationDuration >= 1){
                                self.audioPlayer.rate = 20.0 / Float(self.animationDuration)
                            }
                            else{
                                self.audioPlayer.rate = 1.0 / Float(self.animationDuration)
                            }
                            self.audioPlayer.prepareToPlay()
                            self.audioPlayer.play()
                        }
                    }
                    withAnimation(Animation.easeOut(duration: animationDuration).repeatCount(1, autoreverses: true)){
                        triggered.toggle()
                    }
                    withAnimation(Animation.easeOut(duration: animationDuration)){
                        bulletOut.toggle()
                    }
                    after(animationDuration + 0.2){
                        bulletOut.toggle()
                    }
                }){
                    gunTrigger(/*debug: true*/)
                        .foregroundColor(.red)
                        .frame(width: 312, height: 213, alignment: .center)
                }
                .disabled(bulletOut)
                ZStack {
                    gunBarrel(animating: triggered)
                        .foregroundColor(.black)
                        .frame(width: 312, height: 213, alignment: .center)
                }
                .transition(.opacity)
                Group{
                    bullet(x: 35, y: 15, animating: bulletOut, top: false, magTop: false, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 32, y: 15, animating: bulletOut, top: true, magTop: false, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
                Group{
                    bullet(x: 40, y: 30, animating: bulletOut, top: false, magTop: true, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 42, y: 30, animating: bulletOut, top: false, magTop: true, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
                Group{
                    bullet(x: 39, y: 27, animating: bulletOut, top: false, magTop: true, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 41, y: 27, animating: bulletOut, top: false, magTop: true, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
                Group{
                    bullet(x: 38, y: 24, animating: bulletOut, top: false, magTop: true, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 40, y: 24, animating: bulletOut, top: false, magTop: true, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
                Group{
                    bullet(x: 37, y: 21, animating: bulletOut, top: false, magTop: true, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 39, y: 21, animating: bulletOut, top: false, magTop: true, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
                Group{
                    bullet(x: 36, y: 18, animating: bulletOut, top: false, magTop: true, shell: false)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.yellow)
                    bullet(x: 38, y: 18, animating: bulletOut, top: false, magTop: true, shell: true)
                        .frame(width: 312, height: 213, alignment: .center)
                        .foregroundColor(.black)
                }
            }
        }.onAppear {
            let sound = Bundle.main.path(forResource: "FiringSound", ofType: "mp3")
            if(sound != nil){
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.enableRate = true
            }
            else{
                print("Trigger sound not found")
            }
        }
    }
}


struct GunView_Previews: PreviewProvider {
    static var previews: some View {
        GunView()
//            .showLayoutGuides(true)
    }
}
