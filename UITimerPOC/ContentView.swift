//
//  ContentView.swift
//  UITimerPOC
//
//  Created by userext on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progressTimer: Double = 1.0
    @State private var count: Int = 10
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 15) {
                ZStack {
                    
                    Circle()
                        .fill(.white.opacity(0.03))
                        .padding(-40)
                    
                    Circle()
                        .trim(from: 0, to: progressTimer)
                        .stroke(Color.blue, lineWidth: 10)
                        .blur(radius: 15)
                        .padding(-2)
                    
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.blue, lineWidth: 10)
                        .blur(radius: 15)
                        .padding(-2)
                    
                    Circle()
                        .fill(.black)
                    
                    Circle()
                        .trim(from: 0, to: progressTimer)
                        .stroke(Color.white.opacity(0.7), lineWidth: 10)
                    ballKnobView
                }
                .padding()
                .frame(height: geometry.size.width)
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: progressTimer)
                .overlay {
                    Text("\(count)")
                        .font(.largeTitle)
                }
                .onReceive(timer) { _ in
                    progressTimer -= 0.1
                    count -= 1
                    if (progressTimer <= 0.0 || count <= 0) {
                        timer.upstream.connect().cancel()
                    }
                }
            }
        })
        .preferredColorScheme(.dark)
        .padding(50)
    }
    
    private var ballKnobView: some View {
        GeometryReader { knobGeo in
            Circle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
                .overlay(
                    Circle()
                        .fill(.white)
                        .padding(5)
                )
                .frame(
                    width: knobGeo.size.width,
                    height: knobGeo.size.height,
                    alignment: .center
                )
                .offset(x: knobGeo.size.height / 2)
                .rotationEffect(.degrees(progressTimer * 360))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
