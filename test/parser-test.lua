package.path = package.path .. ";../?.lua"

local Lexer = require("lexer")
local Parser = require("parser")
local P = Parser.from

describe("Testing Lexer", function()

    it("Repetition test1", function()
        local lex = Lexer:new("hello world world world yes")
        local p = P("hello") & P("world")^"*" & P("yes")
        local result = p:match(lex, 1, nil, nil)
        assert.not_nil(result)
        assert.are.equal(5, result.consumed)
    end)

    it("Or test1", function()
        local lex = Lexer:new("start(name=sam)")
        local name = P("name") & "=" & "%w+"
        local age = P("age") & "=" & "%d+"
        local p = P("start") & "(" & (name | age) & ")"
        local result = p:match(lex, 1, nil, nil)
        assert.not_nil(result)
        assert.are.equal(6, result.consumed)
    end)

end)
