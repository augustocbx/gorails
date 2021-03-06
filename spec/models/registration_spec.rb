# == Schema Information
#
# Table name: registrations
#
#  id             :integer          not null, primary key
#  event_id       :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  presence       :boolean          default(FALSE)
#  certified_code :string
#
# Indexes
#
#  index_registrations_on_certified_code  (certified_code) UNIQUE
#

require 'rails_helper'

RSpec.describe Registration, type: :model do

  let(:user) { create :user_with_cpf }
  let(:event) { create :event }

  describe ".is_registrated?" do
    subject(:registrated) { event.is_registrated?(user.id) }

    context 'when user is registrate' do
      before(:each) do
        create :registration, user: user, event: event
      end

      it 'return true' do
        expect(registrated).to be_truthy
      end
    end

    context 'when user is not registrate' do
      it 'return false' do
        expect(registrated).to be_falsey
      end
    end
  end

  describe '.to_register' do
    it 'registration should be created' do
      event.to_register(user.id)
      expect(Registration.all.size).to eq 1
    end
  end
end
