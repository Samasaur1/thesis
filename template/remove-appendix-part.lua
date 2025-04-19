return {
  Para = function (el)
    if el.content[1].text == '\\cleardoublepage\n\\phantomsection\n\\addcontentsline{toc}{part}{' then
      return pandoc.Para {
        pandoc.RawInline('latex', '\\appendix')
      }
    end
  end
}
-- === Handling Para ===
-- Para {
--   clone: function: 0x600001dab2d0
--   content: Inlines {
--     [1] RawInline {
--       clone: function: 0x600001dabcf0
--       format: "latex"
--       text: "\cleardoublepage
-- \phantomsection
-- \addcontentsline{toc}{part}{"
--       walk: function: 0x600001dabcc0
--     }
--     [2] Str {
--       clone: function: 0x600001daea00
--       text: "Appendices"
--       walk: function: 0x600001dad860
--     }
--     [3] RawInline {
--       clone: function: 0x600001dac4e0
--       format: "latex"
--       text: "}
-- \appendix"
--       walk: function: 0x600001dac2d0
--     }
--   }
--   show: function: 0x600001dab360
--   walk: function: 0x600001dab330
-- }
