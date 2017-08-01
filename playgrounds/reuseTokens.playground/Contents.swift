

import UIKit

struct ReuseToken<Item: CellItem, View: CellView> {

	// item exists to use type inference
	// TODO: could it be removed? how would it infer it?
	// TODO: item is missing what is lost? auto identifier with String(Item.self)?
	var item: Item.Type

	var source: Source<View>
	var kind: Kind

	// indentifier has been though to always be related to Kind, so
	// an option could be to include identifier in Kind.
	// However this would remove the option of layouts to provide
	// their supplementary kinds of the specific cells these handled
	// which does not require the identifier
	// removal of supplementary views from a sections collection also
	// seems cleaner without the indentifier
	// For now it remains outside
	var identifier: String

}


extension ReuseToken {

	enum Source<View: CellView> {
		case nib(type: View.Type, name: String, bundleId: String?)
		case type(View.Type)
	}

	enum Kind {
		case cell
		case supplementary(id: String)
	}

}


protocol CellItem {
	associatedtype View: CellView
	var reuseToken: ReuseToken<Self, View> { get }
}


// Caveat: not all CellItems are for `.cell`
// TODO: maybe this would be better as an children of CellItem?
extension CellItem {
	static var cellReuseToken: ReuseToken<Self, View> {
		return ReuseToken(
			item: Self.self,
			source: .type(View.self),
			kind: .cell,
			identifier: String(describing: Self.self)
		)
	}
}


protocol CellView {
	// TODO: why is item not :CellItem?
	associatedtype Item
	func update(with item: Item)
}


// CellItem that uses a cellView extending CellView, which means that `update` can be called
// in the views returned by dequeue
struct StrictCellItem: CellItem {
	// associatedtype not required, inferred through `reuseToken`
	// typealias View = StrictCellView

	var reuseToken: ReuseToken<StrictCellItem, StrictCellView> {
		return type(of: self).cellReuseToken
	}

}


struct StrictCellView: CellView {
	// associatedtype not required, inferred through `update`
	// typealias Item = StrictCellItem

	func update(with item: StrictCellItem) {
		print("\(StrictCellView.self) updated with \(type(of: item))")
	}

}


// Intended to be a CellItem that uses a cellView that does not extend CellView
// which means that the cellView can still be instantiated but it is not updated
// automatically.
// TODO: still figuring out how this can work
// important so that the model can be used with previously existing clases like UICollectionViewCell
struct LooseCellItem: CellItem {

	var reuseToken: ReuseToken<LooseCellItem, UICollectionViewCell> {
		return type(of: self).cellReuseToken
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



func register<Item, View>(token: ReuseToken<Item, View>) {
	print("register reuseid:\(token.identifier) item:\(token.item), source:\(token.source)")
}


func dequeue<Item, View>(token: ReuseToken<Item, View>) -> View{
	var cellView: Any!

	// Fake dequeue, this are the tokens supposedly registered
	// TODO: actually matching by reuseId not done yet
	switch Item.self {
	case is StrictCellItem.Type:
		cellView = StrictCellView()
	case is LooseCellItem.Type:
		cellView = UICollectionViewCell()
	default:
		preconditionFailure("token not registered")
	}

	return cellView as! View
}


let strictToken = ReuseToken(
	item: StrictCellItem.self,
	source: .type(StrictCellView.self),
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
strictView.update(with: StrictCellItem())

// As desired `update` is not possible due to type safety
// following will break!
// strictView.update(with: LooseCellItem())

let looseView = dequeue(token: looseToken)
looseView.update(with: LooseCellItem())

// As desired `update` is not possible due to type safety
// following will break!
// looseView.update(with: StrictCellItem())


print("\n" + "all good~")

