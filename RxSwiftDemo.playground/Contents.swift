import UIKit
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "just, of, from") {
    let one = 1
    let two = 2
    let three = 3
    
    //: Cree un Observable contenamt juste un element
    let observable: Observable<Int> = Observable<Int>.just(one)
    
    //: Cree un Observable à partie un parametre variadique (Ici cree un observable sur une variable de type Int)
    let observable2 = Observable.of(one, two, three)
    
    //: Cree un Observable sur une variable de type [Int]
    let observable3 = Observable.of([one, two, three])
    
    /*:
        Souscrire à un Obvervable
     
        Cela ressemble à un apple a la fonction `next` sur un iterateur
     */
    
    let sequence = 0..<3
    
    var iterator = sequence.makeIterator()
    
    while let n = iterator.next() {
        print(n)
    }
}

example(of: "subcribe") {
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable.of(one, two, three)
    
    //: On souscrit à tout evennement emit par l'observable
    observable.subscribe({ (event) in
        print(event)
    })
    
    /*: Cependant lorsqu'on travaille avec les observable, on on interessé par les
        evennements qui ont une valeur (le plus souvant, l'evennement **next**)
     */
//    observable.subscribe({ (event) in
//        if let element = event.element {
//            print(element)
//        }
//    })
    
    observable.subscribe(onNext: { (element) in
        print(element)
    })
    
}
