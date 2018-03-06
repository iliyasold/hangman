# Класс, печатающий состояние и результаты игры
class ResultPrinter

  def initialize(game)
    @status_image = [] # массив с изображением виселиц

    counter = 0 # счетчик шагов

    while counter <= game.max_errors do
      file_name = "./image/#{counter}.txt"

      begin
        f = File.new(file_name, "r:UTF-8")
        @status_image << f.read
        f.close
      rescue SystemCallError
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  # метод, рисующий виселицу
  def print_gallows(errors)
    puts @status_image[errors]
  end

  # основной метод, печатающий состояния объекта класса Game
  def print_status(game)
    cls
    puts game.version

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "\nОшибки: #{game.bad_letters.join(", ")}"
    print_gallows(game.errors)

    if game.lost?
      puts "\nВы проиграли :(\n"
      puts "Загаданное слово было: #{game.letters.join("")}"
      puts
    elsif game.won?
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: #{(game.errors_left).to_s}"
    end
  end

  # метод, возвращающий строку, изображающую загаданное слово
  def get_word_for_print(letters, good_letters)
    result = ""

    for item in letters do
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end

    result
  end

  def cls
    system "clear" or system "cls"
  end
end
