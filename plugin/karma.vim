let s:plugin_name = 'vim-karma'

let s:ErrorCode = 1
let s:SuccessCode = 0

function! s:ErrorMsg(message)
  echoerr string('Error('.s:plugin_name.'): '.a:message)
endfunction

" Find root directory by directory
" node_modules
" @param {String} Top directory from which start lookup
function! s:find_project_root_dir(dir)
  let l:node_modules_dir = globpath(a:dir, 'node_modules/karma')

  if isdirectory(l:node_modules_dir)
    return a:dir
  endif

  let l:parent_dir = fnamemodify(a:dir, ':h')
  if l:parent_dir != a:dir
    return s:find_project_root_dir(l:parent_dir)
  endif

  call s:ErrorMsg("Can not find node_modules/karma directory")
endfunction

" TODO(maksimrv): Improve implementation
" @param {String} The type of spec `it` or `describe`
" @retun {String} Content of the line where locate it or describe
function! s:extractTestCaseContent(type, line)
  let s:spec = matchstr(a:line, a:type."\s*(\s*['\"].*['\"]")
  let s:spec = substitute(s:spec, a:type."\s*(\s*['\"]", '', '')
  let s:spec = substitute(s:spec, "['\"]$", '', '')

  return s:spec
endfunction

" Get nearest spec `it` or `describe`
" @param {String} The type of spec `it` or `describe`
" @retun {String} Content of test suite or test case
" TODO(maksimrv): Improve implementation. I think we can do it more cool
function! s:getNearest(type)
  let current_position = getpos('.')

  execute '?'.a:type
  let result = s:extractTestCaseContent(a:type, getline(line('.')))

  call setpos('.', current_position)
  return result
endfunction

" Run all tests
function! RunAllSpecs()
  call RunSpecs("")
endfunction

function! RunCurrentSpecFile()
  call RunSpecs(expand('%:t'))
endfunction

" Run nearest it
function! RunNearestTestCase()
  call RunSpecs(s:getNearest('it'))
endfunction

function! RunNearestSpec()
  call RunNearestTestCase()
endfunction

" Run nearest describe
function! RunNearestTestSuite()
  call RunSpecs(s:getNearest('describe'))
endfunction

" Run tests
"
" @param {[String]} a:0 The grep string by default empty string
function! RunSpecs(...)
  if !executable('karma')
    call s:ErrorMsg('karma-cli is not installed. Please install karma-cli (npm install -g karma-cli)')
    return s:ErrorCode
  endif

  execute 'chdir' s:find_project_root_dir(getcwd())

  let spec = get(a:000, 0, '')
  let karma_command = escape(substitute("karma start --single-run=true --client.useIframe=true --client.captureConsole=true --client.mocha.grep='{spec}'", "{spec}", spec, "g"), '#')

  execute '!clear && echo "'.karma_command.'" && '.karma_command
endfunction

" Need For testing local variables
function! karma#scope()
  return s:
endfunction

" Need for testing local functions
" Define script identification <SID>
" For local functions and variables s: replace
" on <SID>
" For more information look at :h <SID>
function! karma#sid()
  return maparg('<SID>', 'n')
endfunction
nnoremap <SID> <SID>
