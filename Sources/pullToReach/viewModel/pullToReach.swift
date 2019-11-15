//
//  pullToReach.swift
//  
//
//  Created by Veit Progl on 13.11.19.
//

import SwiftUI
import Combine
import Foundation

@available(iOS 13.0, *)
public class PullToReach: View {
    var geometry: GeometryProxy
    
    /// load model (shard objects)
    @ObservedObject var model: PullToReachModel
    
    /// The initial offset in the global frame, used for calculating the relative offset
    @State private var initialOffset: CGPoint? = nil
    
    /// The offset of the scrollview updated as the scroll view scrolls
    @State private var maxOffset: CGPoint = .zero
    
    /// The time
    @State private var timerHold: Date = Date()
    
    
    @State private var counter = 0
    
    
//    var queue: DispatchQueue
//    var source: PassthroughSubject<Int, Never>
    
    @State var printF = "eee"
    
    var body: some View {
        VStack() {
            Run {
                let globalOrigin = self.geometry.frame(in: .global).origin
                self.initialOffset = self.initialOffset ?? globalOrigin
                let initialOffset = (self.initialOffset ?? .zero)
                let offset = CGPoint(x: round(globalOrigin.x - initialOffset.x), y: round(globalOrigin.y - initialOffset.y))

                if self.model.offset.y != offset.y {
                    self.model.offset = offset
                }

                if self.model.offset.y <= 0.4 {
                    self.maxOffset = .zero
                }

                if offset.y > self.maxOffset.y {
                    self.maxOffset = offset
                    self.timerHold = self.model.time
                    self.model.isActive = false
                }

                if round(self.model.time.distance(to: self.timerHold)) <= -2 && self.model.offset.y >= 50 {
                    self.model.isActive = true
                }

                if self.model.isActive == true && self.model.offset.y <= 3 && self.model.offset.y >= 5 {
                    self.timerHold = self.model.time
                }

                if self.model.isActive == true && round(self.model.time.distance(to: self.timerHold)) <= -1 && self.model.offset.y <= 0.4 {
                    self.model.isActive = false
                    self.model.show = true
                }
            }
            Text("w").frame(width: 0, height: 0)
                .onReceive(self.model.timer) { (date) in
                self.model.time = date
            }
//            Text("\(self.model.counter)").onReceive(self.model.source) {
//                print("Timer emitted \($0)")
//            }
        }
    }
}
