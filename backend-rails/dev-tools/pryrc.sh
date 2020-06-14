# This can be added to your .pryrc file in $HOME/
if defined?(PryDebugger) || defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry.config.color = true
Pry.config.collision_warning = true
Pry.config.pager = false

Pry::Commands.command(/^$/, "repeat last command") do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end
