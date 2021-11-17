require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe  'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'name,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birthdday_idが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'last_name_kanaとfirst_name_kanaがカタカナであれば登録できる' do
        @user.last_name_kana = 'ア'
        @user.first_name_kana = 'ウン'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it "emailが'@'を含まない場合登録できない" do
        @user.email = 'test.test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが6文字以上でないと登録できない' do
        @user.password = 'aaaa'
        @user.password_confirmation = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'passwordは半角英数字混合でないと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数を両方含む必要があります'
      end
      it 'passwordは半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数を両方含む必要があります'
      end
      it 'passwordは全角文字を含んでいてはいけない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数を両方含む必要があります'
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'last_nameは漢字,ひらがな,カタカナでないと登録ができない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name は漢字,カタカナ,ひらがなを含む必要があります'
      end
      it 'first_nameは漢字,ひらがな,カタカナでないと登録ができない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name は漢字,カタカナ,ひらがなを含む必要があります'
      end
      it 'last_name_kanaはカタカナでないと登録ができない' do
        @user.last_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana はカタカナである必要があります'
      end
      it 'first_name_kanaはカタカナでないと登録ができない' do
        @user.first_name_kana = 'bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana はカタカナである必要があります'
      end
      it '生年月日が空では登録できない' do
        @user.birthday_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
    end
  end
end
