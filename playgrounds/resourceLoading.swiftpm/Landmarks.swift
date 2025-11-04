//
//  Resource Loading
//  Created by Maic Lopez Saenz.
//

import SwiftUI


struct Landmark: Hashable, Codable, Identifiable {

    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool

    private var imageName: String

    var image: Image {
        Image(imageName)
    }


    var featuredImage: Image? {
        isFeatured ? Image("\(imageName)_feature") : nil
    }

}


extension Landmark {

    enum Category: String, Comparable, CaseIterable, Codable {

        case lakes =     "Lakes"
        case rivers =    "Rivers"
        case mountains = "Mountains"

        static func < (lhs: Landmark.Category, rhs: Landmark.Category) -> Bool {
            lhs.rawValue < rhs.rawValue
        }


        var displayName: String { rawValue }

    }

}
