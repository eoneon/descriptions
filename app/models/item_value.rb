class ItemValue < ApplicationRecord
  belongs_to :item_field

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item_value|
        csv << item_value.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item_value = find_by(id: row["id"]) || new
      item_value.attributes = row.to_hash
      item_value.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def substrate
    if ["canvas", "paper", "panel"].include?(self.item_field.try(:name))
      "on #{self.name}"
    end
  end

  def paint
    if ["canvas", "paper", "panel"].include?(self.item_field.try(:name))
      "#{self.name} painting"
    end
  end
  
end
