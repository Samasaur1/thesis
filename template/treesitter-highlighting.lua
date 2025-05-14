-- return {
--   CodeBlock = function (el)
--     quarto.log.output("Handling code block!")
--     if el.attr.classes[1] == "swift" then
--       quarto.log.output("Found swift code block!")
--       return pandoc.system.with_temporary_directory('highlight-swift', function (tmpdir)
--         return pandoc.system.with_working_directory(tmpdir, function()
--           local f = io.open('code.swift', 'w')
--           f:write(el.text)
--           f:close()
--
--           local highighted = io.popen('tree-sitter highlight -H code.swift'):read("*all")
--           quarto.log.output("Highlighted!")
--           quarto.log.output(highighted)
--
--           return pandoc.RawBlock("html", highighted)
--         end)
--       end)
--     end
--   end
-- }

if quarto.format.is_html_output() then
  function CodeBlock(el)
    if el.classes[1] == "swift" then
      return pandoc.system.with_temporary_directory("highlight-swift", function (tmpdir)
        return pandoc.system.with_working_directory(tmpdir, function ()
          local f = io.open("code.swift", "w")
          f:write(el.text)
          f:close()

          local highlighted = io.popen("tree-sitter highlight -H code.swift"):read("*all")

          return pandoc.RawBlock("html", highlighted)
        end)
      end)
    end
  end
end

if quarto.format.is_latex_output() then
  function CodeBlock(el)
    if el.classes[1] == "swift" then
      return pandoc.system.with_temporary_directory("highlight-swift", function (tmpdir)
        return pandoc.system.with_working_directory(tmpdir, function ()
          local f = io.open("code.swift", "w")
          f:write(el.text)
          f:close()

          local highlighted = io.popen("chromacode -i code.swift -o /dev/null -d -f -r -t --escape-start '' --escape-end ''"):read("*all")

          highlighted = highlighted:gsub("\n", "\r") -- remove indent
          highlighted = highlighted:sub(1, -2) -- drop last newline

          local raw = "\\begin{Shaded}\n\\begin{Highlighting}[]\r" .. highlighted .. "\\end{Highlighting}\n\\end{Shaded}"

          return pandoc.RawBlock("latex", raw)
        end)
      end)
    end
  end
end
