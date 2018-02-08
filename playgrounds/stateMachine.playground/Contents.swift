//: in Swift 4
print("⭕️ StateMachine playground")


enum DummyState: MachineState {
  case possible, ended, failed, idle
}

enum DummyEvent: MachineEvent {
  case firstTouch, endedEvent, failedEvent
}


class Machine<State: MachineState, Event: MachineEvent> {

  let resetState: State
  let transitions: [Transition]

  private(set) var currentState: State

  var validTransitionHandler: ((State) -> Void)?
  var invalidTransitionHandler: ((State, Event) -> Void)?


  init (
    resetState: State,
    transitions: Transition...
  ) {
    self.resetState = resetState
    self.transitions = transitions

    currentState = resetState
  }


  /// Returns true if successful
  func transition(event: Event) -> Bool {
    let sourceTransitions = transitions.filter {
      $0.sources.contains(currentState)
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


protocol MachineStateType {}
protocol MachineState: Hashable, MachineStateType {}

protocol MachineEventType {}
protocol MachineEvent: Hashable, MachineEventType {}


extension Machine {
  struct Transition {
    let sources: Set<State>
    let result: State
    let events: Set<Event>

    init(
      from sources: Set<State>,
      to result: State,
      with events: Set<Event>
    ) {
      self.sources = sources
      self.result = result
      self.events = events
    }

    init(
      from source: State,
      to result: State,
      with event: Event
    ) {
      self.sources = [source]
      self.result = result
      self.events = [event]
    }
  }
}


func > <State: MachineState, Event: MachineEvent> (
  sourceAndEvent: (State, Event),
  result: State
) -> Machine<State, Event>.Transition {
  let (source, event) = sourceAndEvent
  return Machine<State, Event>.Transition(from: source, to: result, with: event)
}


func + <State: MachineState, Event: MachineEvent> (
  source: State,
  event: Event
) -> (State, Event) {
  return (source, event)
}

DummyState.idle + DummyEvent.firstTouch
DummyState.idle + DummyEvent.firstTouch > DummyState.possible


//==============================================================================
//==============================================================================
//==============================================================================


let machine = Machine<DummyState, DummyEvent>(
  resetState: .idle,
  transitions:
  .idle     + .firstTouch  > .possible,
  .possible + .endedEvent  > .ended,
  .possible + .failedEvent > .failed
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

