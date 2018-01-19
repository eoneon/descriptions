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

  def d_hash
    properties.delete_if { |k,v| v.empty? }
  end

  def t_hash
    d_hash.delete_if { |k,v| k == "paper_kind" || v == "giclee" }
  end

  def build_media(media)
    build = []
    media.each do |k,v|
      build << v
    end
    build.join(" ")
  end

  def parent_media
    media.map {|medium| medium.item_fields.map {|field| properties[field.name] }}
  end

  def description
    build_media(d_hash) if properties
  end

  #this is the issue, not sure if it even matters...
  def tagline
    #build_media(t_hash) if properties
  end
end
