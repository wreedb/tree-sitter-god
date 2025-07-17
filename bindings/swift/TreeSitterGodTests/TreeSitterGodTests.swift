import XCTest
import SwiftTreeSitter
import TreeSitterGod

final class TreeSitterGodTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_god())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading God grammar")
    }
}
