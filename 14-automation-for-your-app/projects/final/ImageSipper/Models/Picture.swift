/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

struct Picture: Equatable {
  let id = UUID()
  var url: URL
  var pixelHeight: Int
  var pixelWidth: Int
  var dpiHeight: Double
  var dpiWidth: Double
  var format: String
  var creation: String?
  var make: String?
  var model: String?

  init(url: URL, sipsData: String) {
    self.url = url

    let sipsLines = sipsData.components(separatedBy: .newlines)

    var picProperties: [String: String] = [:]
    for line in sipsLines {
      let lineParts = line.components(separatedBy: ": ")
      if lineParts.count != 2 {
        continue
      }

      let name = lineParts[0].trimmingCharacters(in: .whitespaces)
      let value = lineParts[1].trimmingCharacters(in: .whitespaces)

      picProperties[name] = value
    }

    pixelHeight = Int(picProperties["pixelHeight"] ?? "0") ?? 0
    pixelWidth = Int(picProperties["pixelWidth"] ?? "0") ?? 0
    dpiHeight = Double(picProperties["dpiHeight"] ?? "0") ?? 0
    dpiWidth = Double(picProperties["dpiWidth"] ?? "0") ?? 0
    format = picProperties["format"] ?? url.pathExtension
    creation = picProperties["creation"]
    make = picProperties["make"]
    model = picProperties["model"]
  }

  var aspectRatio: Double {
    let width = Double(pixelWidth)
    let height = Double(pixelHeight)

    if height == 0 {
      return 1
    }
    return width / height
  }
}
