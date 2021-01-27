function fish_prompt
	set -g fish_prompt_pwd_dir_length 30
	echo (set_color -b 005577)(set_color EEEEEE)" "(prompt_pwd)" "(set_color normal)" "
end
