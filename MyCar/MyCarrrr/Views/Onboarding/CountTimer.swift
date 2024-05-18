//
//  CountTimer.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 18.05.2024.
//

import Foundation
import Combine
import SwiftUI

class CountTimer2: ObservableObject {
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private var publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    private var isPaused: Bool = false
    
    init(items: Int, interval: TimeInterval, currentPage: Int) {
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
