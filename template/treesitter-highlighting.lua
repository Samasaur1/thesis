SUPPORTED_FORMATS = pandoc.List({ "swift" })

if quarto.format.is_html_output() then
  function CodeBlock(el)
    local LANG = el.classes[1]
    if SUPPORTED_FORMATS:includes(LANG) then
      return pandoc.system.with_temporary_directory("highlight-" .. LANG, function (tmpdir)
        return pandoc.system.with_working_directory(tmpdir, function ()
          local filename = "code." .. LANG
          local f = io.open(filename, "w")
          f:write(el.text)
          f:close()

          local highlighted = io.popen("tree-sitter highlight -H " .. filename):read("*all")

          return pandoc.RawBlock("html", highlighted)
        end)
      end)
    end
  end
end

if quarto.format.is_latex_output() then
  function CodeBlock(el)
    local LANG = el.classes[1]
    if SUPPORTED_FORMATS:includes(LANG) then
      return pandoc.system.with_temporary_directory("highlight-" .. LANG, function (tmpdir)
        return pandoc.system.with_working_directory(tmpdir, function ()
          local filename = "code." .. LANG
          local f = io.open(filename, "w")
          f:write(el.text)
          f:close()

          local highlighted = io.popen("chromacode -i " .. filename .. " -o /dev/null -d -f -r -t --escape-start '' --escape-end ''"):read("*all")

          highlighted = highlighted:gsub("\n", "\r") -- remove indent
          highlighted = highlighted:sub(1, -2) -- drop last newline

          local raw = "\\begin{Shaded}\n\\begin{Highlighting}[]\r" .. highlighted .. "\\end{Highlighting}\n\\end{Shaded}"

          return pandoc.RawBlock("latex", raw)
        end)
      end)
    end
  end
end
