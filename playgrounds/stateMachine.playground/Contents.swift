//: in Swift 4
print("⭕️ StateMachine playground")


enum DummyState {
  case possible, ended, failed, idle
}

enum DummyEvent {
  case firstTouch, endedEvent, failedEvent
}


class Machine<State: Hashable, Event: Hashable> {

  let resetState: State
  let transitions: [Transition<State, Event>]

  private(set) var currentState: State

  var validTransitionHandler: ((State) -> Void)?
  var invalidTransitionHandler: ((State, Event) -> Void)?


  init (
    resetState: State,
    transitions: [Transition<State, Event>]
    ) {
    self.resetState = resetState
    self.transitions = transitions

    currentState = resetState
  }


  /// Returns true if successful
  func transition(event: Event) -> Bool {
    let sourceTransitions = transitions.filter {
      $0.source.contains(currentState)
    }
    let eventTransition = sourceTransitions.first {
      $0.events.contains(event)
    }

    guard eventTransition != nil else {
      // no availble transformation for this state/event
      invalidTransitionHandler?(currentState, event)
      return false
    }

    currentState = eventTransition!.result
    validTransitionHandler?(currentState)
    return true
  }


  func reset() {
    currentState = resetState
  }
}


extension Machine {
  struct Transition<State: Hashable, Event: Hashable> {
    let source: Set<State>
    let result: State
    let events: Set<Event>

    init(
      from source: Set<State>,
      to result: State,
      with events: Set<Event>
      ) {
      self.source = source
      self.events = events
      self.result = result
    }
  }
}






//==============================================================================
//==============================================================================
//==============================================================================


let machine = Machine<DummyState, DummyEvent>(
  resetState: .idle,
  transitions:
  // .idle + .firstTouch => .possible
  [
    Machine.Transition(
      from: [.idle],
      to: .possible,
      with: [.firstTouch]
    ),
    Machine.Transition(
      from: [.possible],
      to: .ended,
      with: [.endedEvent]
    ),
    Machine.Transition(
      from: [.possible],
      to: .failed,
      with: [.firstTouch]
    )
  ]
)

machine.validTransitionHandler = {
  state in
  print("transitioned to \(state)")
}

machine.invalidTransitionHandler = {
  state, event in
  print("invalid transition from:\(state) with:\(event)")
}


machine.transition(event: .firstTouch)
machine.transition(event: .endedEvent)
machine.transition(event: .failedEvent)
machine.transition(event: .firstTouch)
machine.reset()
machine.transition(event: .endedEvent)
machine.transition(event: .firstTouch)




print("👑 finis coronat opus~")

