# Класс, отвечающий за ввод данных в программу "виселица"
class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    begin
      f = File.new(file_name, "r:UTF-8")
      lines = f.readlines
      f.close
    rescue SystemCallError
      abort "Файл #{file_name}.txt отсутствует. Загрузите файл и возвращайтесь!"
    end

    lines.sample.downcase.chomp
  end
end
