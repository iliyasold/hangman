# Основной класс игры
class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters

  attr_accessor :version, :status

  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)

    @errors = 0

    @good_letters = [] # угаданные буквы
    @bad_letters = [] # неугаданные буквы

    @status = :in_progress # :won, :lost
  end

  # возвращает массив букв загаданного слова
  def get_letters(word)
    if word.nil? || word == ''
      abort 'Вы не ввели слово.'
    else
      word = word.encode('UTF-8')
    end

    word.upcase.split('')
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  # проверяет, есть ли в слове введённая буква
  def is_good?(letter)
    letters.include?(letter) ||
        (letter == 'Е' && letters.include?('Ё')) ||
        (letter == 'Ё' && letters.include?('Е')) ||
        (letter == 'И' && letters.include?('Й')) ||
        (letter == 'Й' && letters.include?('И'))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
      when 'И' then
        letters << 'Й'
      when 'Й' then
        letters << 'И'
      when 'Е' then
        letters << 'Ё'
      when 'Ё' then
        letters << 'Е'
    end
  end

  # проверяет: угадано ли на этой букве все слово целиком
  def solved?
    (letters - @good_letters).empty?
  end

  # проверяет введённую букву на повторение
  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  # три метода статусов игры
  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

 def won?
   self.status == :won
 end

  def in_progress?
    self.status == :in_progress
  end

  # делает следующий шаг
  def next_step(letter)
    letter = letter.upcase

    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      self.status = :won if solved?
    else # если в слове нет введенной буквы – добавляем ошибочную букву и увеличиваем счетчик
      add_letter_to(@bad_letters, letter)
      @errors += 1
      self.status = :lost if lost?
    end
  end

  # метод, спрашивающий у пользователя букву и возвращающий ее как результат
  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ''
    letter = STDIN.gets.encode('UTF-8').chomp while letter == ''
    next_step(letter)
  end
end
