fun main() {
	/// example codes
    println(allLongestStrings(arrayOf("aba", "aa", "ad", "vcd", "aba")).joinToString(", "))
	println(arrayReplace(arrayOf(1,2,1), 1, 3).joinToString(", "))
}

fun allLongestStrings(input: Array<String>) : Array<String> {
	/// Find largest String by comparing its length
    val max = input.map {it -> it.length}.maxBy {it}
	
    return input
        		.filter{it -> it.length == max} /// Filter by equal size of max and current String length
        		.toTypedArray()
}

fun arrayReplace(inputArray: Array<Int>, elemToReplace: Int, substitutionElem: Int) : Array<Int> {
	if (elemToReplace == substitutionElem) {
		return inputArray /// nothing to do here
	}
    return inputArray
					.map { if (it == elemToReplace) substitutionElem else it }
					.toTypedArray()
}