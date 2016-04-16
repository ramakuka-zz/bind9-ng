require 'serverspec'
set :backend, :exec

if os[:family] == 'redhat'
  daemon = 'named'
elsif ['debian', 'ubuntu'].include?(os[:family])
  daemon = 'bind9'
end

describe 'Bind9 Daemon' do

  it 'is enabled' do
    expect(service(daemon)).to be_enabled
  end

  it 'is running' do
    expect(service(daemon)).to be_running
  end

  it 'is listening on port 53/udp' do
    expect(port(53)).to be_listening.with('udp')
  end

  it 'is listening on port 53/tcp' do
    expect(port(53)).to be_listening.with('tcp')
  end

  it 'is listening on port 953/tcp' do
    expect(port(953)).to be_listening.with('tcp')
  end

end
