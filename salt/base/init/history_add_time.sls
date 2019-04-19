history_add_file:
  file.append:
    - name: /etc/profile
    - text: 
      - export HISTTIMEFORMAT="%F %T `whoami`  "
history_add_log:
  file.append:
    - name: /etc/bashrc
    - text:
      - export  PROMPT_COMMAND='{ msg=$(history 1| { read x y; echo $y; });logger "[username=$(whoami)]":$(who am i):[`pwd`] "[cmd_run]":"$msg";}'
