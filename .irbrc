# Auto-complete for method names and such
require 'irb/completion'

# Loads simple IRB (without RVM notice)
IRB.conf[:PROMPT_MODE] = :SIMPLE

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

# A method for clearing the screen
def clear
  system('clear')
end