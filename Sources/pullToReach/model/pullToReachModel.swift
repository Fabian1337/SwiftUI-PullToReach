//
//  File.swift
//  
//
//  Created by Veit Progl on 13.11.19.
//

import SwiftUI
import Combine
import Foundation

@available(iOS 13.0, *)
open class PullToReachModel:ObservableObject {
    @Published var offset: CGPoint
    @Published var isActive: Bool
    @Published var show: Bool
    @Published var timer = Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common).autoconnect()
    @Published var time: Date = Date()
    
    var queue: DispatchQueue
    var source: PassthroughSubject<Int, Never>
//    var subscription: AnyCancellable
//    var cancellable: Cancellable
    @Published var counter: Int
    
    
    init(offset: CGPoint, isActive: Bool, show: Bool) {
        self.offset = offset
        self.isActive = isActive
        self.show = show
        
        self.queue = DispatchQueue.main
        self.source = PassthroughSubject<Int, Never>()
        self.counter = 0
        
//        self.cancellable =
        self.queue.schedule(
            after: self.queue.now,
          interval: .seconds(1)
        ) {
            self.source.send(self.counter)
            self.counter += 1
        }
        
//        self.subscription = self.source.sink {
//          print("Timer emitted \($0)")
//        }
    }
}

@available(iOS 13.0.0, *)
struct Run: View {
    let block: () -> Void

    var body: some View {
        DispatchQueue.main.async(execute: block)
        return AnyView(EmptyView())
    }
}
