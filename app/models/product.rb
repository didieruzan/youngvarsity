# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  sku               :string(255)
#  manufacturer      :string(255)
#  title             :string(255)
#  description_short :text
#  description       :text
#  price             :decimal(6, 2)
#  url               :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_active         :boolean
#

class Product < ActiveRecord::Base
  attr_accessible :description, :description_short, :manufacturer, :price,
                  :sku, :title, :url, :is_active, :tag_list, :category_ids

  has_many :prodimages,   :dependent  => :destroy

  has_many :categorizations
  has_many :categories, :through => :categorizations


  has_many :wishings
  has_many :wishers, :through => :wishings

  acts_as_taggable

  def self.price_more_than(price)
    where("is_active = true AND price > ?", price)
  end

  def self.price_less_than(price)
    where("is_active = true AND price < ?", price)
  end

  def self.price_between(low, high)
    where(is_active:true, price: low..high)
  end

end
