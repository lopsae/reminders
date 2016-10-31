//: for Swift 3

import UIKit

class TestClass {
    func test() -> String {
        return "tested!"
    }
}

// Seems like as long as the optionals are casted as `Optional<Any>
// any number of them can be stacked and the `is` and `as` operators will work
// properly. All the bellow can successfully cast to `TestClass`

let singleOptional: Any? = Optional<Any>.some(TestClass())
singleOptional.debugDescription
type(of: singleOptional)
singleOptional is TestClass
(singleOptional as? TestClass)?.test() // tested!

let doubleOptional: Any? = Optional<Any>.some(Optional<Any>.some(TestClass()))
doubleOptional.debugDescription
type(of: doubleOptional)
doubleOptional is TestClass
(doubleOptional as? TestClass)?.test() // tested!

let tripleOptional: Any? = Optional<Any>.some(Optional<Any>.some(Optional<Any>.some(TestClass())))
tripleOptional.debugDescription
type(of: tripleOptional)
tripleOptional is TestClass
(tripleOptional as? TestClass)?.test() // tested!

let quadOptional: Any? = Optional<Any>.some(Optional<Any>.some(Optional<Any>.some(Optional<Any>.some(TestClass()))))
quadOptional.debugDescription
type(of: quadOptional)
quadOptional is TestClass
(quadOptional as? TestClass)?.test() // tested!


// Previously with infered types, casting did not worked. Now it does.

let typedDoubleOptional: Any? = Optional.some(Optional.some(TestClass()))
typedDoubleOptional.debugDescription
type(of: typedDoubleOptional)
type(of: typedDoubleOptional!)
typedDoubleOptional is TestClass
(typedDoubleOptional as? TestClass)?.test() // tested!

// With three levels, casting still works

let typedTripleOptional: Any? = Optional.some(Optional.some(Optional.some(TestClass())))
typedTripleOptional.debugDescription
type(of: typedTripleOptional)
type(of: typedTripleOptional!)
typedTripleOptional is TestClass
(typedTripleOptional as? TestClass)?.test() // tested!
(typedTripleOptional! as? TestClass)?.test() // tested!
(typedTripleOptional! as! TestClass).test() // tested!

// Testing agains `Optional<TestClass>` yields true and works

typedDoubleOptional is Optional<TestClass> // true
(typedDoubleOptional as? Optional<TestClass>)??.test() // tested! tho the `??` almost nonsense
(typedDoubleOptional as! Optional<TestClass>)?.test() // tested! `as!`
typedTripleOptional is Optional<TestClass> // true
(typedTripleOptional as? Optional<TestClass>)??.test() // tested!

type(of: (typedTripleOptional as? Optional<TestClass>)) // Optional<Optional<Any>>


// Of curious note is that `!!` cannot be used with Optional<Any>, since when it
// unwraps with `!` a `Any` is retrieved, and that cannot be unwrapped
// Type is resported properly, but when considering it as `Any` its not unwrappable

type(of: typedDoubleOptional!) // Optional<TestClass>
//type(of: typedDoubleOptional!!) // cannot force unwrap value of non-optional type 'Any'

// Another curious note, seems like checking for `Optional<Any>` will yield true
// with both `Any` and `Optional<Any>`. The `is` operator does some optional
// magic in here.

typedDoubleOptional is Optional<Any>
typedDoubleOptional! is Optional<Any>
typedDoubleOptional is Any
typedDoubleOptional! is Any

// In this cases, casting an `Any` to `Optional<Any>` and viceversa
// does some magic wrapping and unwrapping.
let simpleAny: Any = "simple"
simpleAny is Any
simpleAny is Optional<Any>
(simpleAny as? Optional<Any>)!

// But casting towards an typed optional from an any just cannot be done...
// All following fail

//typedDoubleOptional! as? Optional<TestClass> // Cannot downcast Any to more optional type...
//simpleAny as? Optional<String> // Cannot downcast Any to more optional type...


// Types can be actually checked with `==` and `type(of:)`, but still this does not help
// with casting those into their proper optionals

type(of: typedDoubleOptional) == Optional<Any>.self // true
type(of: typedDoubleOptional) == Optional<TestClass>.self // false

type(of: typedDoubleOptional!) == Optional<Any>.self // false
type(of: typedDoubleOptional!) == Optional<TestClass>.self // true



/*
 In conclusion:
 + Casting cannot be done to from `Any` to `Optional<typed>` since the
   wrap/unwrap behaviour with the `as` seems to disallow it.
 + Using the `as` operator will try to unwrap optionals, and rewrap them
   if casting to another optional. This automatic behaviour up the casting.
 + Casting using the `as` operator needs the right side to be available at
   runtime, which disallows storying `Type`s in variables for runtime casting.
*/

