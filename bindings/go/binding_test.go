package tree_sitter_god_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_god "github.com/wreedb/tree-sitter-god/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_god.Language())
	if language == nil {
		t.Errorf("Error loading God grammar")
	}
}
