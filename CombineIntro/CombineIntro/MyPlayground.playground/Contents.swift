import UIKit

var greeting = "Hello, playground"
import UIKit
import Combine

class ClubHouseHandsUp: Publisher {
    
    typealias Output = String
    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, String == S.Input {
        DispatchQueue.global(qos: .utility).async {
            let dummy: [String] = ["jack", "tom"]
            dummy.forEach {
                _ = subscriber.receive($0)
            }
            subscriber.receive(completion: .finished)
        }
    }
}

let handsupPublisher = ClubHouseHandsUp()
_ = handsupPublisher.sink(receiveCompletion: { s_s in
    print("comlpleted")
}) {
    print($0)
}
