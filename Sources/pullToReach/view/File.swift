//
//  File.swift
//
//
//  Created by Veit Progl on 16.11.19.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct pullToReach<Content>: View where Content: View {
    let content: () -> Content
    @ObservedObject var pullToReach = PullToReachModel(offset: .zero, isActive: false, show: false)
    @State private var print: String = "22"


    init(
        hasButton: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    var body: some View {
        NavigationView() {
            GeometryReader { proxy in
                List(0..<8) { index in
                    if index == 1 {
                        VStack() {
                            GeometryReader { geometry in
                                PullToReach(model: self.pullToReach, geometry: geometry)
                            }

                            VStack() {
                                Text("\(self.pullToReach.offset.y)")
                            }
                        }
                    } else {
                        VStack() {
                            Text("Index: \(index)")
                                .background(self.pullToReach.isActive ? Color.red : Color.blue)
                            Text("\(self.pullToReach.time)")
                        }
                    }
                }
            }.onAppear( perform: {
                self.pullToReach.show = false
            })
            .sheet(isPresented: $pullToReach.show,
                onDismiss: {
//                    print("finished!")
                },
                content: { testAddView() })
        }
    }
}
