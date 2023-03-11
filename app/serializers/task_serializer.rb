class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :descrip, :done
  has_one :user
end
