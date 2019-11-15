import SwiftUI
import Combine

@available(iOS 13.0, *)
struct pullToReachExample: View {
    @ObservedObject var pullToReach = PullToReachModel(offset: .zero, isActive: false, show: false)
    
    var body: some View {
        NavigationView() {

            GeometryReader { proxy in
//                PullToReach(geometry: proxy, model: self.pullToReach, queue: queue, source: source, cancellable: })
//                PullToReach(geometry: proxy, model: self.pullToReach )
            /*
             
             queue.schedule(after: queue.now, interval: .seconds(1)) {
                 source.send(counter)
                 counter = counter + 1
             }
             
             */
                List(0..<8) { index in
                    if index == 1 {
                        VStack() {
                            GeometryReader { geometry in
                                PullToReach(model: self.pullToReach, geometry: geometry)

                            }
    //                                    .frame(width: 0, height: 0)

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
                        print("finished!")
                    },
                    content: { testAddView() })
        }
    }
}

@available(iOS 13.0, *)
struct testAddView: View {
    var body: some View {
        Text("ee")
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group() {
            pullToReachExample()
        }
    }
}
