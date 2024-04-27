class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @elements
  end

  def create(element) # instance
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # update any value from a string to something else
      @elements << build_element(row)
    end
    @next_id = @elements.any? ? @elements.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << element.build_row
      end
    end
  end
end
