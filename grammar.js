/**
 * @file God grammar for tree-sitter
 * @author Will Reed <wreed@disroot.org>
 * @license LGPL-3.0-or-later
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "god",

  extras: $ => [
    /[\s\t]/,
    $.comment,
  ],

  rules: {
    
    document: $ => seq('{', repeat($.field), '}'),    
    identifier: $ => /[A-Za-z_][A-Za-z0-9_\'\-]*/,
    
    element: $ => choice(
      $.string,
      $.number, 
      $.bool,
      $.null,
      $.list,
      $.map
    ),

    field: $ => seq($.identifier, '=', $.element, ';'),
    list: $ => seq('[', repeat($.element), ']'),
    map: $ => seq('{', repeat($.field), '}'),
    string: $ => token(seq( '"', repeat(choice( /[^\"]/, /\\"/, /\\n/, /\\r/, /\\t/ )), '"', )),
    number: $ => token(/-?(?:\d+(?:\.\d*)?(?:[eE][+-]?\d+)?|\.\d+(?:[eE][+-]?\d+)?)/),
    bool: $ => choice('true', 'false'),
    null: $ => 'null',
    comment: $ => /#.*/,
  }
});
