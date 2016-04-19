class Question < ActiveRecord::Base

  # Reference the record with a colon and pluralized
  # putting dependent: lets us either :destroy all the answers with the question <-- DELETE
  # or :nullify the answers that changes the reference id to null                <-- MAKE NULL
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, uniqueness: {message: "Must be unique dum dum."}

  validates :body, length: {minimum: 5}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # This makes sure that the title body combo is unique but they can repeat on their own
  validates :title, uniqueness: {scope: :body}

  validate :no_monkey

  after_initialize :set_defaults

  before_validation :titleize_title

  scope :recent_three, lambda { order("created_at DESC").limit(3) }
  # def self.recent_three
  #   order("created_at DESC").limit(3)
  # end



  def self.search(string)
    where(["title ILIKE ? OR body ILIKE ?", "%#{string}%", "%#{string}%"])
    # where(["first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{string}%", "%#{string}%", , "%#{string}%"])
    # where([price BETWEEN 100 AND 300 ORDER BY name, LIMIT 10])
    # where([first_name NOT ILIKE "john" OR last_name NOT ILIKE "john"])
    # where([created_at > time])
    # where([first_name NOT ILIKE "john" OR last_name NOT ILIKE "john"])

  end

  # scope :recent, lambda { order("created_at DESC") }


  def user_full_name
    user ? user.full_name : ""
  end

  private

  # def delete_warning
  #
  # end

  # scope

  # before_validation :validaterrr
  # def validaterrr
  #   if name.present? && name.unique? && name != "apple, microsoft, sony" # <-- rewrite that
  #   end
  # end

  # before_validation :validaterr
  # def validaterr
  #   if !name.present? && (price < 0 || price > 1000)
  #     errors.add(:name, "Jon snow is a liar")
  #     errors.add(:name, "Jon snow is a liar") <-- this one is for the price error
  #   end
  # end


  def titleize_title
    self.title = title.titleize
  end

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkey business here")
    end
  end
end
