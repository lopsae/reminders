//: in Swift 4
print("⭕️ StateMachine playground")


enum State {
  case possible, ended, failed, idle
}

enum Event {
  case firstTouch, endedEvent, failedEvent
}

enum EventGroup {
  case none
  case some(Set<Event>)
  case all
  case rest
}

struct Transformation {
  let source: State
  let end: State
  let transitionEvents: EventGroup
  let ignoredEvents: EventGroup
  let warningEvents: EventGroup
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

//  func feed(Event: Event)
}

Machine(
  resetState: .idle,
  allStates: [.idle, .possible, .ended, .failed],
  alEvents: [.firstTouch, .endedEvent, .failedEvent],
  transformations: [
    Transformation(
      source: .idle,
      end: .possible,
      transitionEvents: .some([.firstTouch]),
      ignoredEvents: .none,
      warningEvents: .rest
    ),
    Transformation(
      source: .possible,
      end: .ended,
      transitionEvents: .some([.endedEvent]),
      ignoredEvents: .none,
      warningEvents: .rest
    ),
    Transformation(
      source: .possible,
      end: .failed,
      transitionEvents: .some([.firstTouch]),
      ignoredEvents: .none,
      warningEvents: .rest
    )
  ]
)


print("👑 finis coronat opus~")

