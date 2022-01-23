""" Vim TASKS file



" List of all available tasks for current project
let g:tasksList = [ '<TASKS LIST>' ]
command Tasks echo g:tasksList


" Command / function to run the task given as argument
function! RunTask(task)
  let s:set_env = 'source $HOME/.virtualenv/<VENV NAME>/bin/activate'     " for python virtual environments

  if a:task ==? '<TASK NAME>'
    let s:run_command = '<COMMAND>'
  endif

  execute '!gnome-terminal --tab --working-directory=<CWD> -- /bin/bash -c ' .
  \ "\'" . s:set_env . '; ' .
  \ 'echo ===== task [ ' . a:task . ' ] started ===== && echo; ' .
  \ s:run_command . '; ' .
  \ 'echo && echo ===== task [ ' . a:task . ' ] completed =====; ' .
  \ "read\'"

endfunction

" Autocompletion function for 'Run' command
function! RunComplete(ArgLead, CmdLine, CursorPos)
  return g:tasksList
endfunction


command -nargs=1 -complete=customlist,RunComplete Run silent call RunTask(<f-args>) | redraw!
