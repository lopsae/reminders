

import UIKit


struct ReuseToken<Item, View> {

    var item: Item.Type
    var source: Source<View>
    var kind: Kind
    var identifier: String

    enum Source<View> {
        case nib(name: String, bundleId: String?, type: View.Type)
        case type(View.Type)
    }

    enum Kind {
        case cell
        case supplementary(String)
    }
    
}


protocol CellItem {
    associatedtype View
    var reuseToken: ReuseToken<Self, View> { get }
}


protocol CellView {
    associatedtype Item
    func update(with item: Item)
}


struct SomeCellItem: CellItem {
    typealias Item = SomeCellItem
    typealias View = SomeCellView

    var reuseToken: ReuseToken<Item, View> {
        return ReuseToken(
            item: SomeCellItem.self,
            source: .type(SomeCellView.self),
            kind: .cell,
            identifier: "identifier"
        )
    }
}


struct SomeCellView: CellView {
    typealias Item = SomeCellItem

    func update(with item: SomeCellItem) {
        print("updated!")
    }
}


func register<Item, View>(token: ReuseToken<Item, View>) {
    print("registering \(token.identifier): \(token.item), \(token.source)")
}


func dequeue<Item, View>(token: ReuseToken<Item, View>) -> View {
    let cellView = SomeCellView()
    return cellView as! View
}


let token = ReuseToken(
    item: SomeCellItem.self,
    source: .type(SomeCellView.self),
    kind: .cell,
    identifier: "testToken"
)


register(token: token)
let view = dequeue(token: token)
view.update(with: SomeCellItem())


print("all good~")