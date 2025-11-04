//
//  Resource Loading
//  Created by Maic Lopez Saenz.
//


import Foundation
import ResourcesPackage
import UIKit


@Observable
class ModelData {

    var landmarksFromResourcesPackage: [Landmark] = loadFromResourcePackage()
    var landmarksFromAssetsCatalog: [Landmark] = loadFromAssetsCatalog()
    var landmarksFromTargetResources: [Landmark] = load("targetLandmarkData.json")

}


// To read from target resources, the resources files or folders have to be manually added to the
// App Playground `Package.swift` file, which can be accessed through Finder. Xcode does not provide
// access to the `Package.swift` file, but it seems to respect the manual changes done there.
func load<D: Decodable>(_ filename: String) -> D {
    // Files in Assets.xcassets catalog cannot be read using Bundle.url
    guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    let data: Data
    do {
        data = try Data(contentsOf: fileUrl)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(D.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(D.self):\n\(error)")
    }
}


// To read from the Assets Catalog the asset has to be retrieved using `NSDataAsset` to access its
// data.
func loadFromAssetsCatalog<D: Decodable>() -> D {
    guard let dataAsset = NSDataAsset(name: "assetsLandmarkData", bundle: .main)
    else {
        fatalError("Couldn't find assetsLandmarkData in the Assets catlog of the main bundle.")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(D.self, from: dataAsset.data)
    } catch {
        fatalError("Couldn't parse assetsLandmarkData from Assets catalog as \(D.self):\n\(error)")
    }
}


// To read from a Package Dependency use the APIs defined by the package. Internally in the Package
// the read is the same as reading from the target resources.
func loadFromResourcePackage<D: Decodable>() -> D {

    let data: Data
    do {
        data = try LandmarkResource.getLandmarkData()
    } catch {
        fatalError("Couldn't load models from LandmarkResource bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(D.self, from: data)
    } catch {
        fatalError("Couldn't parse models as \(D.self):\n\(error)")
    }
}
