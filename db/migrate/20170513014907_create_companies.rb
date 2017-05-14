class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :username
      t.string :company_name
      t.string :company_email
      t.string :company_password_digest

      t.timestamps
    end
  end
end
