/**
 * @file God grammar for tree-sitter
 * @author Will Reed <wreed@disroot.org>
 * @license LGPL-3.0-or-later
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: "god",

  extras: $ => [
    /[\s\t]/,
    $.comment,
  ],

  rules: {
    
    document: $ => seq('{', repeat($.field), '}'),    
    identifier: $ => /[A-Za-z_][A-Za-z0-9_\'\-]*/,
    
    operator: $ => choice(
      $.termination,
      $.assignment,
      $.negation
    ),
    
    element: $ => choice(
      $.string,
      $.number, 
      $.bool,
      $.null,
      $.list,
      $.map,
      $.negatedElement
    ),

    termination: $ => token(';'),
    negation: $ => token('-'),
    assignment: $ => token('='),
    
    negatedElement: $ => seq(
      $.negation,
      $.element
    ),
    
    field: $ => seq(
        $.identifier, // name
        $.assignment, // =
        $.element,    // "Will"
        $.termination // ;
    ),
    
    list: $ => seq('[', repeat($.element), ']'),
    map: $ => seq('{', repeat($.field), '}'),
    
    string: $ => choice(
        token(seq(
          '"',
          repeat(choice(
            /[^"]/,
            /\\"/,
            /\\n/,
            /\\r/,
            /\\t/
          )),
          '"',
        )),
        token(seq(
            "''",
            repeat(choice(
                /[^']/,           // Any character except single quote
                /'[^']/,          // Single quote followed by non-quote
                /'''/,            // Triple quote (escape for '')
                /''\$/,           // Escape for literal ''
                /''\\/,           // Escape for backslash
            )),
            "''"))),
    
    number: $ => token(
        choice(
            seq(
                /\d+/,
                optional(seq('.', optional(/\d+/))),
                optional(seq(
                    /[eE]/,
                    optional(choice('+', '-')),
                    /\d+/
                ))
            ),
            seq(
                '.',
                /\d+/,
                optional(seq(
                    /[eE]/,
                    optional(choice('+', '-')),
                    /\d+/
                ))
            )
        )
    ),
    
    // number: $ => token(/-?(?:\d+(?:\.\d*)?(?:[eE][+-]?\d+)?|\.\d+(?:[eE][+-]?\d+)?)/),
    bool: $ => choice('true', 'false'),
    null: $ => 'null',
    comment: $ => /#.*/,
  }
});
