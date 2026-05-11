# frozen_string_literal: true

RSpec.describe 'Article', type: :model do
  let(:article) { Article.create! }

  after { Article.gate_keeper = nil }

  context 'when allowing admins to edit' do
    before do
      Article.class_eval do
        allows :edit,
               if: ->(_article, user) { user.admin }
      end
    end

    context 'when user is an admin' do
      let(:admin) { double('user', admin: true) }

      it 'can edit' do
        expect(article.allows(admin).to_edit?).to be true
      end
    end

    context 'when user is not an admin' do
      let(:non) { double('user', admin: false) }

      it 'cannot edit' do
        expect(article.allows(non).to_edit?).to be false
      end
    end

    context 'when adding a second rule allowing publishers to publish' do
      before do
        Article.class_eval do
          allows :publish,
                 if: ->(_article, user) { user.publisher }
        end
      end

      context 'when user is a publisher' do
        let(:publisher) { double('user', publisher: true) }

        it 'can publish' do
          expect(article.allows(publisher).to_publish?).to be true
        end
      end

      context 'when user is not a publisher' do
        let(:non) { double('user', publisher: false) }

        it 'cannot publish' do
          expect(article.allows(non).to_publish?).to be false
        end
      end

      context 'when user is an admin' do
        let(:admin) { double('user', admin: true) }

        it 'can still edit (rules accumulate)' do
          expect(article.allows(admin).to_edit?).to be true
        end
      end
    end
  end

  context 'when using unless: to block peons' do
    before do
      Article.class_eval do
        allows :edit,
               unless: ->(_article, user) { user.peon }
      end
    end

    context 'when user is a peon' do
      let(:peon) { double('user', peon: true) }

      it 'cannot edit' do
        expect(article.allows(peon).to_edit?).to be false
      end
    end

    context 'when user is not a peon' do
      let(:privileged) { double('user', peon: false) }

      it 'can edit' do
        expect(article.allows(privileged).to_edit?).to be true
      end
    end
  end

  context 'when checking a permission that does not exist' do
    let(:admin) { double('user', admin: true) }

    it 'raises NoMethodError' do
      expect do
        article.allows(admin).to_update?
      end.to raise_error(NoMethodError)
    end
  end

  context 'with a rule that is always true' do
    before do
      Article.class_eval do
        allows :edit,
               if: ->(_article, _user) { true }
      end
    end

    context 'when user is nil' do
      let(:user) { nil }

      it 'does not allow' do
        expect(article.allows(user).to_edit?).to be false
      end
    end
  end
end
