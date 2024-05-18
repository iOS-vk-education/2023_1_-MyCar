//
//  OnboardingView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 18.05.2024.
//

import Foundation
import SwiftUI
import Combine

struct LoadingBar: View {
    
    var progress:CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.leading){
                Rectangle()
                    .foregroundColor(Color.red.opacity(0.5))
                    .cornerRadius(5)
                Rectangle().frame(width: geometry.size.width * self.progress,height: 10,alignment: .leading)
                    .foregroundColor(.blue)
                    .cornerRadius(5)
            }
        }
    }
}

class CountTimer: ObservableObject {
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private var publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    private var isPaused: Bool = false
    
    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
    
    func start() {
        guard !isPaused else { return }
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: { _ in
            var newProgress = self.progress + (0.1 / self.interval)
            if Int(newProgress) >= self.max { newProgress = 0 }
            self.progress = newProgress
        })
    }
    
    func pause() {
        self.cancellable?.cancel()
        self.cancellable = nil
        self.isPaused = true
    }
    
    func resume() {
        self.isPaused = false
        self.start()
    }
    
    func advancePage(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % self.max, 0)
        self.progress = Double(newProgress)
    }
}


struct ContentView: View {
    var images: [String] = ["story1", "bmw5"]
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 2, interval: 4.0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(self.images[Int(self.countTimer.progress)])
                    .resizable()
                    .padding(.top, 30)
                    .padding(.bottom, 5)
                    .padding()
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.images.indices) { image in
                        LoadingBar(progress: min(max(CGFloat(self.countTimer.progress) - CGFloat(image), 0.0), 1.0))
                            .frame(width: nil, height: 2, alignment: .leading)
                            .animation(.linear)
                    }
                }
                .padding()
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: -1)
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                        }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        self.countTimer.pause()
                    }
                    .onEnded { _ in
                        self.countTimer.resume()
                    }
            )
            .onAppear {
                self.countTimer.start()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
