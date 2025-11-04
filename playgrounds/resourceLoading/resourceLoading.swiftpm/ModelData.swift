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
//    var landmarks: [Landmark] = load("localLandmarkData.json")

}


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
