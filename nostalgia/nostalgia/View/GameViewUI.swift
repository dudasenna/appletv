//
//  GameViewUI.swift
//  nostalgia
//
//  Created by Evaldo Garcia de Souza Júnior on 31/05/21.
//

import Foundation
import SwiftUI
import SpriteKit

struct GameViewUI: View {
    
    var scene: SKScene {
            let scene = GameScene()
            scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            scene.scaleMode = .fill
            scene.anchorPoint = CGPoint(x: 1, y: 1)
            return scene
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
                // game
                SpriteView(scene: scene)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                            .edgesIgnoringSafeArea(.all)
                
                // UI
                VStack {
                    Spacer().frame(height: 60)
                    HStack(){
                        ZStack(alignment: .topLeading) {
                            Rectangle()
                                .fill(Color.grayColor)
                                .frame(width: 210, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10, corners: [ .bottomRight])
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.whiteColor)
                                    .frame(width: 245, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(100, corners: [.topRight, .bottomRight])
                                
                                HStack(alignment: .bottom, spacing: 3) {
                                    Spacer().frame(width: 80)
                                    Text("3") //aqui que vai mudar pra pegar o valor de quantas vidas restam
                                        .font(.custom("Bebas Neue", size: 50))
                                        .foregroundColor(.blackColor)
                                        .padding(.bottom, -14)
                                    
                                    Text("x")
                                        .font(.custom("Bebas Neue", size: 35))
                                        .foregroundColor(.blackColor)
                                        .padding(.bottom, -10)
                                    
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(.blackColor)
                                        .padding(.horizontal, 8)
                                    
                                }
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                        ZStack(alignment: .topTrailing) {
                            Rectangle()
                                .fill(Color.grayColor)
                                .frame(width: 210, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10, corners: [ .bottomLeft])
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.whiteColor)
                                    .frame(width: 245, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(100, corners: [.topLeft, .bottomLeft])
                                
                                HStack(alignment: .bottom, spacing: 3) {
                                    
                                    Text("1984") //aqui que vai mudar pra pegar o valor dos pontos
                                        .font(.custom("Bebas Neue", size: 65))
                                        .foregroundColor(.blackColor)
                                        .padding(.horizontal, 10)
                                        .padding(.bottom, -8)
                                        
                                    
                                    Spacer().frame(width: 80)
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                
            
            }
        }.background(Color.blackColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct GameViewUI_Previews: PreviewProvider {
    static var previews: some View {
        GameViewUI()
    }
}

// Round Specific Corners SwiftUI
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
