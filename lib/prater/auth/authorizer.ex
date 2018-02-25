defmodule Prater.Auth.Authorizer do
  def can_manage?(user, room) do
    user && user.id == room.user_id
  end
end
