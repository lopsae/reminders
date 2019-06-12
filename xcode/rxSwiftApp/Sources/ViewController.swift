//
// rxSwiftPlaygrounds
// Copyright © 2018 LopSae. All rights reserved.
//


import RxSwift


class ViewController: UIViewController {

  let disposeBag = DisposeBag()

  init() {
    super.init(nibName: nil, bundle: nil)
  }


  @available(*, unavailable)
  convenience required init?(coder: NSCoder) {
    fatalError("\(#function) is not available")
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .orange

    _ = Observable.just("rxSwift 👑").subscribe(onNext: {
      print($0)
    })

    Observable.from([1, 2, 3]).map { int -> String in
      switch int {
      case 1: return "one"
      case 2: throw InvalidMap()
      case 3: return "tree"
      default: return "other"
      }
    }
    .subscribe(
      onNext: {
        print("next: \($0)")
      },
      onError: {
        print("error: \($0)")
      }
    ).disposed(by: disposeBag)
  }

  struct InvalidMap: Error {}

}

