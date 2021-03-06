
import FileBuilder
import XCTest

final class IndentationTests: XCTestCase {

    func testNone() throws {
        try AssertContent {
            "One".indentation(.tab)
            "Two".indentation(.spaces(1))
            "Three".indentation(.spaces(8))
        } is: {
            """
            One
            Two
            Three
            """
        }
    }

    func testDefault() throws {
        try AssertContent {
            "One".indented()
        } is: {
            "    One"
        }
    }

    func testTab() throws {
        try AssertContent {
            "One".indented().indentation(.tab)
        } is: {
            "\tOne"
        }
    }

    func testSpaces1() throws {
        try AssertContent {
            "One".indented().indentation(.spaces(1))
        } is: {
            " One"
        }
    }

    func testSpaces8() throws {
        try AssertContent {
            "One".indented().indentation(.spaces(8))
        } is: {
            "        One"
        }
    }
}
