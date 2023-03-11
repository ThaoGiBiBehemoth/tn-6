class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :password_digest, :email
  has_many :tasks
end
