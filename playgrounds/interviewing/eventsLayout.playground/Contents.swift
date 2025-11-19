//: # Event Layout
//: You receive a collection of events, each event has a start and end date.
//: Arrange all the events in a column layout, so that events are laid out vertically according to
//: their start and end time, and horizontally they split the space with conflicting events.


import PlaygroundSupport

import Foundation
import SwiftUI


struct Event {
    let color: Color
    /// Offset from the start of the day/column when the event starts.
    let start: Double
    /// Offset from the start of the day/column when the event ends.
    let end: Double
}


let events: [Event] = [
    Event(color: .purple, start: 0.0, end: 3.0),
    Event(color: .orange, start: 4.0, end: 6.0),
    Event(color: .yellow, start: 5.0, end: 7.0),
    Event(color: .blue,   start: 8.0, end: 9.0),
    Event(color: .teal,   start: 10.0, end: 12.0)
]


func arrangeEvents(_ events: [Event]) -> [[Event]] {
    let sortedEvents = events.sorted { $0.start < $1.start }

    var arrangedEvents: [[Event]] = []

//    var lastEvent: Event?
    var eventGroup: [Event] = []
    for event in sortedEvents {
        guard let lastEvent = eventGroup.last else {
            // First case, populate group with first event
            eventGroup = [event]
            continue
        }

        // Check for colission
        if lastEvent.end >= event.start {
            // Colission, add to group
            eventGroup.append(event)
        } else {
            // No colission, store group and restart
            arrangedEvents.append(eventGroup)
            eventGroup = [event]
        }
    }

    arrangedEvents.append(eventGroup)

    return arrangedEvents
}


let arrangedEvents = arrangeEvents(events)



struct EventsView: View {
    let events: [Event]
    let start: Double
    let end: Double


    init(_ events: [Event], start: Double, end: Double) {
        self.events = events
        self.start = start
        self.end = end
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // To expand the size of the stack
            Rectangle()
                .fill(.clear)
            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .offset(x: 0, y: 0)
            Rectangle()
                .fill(.orange)
                .frame(width: 100, height: 100)
                .offset(x: 10, y: 10)
            Text("Sphinx of black quartz")
        }
        .frame(width: 300, height: 500)

    }

}


PlaygroundPage.current.setLiveView(EventsView(events, start: 0.0, end: 16.0))
