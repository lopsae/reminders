//
//  UIinKit
//

import UIKit
import SwiftUI

class InitialViewController: UIViewController {

    struct TestView: View {
        var scale: CGFloat!
        var bounds: CGRect!
        var identifier: String!
        var version: String!

        var body: some View {
            VStack(alignment: .center, spacing: 10) {
                Text("🛠").font(.headline)
                Text("InitialViewController")
                Text("screen.scale: \(scale)")
                Text("screen.bounds: \(bounds.width),\(bounds.height)")
                Text("Model identifier: \(identifier)")
                Text("System version: \(version)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
    }


}

