class ItemType < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :media, through: :category_groups

  #validates :name, presence: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item_type|
        csv << item_type.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item_type = find_by(id: row["id"]) || new
      item_type.attributes = row.to_hash
      item_type.save!
    end
  end


    # CSV.foreach(file.path, headers: true) do |row|
    # item_type = find_by_id(row["id"]) || new
    # item_type.attributes = row.to_hash
    # item_type.save!
    # end
  # end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
