class User < ActiveRecord::Base
  # has-secure_password does the following:
  # 1 - it adds attribute accessors: password and password_confirmation
  # 2 - it adds validation: password must be present on creation
  # 3 - if password confirmation is present, it will make sure its equal to password
  # 4 - PAssword length should be less than or equal to 72 chars
  # 5 - it will has the password using bcrypt and stores the has digest in the
  #      password digets field
  has_secure_password

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :votes, dependent: :destroy

  # we use the source option in here because we used "liked_questions"
  # instead of "questions". You dont want to have two "has many questions".
  has_many :liked_questions, through: :likes, source: :question
  has_many :voted_questions, through: :votes, source: :question

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_password_reset_data
    generate_password_reset_token
    self.password_reset_requested_at = Time.now
    save
  end

  def password_reset_expired?
    password_reset_requested_at <= 60.minutes.ago
  end

  private

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.hex(32)
    end while User.exists?(password_reset_token: self.password_reset_token)
  end
end
