class ChangeRolesRoleNameAttributeNameToName < ActiveRecord::Migration[7.0]
  def change
    rename_column :roles, :RoleName, :name 
  end
end
