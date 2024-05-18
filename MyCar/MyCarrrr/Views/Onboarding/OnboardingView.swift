//
//  OnboardingView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 18.05.2024.
//

import Foundation
import SwiftUI
import Combine

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
    
    var currentPage: Int {
        get { Int(progress) }
        set { progress = Double(newValue) }
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
    var images: [String] = ["story1", "bmw5", "bmw5", "bmw5", "bmw5", "bmw5"]
    
    @State private var currentPage: Int = 0
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 6, interval: 4.0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(self.images[self.currentPage])
                    .resizable()
                    .padding(.top, 30)
                    .padding(.bottom, 5)
                    .padding()
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.images.indices, id: \.self) { image in
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
                            self.currentPage = self.countTimer.currentPage
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                            self.currentPage = self.countTimer.currentPage
                        }
                }
                
                if currentPage == 0 {
                    VStack{
                        Spacer()
                        Button {
                            withAnimation(.snappy) {
                                // Действия при нажатии кнопки
                            }
                        } label: {
                            VStack {
                                Text("Пропустить")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 175, height: 60)
                            .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                            .clipShape(.buttonBorder)
                        }
                    }
                }
                
                if currentPage == 5 {
                    VStack{
                        Spacer()
                        Button {
                            withAnimation(.snappy) {
                                // Действия при нажатии кнопки
                            }
                        } label: {
                            VStack {
                                Text("Добавить авто")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 175, height: 60)
                            .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                            .clipShape(.buttonBorder)
                        }
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
                self.currentPage = self.countTimer.currentPage
            }
            .onReceive(self.countTimer.$progress) { progress in
                self.currentPage = self.countTimer.currentPage
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
