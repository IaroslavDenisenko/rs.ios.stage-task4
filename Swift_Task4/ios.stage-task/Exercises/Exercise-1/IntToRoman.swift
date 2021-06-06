import Foundation


public extension Int {
    
    var roman: String? {
        convertIntToRoman(self)
    }
    
    private func convertIntToRoman(_ number: Int) -> String? {
        guard number >= 1 && number <= 3999 else { return nil }
        let romans = [
            ("M", 1000),
            ("CM", 900),
            ("D", 500),
            ("CD", 400),
            ("C", 100),
            ("XC", 90),
            ("L", 50),
            ("XL", 40),
            ("X", 10),
            ("IX", 9),
            ("V", 5),
            ("IV", 4),
            ("I", 1)
        ]
        var result = ""
        var remainder = number
        for tuple in romans {
            let integer = remainder / tuple.1
            remainder = remainder % tuple.1
            for _ in 0..<integer {
                result += tuple.0
            }
            if remainder == 0 {
                break
            }
        }
        return result
    }
}
