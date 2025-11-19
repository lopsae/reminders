//: # Event Layout
//: You receive a collection of events, each event has a start and end date.
//: Arrange all the events in a column layout, so that events are laid out vertically according to
//: their start and end time, and horizontally they split the space with conflicting events.


import PlaygroundSupport

import Foundation
import SwiftUI


struct Event {
    let id = UUID()

    let color: Color
    /// Offset from the start of the day/column when the event starts.
    let start: Double
    /// Offset from the start of the day/column when the event ends.
    let end: Double
}


// TODO: current arrangement shows issues with the purple events!
let events: [Event] = [
    Event(color: .green,  start: 1.0, end: 3.0),
    Event(color: .orange, start: 4.0, end: 6.0),
    Event(color: .yellow, start: 5.0, end: 7.0),
    Event(color: .pink,   start: 6.5, end: 10.0),
    Event(color: .purple, start: 8.0, end: 8.5),
    Event(color: .purple, start: 9.0, end: 9.5),
    Event(color: .blue,   start: 12.0, end: 13.0),
    Event(color: .teal,   start: 13.0, end: 14.0)
]


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
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // To expand the size of the stack
                Rectangle()
                    .fill(.teal.tertiary)
                    .strokeBorder(.teal, lineWidth: 2)
                    .opacity(.zero)

                let eventsRects = calculateEventsRects(containerSize: geometry.size)
                ForEach(eventsRects, id: \.event.id) { tuple in
                    Rectangle()
                        .fill(tuple.event.color)
                        .frame(width: tuple.rect.width, height: tuple.rect.height)
                        .offset(x: tuple.rect.minX, y: tuple.rect.minY)
                }
            }
        }
        .frame(width: 300, height: 500)
    }


    var arrangedEvents: [[Event]] {
        let sortedEvents = events.sorted { $0.start < $1.start }

        var arrangedEvents: [[Event]] = []

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


    func calculateEventsRects(containerSize: CGSize) -> [(event: Event, rect: CGRect)] {
        var result: [(event: Event, rect: CGRect)] = []

        let dateDelta: Double = end - start
        let heightPerDateUnit: Double = containerSize.height / dateDelta

        for eventGroup in arrangedEvents {
            for (index, event) in eventGroup.enumerated() {
                let width: Double = containerSize.width / Double(eventGroup.count)
                let height: Double = heightPerDateUnit * (event.end - event.start)
                let originX: Double = width * Double(index)
                let originY: Double = heightPerDateUnit * (event.start - start)
                let rect: CGRect = CGRect(
                    x: originX,
                    y: CGFloat(originY),
                    width: CGFloat(width),
                    height: CGFloat(height)
                )
                result.append((event: event, rect: rect))
            }
        }

        return result
    }

}


PlaygroundPage.current.setLiveView(EventsView(events, start: 0.0, end: 16.0))
