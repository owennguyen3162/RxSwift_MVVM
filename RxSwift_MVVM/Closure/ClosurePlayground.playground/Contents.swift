import UIKit

//  Closure là 1 block code có thể tách ra để tái sử dụng
//  Đơn giản closure là 1 function nhưng khuyết danh
//  Ta có thể gán closure vào biến và sử dụng nó như 1 value


//  Có thể phân được ra 3 loại chính sau:
//  Global functions: là closures có tên và không “capture” các giá trị.
//  Nested functions: là closures có tên và có thể “capture” các giá trị từ function chứa nó.
//  Closure expressions: là closures không có tên được viết dưới dạng giản lược syntax và có thể “capture” các giá trị từ các bối cảnh xung quanh.

//Mục đích sử dụng nó
//Sử dụng chúng như là biến/hằng
//Sử dụng như các tham số trong khai báo 1 function.
//Sử dụng làm đối số để truyền vào các lời gọi hàm.
//Sử dụng như là các property trong class, struct, enum.
//Tái sử dụng hay kế thừa lại.

let simpleClosure = { print("Hello world") }

simpleClosure()


//Không tham số và không giá trị trả về
let closure1 = {() -> Void in
        print("Closure 1")
}
closure1()

//Có tham số và 0 có giá trị trả về
let sayHiClosure = { (name: String) in
    print("Hi, \(name)")
}
sayHiClosure("Joe")


let addClosure = { (a: Int, b: Int) -> Int
    in return a + b
}

print("2 + 3 = \(addClosure(2,3))")

// định danh 1 closure và tái sử dụng nó ở nhiều nơi

//1 khai báo closure
typealias Complete = (Int,Bool) -> Void

//khai báo function
func add(a: Int, b: Int, complete: Complete){
    let result = a + b
    complete(result,true)
}

//tạo closure
let myComplete = {(result: Int, done: Bool) in
    if done{
        print("Done \(result)")
    }else{
        print("Failed")
    }
}

//GỌi hàm và truyền vào đối số tương ứng
add(a: 1, b: 5, complete: myComplete)

//Có thể lồng closure trực tiếp như sau
add(a: 1, b: 5){ (result, done) in
    if (done) {
        print ("Done \(result)")
    }else{
        print("Failed")
    }
}

//Sử dụng như là Delegate & Datasource

protocol AddOperatorDelegate {
    func calculate (first: Int, second: Int, result: Int)
}

protocol AddOperatorDatasource {
    func getFirstNumber() -> Int
    func getSecondNumber() -> Int
}

class MyCalculator {
    var delegate: AddOperatorDelegate?
    var datasource: AddOperatorDatasource?
    
    typealias AddOperatorComplete = (Int, Int, Int) -> Void
    typealias FirstNumber = () -> Int
    typealias SecondNumber = () -> Int
    
    init(){}
    
    func add() -> Void {
        guard let datasource = datasource else {
            print("error")
            return
        }
        let firstNumber = datasource.getFirstNumber()
        let secondNumber = datasource.getSecondNumber()
        
        let result = firstNumber + secondNumber
        
        if let delegate = delegate {
            delegate.calculate(first: firstNumber, second: secondNumber, result: result)
        }
    }
    
    func add(first: FirstNumber, second: SecondNumber, completion: AddOperatorComplete) {
            let first = first()
            let second = second()
            
            let result = first + second
            
            completion(first, second, result)
        }
    
}

class MyClass: AddOperatorDelegate, AddOperatorDatasource {
    
    var first: Int
    var second: Int
    
        init(first: Int, second: Int) {
            self.first = first
            self.second = second
        }
        
        func handle() {
            let myCalculator = MyCalculator()
            myCalculator.delegate = self
            myCalculator.datasource = self
            
            myCalculator.add()
        }
    
    func calculate(first: Int, second: Int, result: Int) {
        print("\(first) + \(second) = \(result)")
    }
    
    func getFirstNumber() -> Int {
        return first
    }
    
    func getSecondNumber() -> Int {
        return second
    }
    
    func handleClosure () {
        let myCalculator = MyCalculator()
        myCalculator.add(first: {
            return first
        }, second: {
            return second
        }, completion: { (first, second, result) in
            print("\(first) + \(second) = \(result)")
        })
    }
    
}

let myClass =  MyClass(first: 10, second:  30)
myClass.handleClosure()
