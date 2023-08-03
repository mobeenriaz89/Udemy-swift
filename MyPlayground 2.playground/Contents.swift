import Cocoa

func calculator(n1: Int, n2: Int, operation:(Int,Int)->Int) -> Int {
    return operation(n1,n2)
}



calculator(n1: 3, n2: 4){$0 + $1}

var inputs = [1,2,3,4,5]

print(inputs.map{"\($0)"})
