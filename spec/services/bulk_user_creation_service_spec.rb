require 'rails_helper'

describe BulkUserCreationService do
  subject(:service) { described_class.new(bulk_upload: bulk_upload) }

  let(:bulk_upload){ create(:bulk_upload) }
  let(:rows_amount){ 30 }

  let(:observer_instance){ instance_double('userBulkProcessingObserver', update: nil) }
  let(:observer_klass){ class_double('UserBulkProcessingObserver', new: observer_instance) }

  before do
    stub_const('UserBulkProcessingObserver', observer_klass)
  end

  context 'with mocked Spreadsheet' do
    let(:sheet){ instance_double('sheet', last_row: rows_amount, each_row_streaming: []) }
    let(:roo_spreadsheet_klass){ class_double('Roo::Spreadsheet', open: sheet) }

    before do
      stub_const('Roo::Spreadsheet', roo_spreadsheet_klass)
    end

    it 'calls observer methods' do
      expect(service).to receive(:changed)
      expect(service).to receive(:notify_observers).with(rows_amount)

      service.perform(offset: 1, max_rows: rows_amount)

      expect(observer_klass).to have_received(:new).with(bulk_upload: bulk_upload, sheet_size: a_value)
    end

    it 'calls perform recursivally' do
      max_rows = 10
      expect(sheet).to receive(:each_row_streaming).with(pad_cells: true, offset: a_value, max_rows: a_value)
                                                   .exactly(rows_amount / max_rows).times

      service.perform(offset: 1, max_rows: max_rows)
    end
  end

  context 'with user creation' do
    it 'creates some users' do
      expect do
        service.perform(offset: 1, max_rows: rows_amount)
      end.to change(User, :count)
    end

    it 'logs errors when user creation fails' do
      expect(Rails.logger).to receive(:warn).at_least(2).times

      service.perform(offset: 1, max_rows: rows_amount)
    end
  end
end
