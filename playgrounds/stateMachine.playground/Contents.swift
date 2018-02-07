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

struct Transition {
  let source: State
  let events: Set<Event>
  let result: State

  init(
    from source: State,
    with events: Set<Event>,
    to result: State
  ) {
    self.source = source
    self.events = events
    self.result = result
  }
}

class Machine {

  init (
    resetState: State,
    allStates: Set<State>,
    alEvents: Set<Event>,
    transformations: [Transition]
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
  let transformations: [Transition]

  private(set) var currentState: State

  /// Returns true if successful
  func feed(event: Event) -> Bool {
    let possibleTransformations = transformations.filter {
      $0.source == currentState
    }
    let transformation = possibleTransformations.first {
      $0.events.contains(event)
    }

    guard transformation != nil else {
      // no availble transformation for this state/event
      return false
    }

    currentState = transformation!.result
    return true
  }
}

let machine = Machine(
  resetState: .idle,
  allStates: [.idle, .possible, .ended, .failed],
  alEvents: [.firstTouch, .endedEvent, .failedEvent],
  transformations: [
    Transition(
      from: .idle,
      with: [.firstTouch],
      to: .possible
    ),
    Transition(
      from: .possible,
      with: [.endedEvent],
      to: .ended
    ),
    Transition(
      from: .possible,
      with: [.firstTouch],
      to: .failed
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

