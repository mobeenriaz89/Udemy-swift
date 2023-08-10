import Cocoa
import CreateML
 
let args = ["/Users/mubeenriaz/Data/projects-2/Udemy-swift/DataSplitter/twitter-sanders-apple3.csv","0.8","5"]
let path = FileManager.default.currentDirectoryPath
let fileName = args[0]
let fileNameWithoutExt = fileName.replacingOccurrences(of: ".csv", with: "")
let trainingDataFileName = "\(fileNameWithoutExt)TrainingData.csv"
let testingDataFileName = "\(fileNameWithoutExt)TestingData.csv"
let by = Double(args[1])!
let seed = Int(args[2])!
var data: MLDataTable?
do {
  data = try MLDataTable(contentsOf: URL(fileURLWithPath: "\(path)/\(fileName)"))
} catch {
  print("Error generating MLDataTable: \(error)")
}
 
let (trainingData, testingData) = data!.randomSplit(by: by, seed: seed)
do {
  try trainingData.writeCSV(toFile: "\(path)/\(trainingDataFileName)")
  try testingData.writeCSV(toFile: "\(path)/\(testingDataFileName)")
} catch {
  print("Error generating CSV files: \(error)")
}
