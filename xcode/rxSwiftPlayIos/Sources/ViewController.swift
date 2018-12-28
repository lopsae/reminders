//
// rxSwiftPlaygrounds
// Copyright © 2018 LopSae. All rights reserved.
//


import RxSwift


class ViewController: UIViewController {

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
  }

}

