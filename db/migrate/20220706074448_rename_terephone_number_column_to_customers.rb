class RenameTerephoneNumberColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :terephone_number, :telephone_number
  end
end
