var array1: [Int] = [2, 4, 5, 3];
var array2: [Int] = [4, 5, 2, 3];

print("are equals: \(equalsArrays(array1: array1, array2: array2))")

var text: String = "copacabana"
print("number of uniques letters in \(text): \(differentSymbolsNaive(text: text))")

/// Considering arrays of same size and of type int
func equalsArrays(array1: [Int], array2: [Int]) -> Bool {
    /// Creates empty dictionary where each key is the number in the array and the value an acumulative
    /// of how many times has been seen in the first array
    var counts: [Int : Int] = [Int : Int]();
    array1.forEach { number in
        let count: Int = counts[number] ?? 0; /// if the key doesn't exist we start at zero
        counts[number] = count + 1;
    }
    for number: Int in array2 {
        let count: Int? = counts[number];
        /// If the key doesn't exist or the value is zero it means the current number in the 
        /// 2nd array is repeated at least once more hence they are not equals
        if count == nil || count == 0 {   
            return false;
        }
        counts[number] = count! - 1; /// rest 1 from the value-key pair for the next iteratio
    }
    return true;
}

func differentSymbolsNaive(text: String) -> Int {
    ///  transform a text into a Set of characters which only keeps unique values and return its length
    return Set(text).count
}