class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :password_digest, :email
end
