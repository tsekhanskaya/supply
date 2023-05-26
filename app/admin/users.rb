ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :user_restaurant, :user_brand, :admin

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :user_restaurant
      f.input :user_brand
      f.input :admin
      f.input :encrypted_password, as: :string, input_html: { readonly: true }
    end
    f.actions
  end
end
