import Foundation

final class FillWithColor {

    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var newImage = image
        
        if checkValues(image, row, column) {
            guard image[row][column] != newColor else { return image }
            newImage[row][column] = newColor
            
            if checkValues(image, row + 1, column) {
                if image[row + 1][column] == image[row][column] {
                    newImage = fillWithColor(newImage, row + 1, column, newColor)
                }
            }
            if checkValues(image, row - 1, column) {
                if image[row - 1][column] == image[row][column] {
                    newImage = fillWithColor(newImage, row - 1, column, newColor)
                }
            }
            if checkValues(image, row, column + 1) {
                if image[row][column + 1] == image[row][column] {
                    newImage = fillWithColor(newImage, row, column + 1, newColor)
                }
            }
            if checkValues(image, row, column - 1) {
                if image[row][column - 1] == image[row][column] {
                    newImage = fillWithColor(newImage, row, column - 1, newColor)
                }
            }
        }
        
        return newImage
    }
    
    private func checkValues(_ image: [[Int]], _ row: Int, _ column: Int) -> Bool {
        if (row >= 0 && row < image.count) && (column >= 0 && column < image[0].count) {
            return true
        }
        return false
    }
}
