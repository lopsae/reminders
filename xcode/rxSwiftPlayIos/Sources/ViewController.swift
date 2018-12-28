//
// rxSwiftPlaygrounds
// Copyright © 2018 LopSae. All rights reserved.
//

import UIKit

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
  }

}

