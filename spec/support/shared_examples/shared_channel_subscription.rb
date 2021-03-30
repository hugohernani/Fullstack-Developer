RSpec.shared_examples 'allowed logged in connection' do
  before do
    stub_connection current_user: logged_in_user
  end

  it 'confirms subscription succeeded' do
    subscribe

    expect(subscription).to be_confirmed
  end

  it 'subscribes to a user stream' do
    subscribe

    expect(subscription).to have_stream_for(logged_in_user)
  end
end
