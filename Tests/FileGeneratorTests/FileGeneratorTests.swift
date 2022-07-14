
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testAmbiguous() {

        struct Zilch: Content {
            var body: some Content {
                NoContent()
            }
        }

        let ambiguous = File {
            if 1 == 1 {
                NoContent()
            } else {
                Zilch()
            }
        }
        XCTAssertEqual(ambiguous.content, "")

        let ok = File {
            switch ["", ""].count {
            case 0:
                NoContent()
            case 1:
                NoContent()
            default:
                NoContent()
            }
        }
        XCTAssertEqual(ok.content, "")
    }

    func testGeneration() {
        let value = 1
        let file = File {
            "Hello"
            Section(header: "Header", footer: "Footer") {
                NoContent()
                "Line 1.1"
                Group {
                    "Indented"
                    "Together"
                }
                .indented()
                .indentation(.spaces(5))
                Section(header: "Header 2") {
                    for i in 1...5 {
                        "Line 2.\(i)"
                    }
                    if true {
                        "Optional"
                    }
                    if value == 0 {
                        "True"
                    } else {
                        "False"
                    }
                }
                "Line 1.2"
            }
            "World"
        }
        .indentation(.spaces(2))

        XCTAssertEqual(file.content, """
        Hello
        Header
          Line 1.1
               Indented
               Together
          Header 2
            Line 2.1
            Line 2.2
            Line 2.3
            Line 2.4
            Line 2.5
            Optional
            False
          Line 1.2
        Footer
        World
        """)
    }
}
