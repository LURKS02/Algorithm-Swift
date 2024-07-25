while let input = readLine(), input != "end" {
    let password = input
    let vowels = "aeiou"
    
    var containsVowel = false
    var hasThreeConsecutiveSameType = false
    var hasDoubleLetter = false
    
    var vowelCount = 0
    var consonantCount = 0
    var maxVowel = 0
    var maxConsonant = 0
    var previousChar: Character? = nil
    
    for char in password {
        if vowels.contains(char) {
            containsVowel = true
            vowelCount += 1
            consonantCount = 0
            maxVowel = max(maxVowel, vowelCount)
        } else {
            consonantCount += 1
            vowelCount = 0
            maxConsonant = max(maxConsonant, consonantCount)
        }
        
        if maxVowel >= 3 || maxConsonant >= 3 {
            hasThreeConsecutiveSameType = true
        }
        
        if char == previousChar && !(char == "e" || char == "o") {
            hasDoubleLetter = true
        }
        
        previousChar = char
    }
    
    if !containsVowel || hasThreeConsecutiveSameType || hasDoubleLetter {
        print("<\(password)> is not acceptable.")
    } else {
        print("<\(password)> is acceptable.")
    }
}
