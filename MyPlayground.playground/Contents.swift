import UIKit

var str = "HEllO"
print(str)

var year: Int
year = 1994

print(year)

print("string" + "3")

for row in 1...5{

    print(row)
}

for row in 1...5{
    for bat in 1...5{
        print("\(row) + \(bat)")
    }
}

var n = 0;

while n<100{
    n += 1
    print(n)
}


var number: [Int] = [1,2,3,4,5,6,7,8,9,10]
for i in 1..<number.count{
    print(number[i])
}

for row in number{
    print(row)
}

var arr = Array<String>()
var arr2: Array<String>

var genres = Set<String>()
genres.insert("Hohor")

for row in genres{
    print(row)
}

var country = Dictionary<String, String>()
country.updateValue("Seoul", forKey: "KR")

print(country.first!)

print(country.values)

func times(x: Int, y: Int) -> Int {
    return x*y
}

times(x: 3, y: 5)
