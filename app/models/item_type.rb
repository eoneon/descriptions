class ItemType < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :media, through: :category_groups
  #has_many :field_groups, through: :media

  #accepts_nested_attributes_for :category_groups, reject_if: proc {|attrs| attrs['medium_id'].blank?}, allow_destroy: true
  #accepts_nested_attributes_for :field_groups, reject_if: proc {|attrs| attrs['item_field_id'].blank?}, allow_destroy: true
  #accepts_nested_attributes_for :media, reject_if: proc {|attrs| attrs['medium'].blank?}, allow_destroy: true
  validates :name, presence: true

  delegate :medium, :to => :media

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

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
