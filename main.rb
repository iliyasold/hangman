require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

VERSION = "Потешная, жизнеутверждающая игра 'Виселица'. Soldatkin™Lab 2018. v.2.1 \n\n"

word_reader = WordReader.new
words_file_name = "./data/words.txt"
game = Game.new(word_reader.read_from_file(words_file_name))
game.version = VERSION

printer = ResultPrinter.new(game)

while game.in_progress? do
  printer.print_status(game) # выводим статус игры
  game.ask_next_letter # просим угадать следующую букву
end

printer.print_status(game)
