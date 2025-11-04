// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation


public struct LandmarkResource {

    public static func getLandmarkData() throws -> Data {
        guard let fileUrl = Bundle.module.url(forResource: "packageLandmarkData", withExtension: "json")
        else {
            fatalError("Couldn't find landmarkData in main bundle.")
        }

        return  try Data(contentsOf: fileUrl)
    }

}
