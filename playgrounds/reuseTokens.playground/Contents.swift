

import UIKit

struct ReuseToken<Item: CellItem, View: CellView> {

    var item: Item.Type
    var source: Source<View>
    var kind: Kind
    var identifier: String

    enum Source<View: CellView> {
        case nib(name: String, bundleId: String?, type: View.Type)
        case type(View.Type)
    }

    enum Kind {
        case cell
        case supplementary(String)
    }
    
}


protocol CellItem {
    associatedtype View: CellView
    var reuseToken: ReuseToken<Self, View> { get }
}


protocol CellView {
    associatedtype Item
    func update(with item: Item)
}


struct SomeCellItem: CellItem {
    // Not required since it can be inferred from `reuseToken`
    // typealias View = SomeCellView

    var reuseToken: ReuseToken<SomeCellItem, SomeCellView> {
        return ReuseToken(
            item: SomeCellItem.self,
            source: .type(SomeCellView.self),
            kind: .cell,
            identifier: "SomeCellItem"
        )
    }
}


struct LooseCellItem: CellItem {

    var reuseToken: ReuseToken<LooseCellItem, UICollectionViewCell> {
        return ReuseToken(
            item: LooseCellItem.self,
            source: .type(UICollectionViewCell.self),
            kind: .cell,
            identifier: "LooseCellItem"
        )
    }

}


// Extension of UICollectionViewCell is required in order to use it along LooseCellItem
// TODO: how can it be done that this extension is not necesary?
// View has to loose its type constraint?
extension UICollectionViewCell: CellView {
    func update(with item: LooseCellItem) {
        print("\(UICollectionViewCell.self) updated with \(type(of: item))")
    }
}


struct SomeCellView: CellView {
    // Not required since it can be inferred from `update`
    // typealias Item = SomeCellItem

    func update(with item: SomeCellItem) {
        print("updated!")
    }
}


func register<Item, View>(token: ReuseToken<Item, View>) {
    print("registering \(token.identifier): \(token.item), \(token.source)")
}


func dequeue<Item, View>(token: ReuseToken<Item, View>) -> View{
    var cellView: Any!

    switch Item.self {
    case is SomeCellItem.Type:
        cellView = SomeCellView()
    case is LooseCellItem.Type:
        cellView = UICollectionViewCell()
    default:
        preconditionFailure()
    }

    return cellView as! View
}


let strictToken = ReuseToken(
    item: SomeCellItem.self,
    source: .type(SomeCellView.self),
    kind: .cell,
    identifier: "strictToken"
)

let looseToken = ReuseToken(
    item: LooseCellItem.self,
    source: .type(UICollectionViewCell.self),
    kind: .cell,
    identifier: "looseToken"
)


register(token: strictToken)
let strictView = dequeue(token: strictToken)
strictView.update(with: SomeCellItem())

let looseView = dequeue(token: looseToken)
looseView.update(with: LooseCellItem())


print("all good~")
