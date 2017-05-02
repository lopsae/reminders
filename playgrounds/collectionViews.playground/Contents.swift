
import PlaygroundSupport
import UIKit


let layout = UICollectionViewFlowLayout()
layout.minimumInteritemSpacing = 10
layout.minimumLineSpacing = 10

let liveView = CollectionViewController(
    collectionViewLayout: layout
)

// Default size for controllers: 375 x 668
PlaygroundPage.current.liveView = liveView

