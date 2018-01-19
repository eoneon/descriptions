class ItemType < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :media, through: :category_groups

  accepts_nested_attributes_for :category_groups, reject_if: proc {|attrs| attrs['medium_id'].blank?}, allow_destroy: true
  validates :name, presence: true
  delegate :medium, :to => :media

  # def medium_ids
  #   self[:medium_ids]
  # end

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

  def fetched_associated_field_names
    media.map {|medium| medium.item_fields.map {|field| field.name }.join("")}
  end

  def build_media_description
    fetched_associated_field_names.map {|field| update_field_values(field)}.join(" ")
  end

  def update_field_values(field_name)
    if fetched_associated_field_names && ["leafing_kind", "remarque_kind"] == ["leafing_kind", "remarque_kind"] && field_name == "remarque_kind"
      properties[field_name].gsub("with ", "and ")
    else
      properties[field_name]
    end
  end
end
