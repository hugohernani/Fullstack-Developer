require 'rails_helper'

describe SaleNotificationObserver do
  let(:notification) { create(:notification, :with_template, template_internal_name: 'base_layout') }
  let(:observer) { described_class.new }

  context 'notification by email', job: true do
    it 'sends the notification by email when the recipient is able to receive it' do
      Sidekiq::Testing.inline! do
        expect{
          observer.update(notification)
        }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
