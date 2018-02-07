//: in Swift 4
print("⭕️ StateMachine playground")


enum State {
  case possible, ended, failed, idle
}

enum Event {
  case firstTouch, endedEvent, failedEvent
}

//enum EventGroup {
//  case none
//  case some(Set<Event>)
//  case all
//  case rest
//}

struct Transformation {
  let source: State
  let end: State
  let transitionEvents: Set<Event>
}

class Machine {

  init (
    resetState: State,
    allStates: Set<State>,
    alEvents: Set<Event>,
    transformations: [Transformation]
  ) {
    self.resetState = resetState
    self.allStates = allStates
    self.alEvents = alEvents
    self.transformations = transformations

    currentState = resetState
  }

  let resetState: State
  let allStates: Set<State>
  let alEvents: Set<Event>
  let transformations: [Transformation]

  private(set) var currentState: State

  /// Returns true if successful
  func feed(event: Event) -> Bool {
    let possibleTransformations = transformations.filter {
      $0.source == currentState
    }
    let transformation = possibleTransformations.first {
      $0.transitionEvents.contains(event)
    }

    guard transformation != nil else {
      // no availble transformation for this state/event
      return false
    }

    currentState = transformation!.end
    return true
  }
}

let machine = Machine(
  resetState: .idle,
  allStates: [.idle, .possible, .ended, .failed],
  alEvents: [.firstTouch, .endedEvent, .failedEvent],
  transformations: [
    Transformation(
      source: .idle,
      end: .possible,
      transitionEvents: [.firstTouch]
    ),
    Transformation(
      source: .possible,
      end: .ended,
      transitionEvents: [.endedEvent]
    ),
    Transformation(
      source: .possible,
      end: .failed,
      transitionEvents: [.firstTouch]
    )
  ]
)


machine.currentState
machine.feed(event: .firstTouch)
machine.currentState
machine.feed(event: .endedEvent)
machine.currentState
machine.feed(event: .failedEvent)
machine.currentState
machine.feed(event: .firstTouch)
machine.currentState





print("👑 finis coronat opus~")

