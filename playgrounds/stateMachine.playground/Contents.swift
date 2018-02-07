//: in Swift 4
print("⭕️ StateMachine playground")


enum State {
  case possible, ended, failed, idle
}

enum Action {
  case firstTouch, endedEvent, failedEvent
}

enum ActionGroup {
  case none
  case some(Set<Action>)
  case all
  case rest
}

struct Transformation {
  let source: State
  let end: State
  let transitionActions: ActionGroup
  let ignoredActions: ActionGroup
  let warningActions: ActionGroup
}

class Machine {

  init (
    resetState: State,
    allStates: Set<State>,
    allActions: Set<Action>,
    transformations: [Transformation]
  ) {
    self.resetState = resetState
    self.allStates = allStates
    self.allActions = allActions
    self.transformations = transformations

    currentState = resetState
  }

  let resetState: State
  let allStates: Set<State>
  let allActions: Set<Action>
  let transformations: [Transformation]

  private(set) var currentState: State
}

Machine(
  resetState: .idle,
  allStates: [.idle, .possible, .ended, .failed],
  allActions: [.firstTouch, .endedEvent, .failedEvent],
  transformations: [
    Transformation(
      source: .idle,
      end: .possible,
      transitionActions: .some([.firstTouch]),
      ignoredActions: .none,
      warningActions: .rest
    ),
    Transformation(
      source: .possible,
      end: .ended,
      transitionActions: .some([.endedEvent]),
      ignoredActions: .none,
      warningActions: .rest
    ),
    Transformation(
      source: .possible,
      end: .failed,
      transitionActions: .some([.firstTouch]),
      ignoredActions: .none,
      warningActions: .rest
    )
  ]
)


print("👑 finis coronat opus~")

