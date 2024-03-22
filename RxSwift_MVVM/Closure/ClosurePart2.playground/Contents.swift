import UIKit


//Bước 1: Các closure được định nghĩa
//Sử dụng closure là các đối số của function được gọi
//Các giá trị biến được gắn vào closure

//Bước 2: Thực hiện function
//Giá trị của các tham số trong hàm được truyền vào từ closure
//Hàm được gọi và sau khi kết thúc hàm thì các đối số sẽ được giải phóng
//Các closure truyền vào cũng được giải phóng theo

//Bước 3: Nhận giá trị trả về
//Function return về thì các closure mà đã bị giải phóng rồi nên việc thực hiện tiếp sẽ không thể được


//@nonescaping closure

//Với swift 1 và 2 thì mặc địch sẽ là không phải @nonescaping. Nên khi khai báo thì chúng ta cần phải thêm từ khoá @nonescaping vào.
//Với swift 3 và 3 thì ngược lại.
//Life cycle của một @nonescaping closure rất đơn giản:
//Closure được pass vào function argument.
//Function excute closure. Closure được giải phóng khỏi bộ nhớ.
//Function return.
//Khi sử dụng @nonescaping closure, compiler cũng không cần reference tới self, không xảy ra trường hợp reference cycle. Vì vậy không cần sử dụng [weak self] hoặc [unowned self].


func getSumOf(numbers: [Int],  completion: (Int) -> Void) {
    var sum = 0
    
    for aNumber in numbers {
        sum += aNumber
    }
    
    completion(sum)
}
func doSomeThing() {
    getSumOf(numbers: [24, 5, 29, 18, 97, 43]) { (result) in
        print("Sum is \(result)")
    }
}
doSomeThing()

//@escaping closure
//Với swift 3 và 4 thì phải sử dụng từ khoá @escaping.
//Khi cần giữ lại closure thành property của class để chờ excute sau.
//Để closure có thể được giữ lại trong bộ nhớ sau khi function excute xong và return compiler.
//Ví dụ: chờ response API…
//Khi excute closure trên một thread khác, một asynchronous dispatch queue.
//Queue này sẽ giữ closure trong bộ nhớ, nhằm excute sau. Trường hợp này, chúng ta sẽ không biết được closure sẽ được excute chính xác vào thời điểm nào.
//
//
//Ví dụ viết lại ví dụ trên với delay 5 giây mới trả kết quả về
//Nó tương tự như request API thì diễn ra bất đồng bộ
//Thời gian nhận giá trị trả về thì không xác định được

func getSumOf(numbers: [Int],  completion: (Int) -> Void) {
    var sum = 0
    
    for aNumber in numbers {
        sum += aNumber
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print("After 5 secs")
        completion(sum)
    }
}
func doSomeThing() {
    getSumOf(numbers: [24, 5, 29, 18, 97, 43]) { (result) in
        print("Sum is \(result)")
    }
}
doSomeThing()
