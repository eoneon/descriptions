class ItemField < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :media, through: :field_groups

  has_many :value_groups, dependent: :destroy
  has_many :item_values, through: :value_groups

  has_many :field_groups, dependent: :destroy
  has_many :item_fields, through: :field_groups

  accepts_nested_attributes_for :field_groups, reject_if: proc {|attrs| attrs['item_field_id'].blank?}, allow_destroy: true
  accepts_nested_attributes_for :item_values, reject_if: proc {|attrs| attrs['name'].blank?}, allow_destroy: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item_field|
        csv << item_field.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item_field = find_by(id: row["id"]) || new
      item_field.attributes = row.to_hash
      item_field.save!
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
end
