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

//: L'opérateur `empty` cree une sequence observable vide avec zéro elements
//: Ceci est utile lorsque vous voulez retourner un observable qui se termine immédiatement
example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable.subscribe(onNext: { (element) in
        print(element)
    }, onCompleted: {
        print("Completed")
    })
}

//: L'operateur `never` cree un observable qui n'emet rien et qui ne sera jamais terminé
//: Il peut être utile pour representer une durée infinie
example(of: "never") {
    let observable = Observable<Any>.never()
    
    observable.subscribe(onNext: { (element) in
        print(element)
    }, onCompleted: {
        print("Completed")
    })
}

//: Il est aussi possible de générer un observable à partir d'une gamme de valeurs
example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable.subscribe(onNext: { (i) in
        let n = Double(i)
        let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
        print(fibonacci)
    })
}

//: Vous pouvez causer la fin d'un observable en le stoppant manuellement
example(of: "dispose") {
    let observable = Observable.of("A", "B", "C")
    
    let subscription = observable.subscribe({ event in
        print(event)
    })
    
    //: Afin de stopper une soubscription, faites appel à la methode `dispose`
    subscription.dispose()
}

//: Si vous oubliez de faire appel à la methode `dispose` vous aurez probablement de pertes de mémoires
example(of: "DisposeBag") {
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C")
    .subscribe({
        print($0)
    }).addDisposableTo(disposeBag)
}

//: Un autre moyen créer un Observable est d'utiliser l'operateur `create`
example(of: "create") {
    let disposeBag = DisposeBag()
    
    enum MyError: Error {
        case anError
    }
    
    Observable<String>.create({observer in
        observer.onNext("1")
        observer.onError(MyError.anError)
        observer.onCompleted()
        observer.onNext("?")
        
        return Disposables.create()
    }).subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed")
    }).addDisposableTo(disposeBag)
}

//: Observable factories
//: Il est possible de créer un `Observable factory` qui cree un nouvel observale à chaque souscription
example(of: "deferred") {
    let disposeBag = DisposeBag()
    
    var flip = false
    
    let factory: Observable<Int> = Observable.deferred({
        flip = !flip
        
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    })
    
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        }).addDisposableTo(disposeBag)
        print()
    }
}

//: Subjects section [Next](@next)
