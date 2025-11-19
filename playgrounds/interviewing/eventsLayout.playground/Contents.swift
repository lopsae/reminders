//: # Event Layout
//: You receive a collection of events, each event has a start and end date.
//: Arrange all the events in a column layout, so that events are laid out vertically according to
//: their start and end time, and horizontally they split the space with conflicting events.


import PlaygroundSupport
import SwiftUI


struct ContentView: View {

    var body: some View {
        VStack {
            Text("Xcode playground")
                .padding()
            Image(systemName: "wrench.and.screwdriver")
        }
        .frame(width: 300, height: 500)
    }

}


PlaygroundPage.current.setLiveView(ContentView())
