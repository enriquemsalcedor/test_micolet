class User < ApplicationRecord
  has_and_belongs_to_many :preferences
  validates :email, :presence => {:message => I18n.t("activerecord.attributes.user.message.presence")}, 
  :uniqueness => {:message => I18n.t("activerecord.attributes.user.message.uniqueness")}
  validates :preferences, :presence => {:message => I18n.t("activerecord.attributes.user.message.preferences")}
  validates_email_format_of :email, :message => I18n.t("activerecord.attributes.user.message.format")

  after_create :validate_email

  def validate_email
    #consumo de api para validar email correcto
    url = 'https://emailvalidation.abstractapi.com/v1/?api_key=e8441b3ec5b14d66b48d25e3291c19c9&email=' << self.email
    response = RestClient.get(url)
    results = JSON.parse(response.to_str)
    quality_score = results['quality_score']
    puts "quality_score: #{quality_score}"
    @user = self
    if quality_score.to_f > 0.7
      UserMailer.mail_subscription(@user).deliver
    end

  end

end

