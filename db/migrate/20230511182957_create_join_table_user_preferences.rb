class CreateJoinTableUserPreferences < ActiveRecord::Migration[7.0]
  def change
    create_join_table :preferences, :users do |t|
      # t.index [:preference_id, :user_id]
      # t.index [:user_id, :preference_id]
    end
  end
end
