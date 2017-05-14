class RenameCompanyPasswordDigestToPasswordDigest < ActiveRecord::Migration

  def change
    rename_column :companies, :company_password_digest, :password_digest
  end

end
