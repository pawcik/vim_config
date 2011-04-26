" Vim syntax file
" file type: log files
" Quit when a (custom) syntax file was already loaded
syn clear
"if exists("b:current_syntax")
  "finish
"endif

syn case match

syn match fatal /.* FATAL .*/
syn match fatal /^FATAL: .*/
syn match error ".* ERROR .*"
syn match error "^ERROR: .*"
syn match warn /.* WARN .*/
syn match warn "^WARN: .*"
syn match info "^WARN: .*"


" Highlight colors for log levels.
hi error ctermfg=Red ctermbg=Black
hi warn ctermfg=Red ctermbg=Black
hi info ctermfg=Green ctermbg=Black
hi debug ctermfg=Gray ctermbg=Black
"hi link fatal String
hi link warn Function
hi link info Number

let b:current_syntax = "log"
