//: [Previous](@previous)

import Foundation
import RxSwift

/*:
    Un Subject est un type qui peut servir à la foi d'observeur et d'observable
 */

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

//: Les `PublishSubjects` demarrent vide et emettent uniquement les nouveaux evennements aux souscriveurs
example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    
    subject.onNext("Is anyone listening ?")
    
    let subscriptionOne = subject
        .subscribe(onNext: { string in
            print(string)
        })
    subject.on(.next("1"))
}

//: [Next](@next)
