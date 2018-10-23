cdPrevDir() { 
  popd &>/dev/null
  zle reset-prompt
  echo -e "\n\e[30m$(pwd)\e[0m"
  zle reset-prompt
}
zle -N cdPrevDir

cdParentDir() {
  pushd .. &>/dev/null
  zle reset-prompt
  echo -e "\n\e[30m$(pwd)\e[0m"
  zle reset-prompt
}
zle -N cdParentDir

genpassphrase() {
  local _password_store _pp_name _pass_phrase _store_pp_abs_path
  _key_id="robin@eika.as"
  _pp_name="${1}"
  _pw_store="${PW_STORE:-${HOME}/.password-store}"

  # ---------------------------------------------------------------
  if [[ -n "${_pp_name}" ]]; then
    _store_pp_abs_path="${_pw_store}/${_pp_name}.gpg"
    _store_pp_parent_dir="$(dirname ${_store_pp_abs_path})"

    if ! [[ -d "${_pw_store}" ]]; then
      echo "\e[38;5;149m * Creating password store at for \e[38;5;205m${_pw_store}\e[0m"
      mkdir -p "${_pw_store}"
    fi

    if [[ -e "${_store_pp_abs_path}" ]]; then
      echo "\e[38;5;124m !! ${_store_pp_abs_path} already exists\e[0m" >/dev/stderr
      exit 1
    fi

    if ! [[ -d "${_store_pp_parent_dir}" ]]; then
      echo "\e[38;5;149m * Creating missing parent dir for \e[38;5;205m${_pp_name}\e[0m"
      mkdir -p "${_store_pp_parent_dir}"
    fi

    echo "\e[38;5;149m * Generating passphrase for \e[38;5;205m${_pp_name}\e[0m"
    _pass_phrase="$(sort -R /usr/share/dict/cracklib-small | tail -n 7 | tr -d \' | xargs)"
    echo "\e[38;5;149m * Encrypting passphrase for \e[38;5;205m${_key_id}\e[0m"
    _encrypted_pass_phrase=$(echo -n "${_pass_phrase}" | gpg -ear "${_key_id}")
    echo "\e[38;5;149m * Storing encrypted passphrase to: \e[38;5;205m$(realpath --relative-to=${HOME} ${_store_pp_abs_path})\e[0m"
    echo -n "${_encrypted_pass_phrase}" > "${_store_pp_abs_path}"
  fi
  # ---------------------------------------------------------------

  echo -e "\e[38;5;149m * Plaintext passphrase copied to clipboard. Valid for one paste only\e[0m"
  echo -n "${_pass_phrase}" | xclip -i -sel clipboard -loop 1
  echo -e "\n\e[48;5;205m\e[38;5;234m  ${_pass_phrase}  \e[0m\n"

  _pass_phrase="\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
  unset _pass_phrase
}

