class MenuItem < ApplicationRecord
	#relations:
	has_many :temp_order_items
  belongs_to :category
  #
  default_scope -> { order(created_at: :desc) }
  #validates attributes
  validates :category_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates_numericality_of :price,  only_integer: true, greater_than: 0
  validates :description, length: { maximum: 500 }
  #
  mount_uploader :image, ImageUploader

  #like clause
  def self.match_scope_condition(col, query)
    arel_table[col].matches("%#{query}%")
  end
  ##
  scope :matching, lambda {|*args|
    col, opts = args.shift, args.extract_options!
    op = opts[:operator] || :or
    where args.flatten.map {|query| match_scope_condition(col, query) }.inject(&op)
  }
end
