import UIKit

final class MyOperation: Operation {
    var inval: String = "some"
    override func main() {
        print("Operation usage")
    }
}

final class SecondOperation: Operation {
    private(set) var result: Result<String, Error>?
    
    override func main() {
        print("Second")
        result = .success("hello")
    }
}

let operation = MyOperation()
let op2 = SecondOperation()
operation.addDependency(op2)
let operationQueue = OperationQueue()
operationQueue.name = "q1"
operationQueue.maxConcurrentOperationCount = 5
operationQueue.addOperation(operation)
operationQueue.addOperation(op2)
