class User < ApplicationRecord
  require 'roo'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of [:full_name, :role]
  enum role: [:admin, :client]
  has_one_attached :avatar

  def self.import(file)
    xlsx = Roo::Excelx.new(file.tempfile)
    xlsx.each_row_streaming(offset: 1) do |row|
      user = self.new(id: row[0].value,full_name: row[1].value, email: row[2].value, password: row[3].value, password_confirmation: row[4].value)
      next if self.pluck(:id).include?(user.id)
      user.save
    end
  end

end
