RSpec.describe 'Article', type: :model do

  let(:article) { Article.create! }

  context 'When allowing admins to edit' do
    before do
      Article.class_eval do
        allows :edit,
          if: -> (article, user) { user.admin }
      end
    end

    context 'an Admin' do
      let(:admin) { OpenStruct.new(admin: true) }

      it 'can edit' do
        expect( article.allows( admin ).to_edit? ).to be true
      end
    end

    context 'NON Admin' do
      let(:non) { OpenStruct.new(admin: false) }

      it 'can NOT edit' do
        expect( article.allows( non ).to_edit? ).to be false
      end
    end

    context 'Then adding another rule allowing publishers to publish' do
      before do
        Article.class_eval do
          allows :publish,
            if: -> (article, user) { user.publisher }
        end
      end

      context 'a Publisher' do
        let(:publisher) { OpenStruct.new(publisher: true) }

        it 'can publish' do
          expect( article.allows( publisher ).to_publish? ).to be true
        end
      end

      context 'NON Publisher' do
        let(:non) { OpenStruct.new(publisher: false) }

        it 'can NOT publish' do
          expect( article.allows( non ).to_publish? ).to be false
        end
      end

      context 'an Admin' do
        let(:admin) { OpenStruct.new(admin: true) }

        it 'can still edit' do
          expect( article.allows( admin ).to_edit? ).to be true
        end
        # Rules can be added cumulatively
      end
    end
  end

  context 'When allowing unless its a peon' do
    before do
      Article.class_eval do
        allows :edit,
          unless: -> (article, user) { user.peon }
      end
    end

    context 'a Peon' do
      let(:peon) { OpenStruct.new(peon: true) }

      it 'can NOT edit' do
        expect( article.allows( peon ).to_edit? ).to be false
      end
    end

    context 'NON Peon' do
      let(:privileged) { OpenStruct.new(peon: false) }

      it 'can edit' do
        expect( article.allows( privileged ).to_edit? ).to be true
      end
    end
  end

  context 'Trying to check a permission that does not exist' do
    let(:admin) { OpenStruct.new(admin: true) }

    it 'should raise NoMethodError' do
      expect {
        article.allows( admin ).to_update?
      }.to raise_error(NoMethodError)
    end
  end

  context 'A rule thats always true' do
    before do
      Article.class_eval do
        allows :edit,
          if: -> (article, user) { true }
      end
    end

    context 'passed a NIL user' do
      let(:user) { nil }

      it 'will NOT allow' do
        expect( article.allows( user ).to_edit? ).to be false
      end
    end
  end
end
