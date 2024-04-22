//
//  ShazamView.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/20/24.
//

import SwiftUI
import PureSwiftUI

struct ShazamView: View {
    @State var showingMenu = false;
    @StateObject var vm = ContentViewModel()
    //@StateObject private var shazamHandler = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {vm.startOrEndListening()}) {
                                ShazamLogo()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    SongsView(showingMenu: $showingMenu, vm: vm)
                        .offset(y: geometry.size.height * 0.85)
                        .sheet(isPresented: $showingMenu) {
                            SongsView(showingMenu: $showingMenu, vm: vm)
                        }
                }
            }
            .backgroundColor(.appMediumGray)
            .ignoresSafeArea()
        }
    }
}



struct ShazamLogo: View {
    @State private var showingTitle = false
    @State private var breathing = false
    var body: some View {
        ZStack {
            Label("Tap to Shazam", sfSymbol: .mic_fill)
                .titleFont(.white, .bold)
                .yOffset(-175)
                .opacityIfNot(showingTitle, 0)
            CircleAndLinks()
                .frame(200)
                .scaleIf(breathing, 1.17)
        }
        .onAppear {
            after(0.5) {
                withAnimation(.easeInOut(duration: 2)) {
                    showingTitle = true
                }
            }
            after(1) {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    breathing = true
                }
            }
        }
    }
}




private struct CircleAndLinks: View {
    
    @State private var animated = false
    @State private var scaled = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient([Color(white: 0.3), Color(white: 0.35)], to: .bottom))
                .shadowColor(.gray, 0.2, y: -1.5)
            
            let fromTrim: CGFloat = 0.43
            let toTrim: CGFloat = 1

            let whiteLink = Link(fromTrim: animated ? fromTrim : fromTrim - 2,
                                 toTrim: animated ? toTrim : toTrim - 2.5, color: .white)
            let blackLink = Link(fromTrim: animated ? fromTrim + 1 : fromTrim,
                 toTrim: toTrim, color: .black)
            
            Group {
                whiteLink
                whiteLink.rotate(180.degrees)
            }
            .shadowColor(.black, 0.2, y: 0.4)

            Group {
                blackLink
                blackLink.rotate(180.degrees)
            }
            .shadowColor(.white, 0.2, y: 0.4)
        }
        .scaleIfNot(scaled, 0)
        .onAppear {
            withAnimation(.easeInOut) {
                scaled = true
            }
            after(0.2) {
                withAnimation(.timingCurve(0.65, 0, 0.35, 1, duration: 1)) {
                    animated = true
                }
            }
        }
    }
}

private struct Link: View {
    
    let fromTrim: CGFloat
    let toTrim: CGFloat
    let color: Color
    
    var body: some View {
        ShazamCapsule()
            .rotate(-45.degrees)
            .offset(-7, -16)
            .trim(from: fromTrim, to: toTrim)
            .stroke(color, style: .init(lineWidth: 20, lineCap: .round))
            .frame(90, 64)
    }
}

private struct ShazamCapsule: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let arcRadius = rect.halfHeight
        
        path.move(rect.bottom)
        path.arc(rect.trailing.xOffset(-arcRadius), radius: arcRadius, startAngle: .bottom, delta: -180.degrees)
        path.arc(rect.leading.xOffset(arcRadius), radius: arcRadius, startAngle: .top, delta: -180.degrees)
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    ShazamView(vm: ContentViewModel())
}
