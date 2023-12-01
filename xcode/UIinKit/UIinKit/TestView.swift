//
//  TestView.swift
//  UIinKit
//
//  Created by Maic Lopez Saenz on 9/21/22.
//


import SwiftUI


struct TestView: View {
    var scale: CGFloat!
    var bounds: CGRect!
    var identifier: String!
    var version: String!

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("🛠")
            Text("TestView").font(.headline)
            Text("screen.scale: \(scale)")
            Text("screen.bounds: \(bounds.width),\(bounds.height)")
            Text("Model identifier: \(identifier)")
            Text("System version: \(version)")
        }
    }
}

