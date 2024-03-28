import UIKit

let quene = DispatchQueue(label: "com.owen.myqueue") //Định nghĩa Queue

let queue = DispatchQueue(label: "com.fx.myqueue")
queue.async {
    for i in 0..<10 {
        print("🔴", i)
    }
}
for i in 100..<110 {
    print("🔶", i)
}
