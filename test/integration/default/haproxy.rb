describe package('haproxy') do
  it { should be_installed }
end

describe file('/etc/haproxy/haproxy.cfg') do
  its('content') { should match(/user haproxy/) }
  its('content') { should match(/group haproxy/) }
  its('content') { should match(/log 127.0.0.1 local2/) }
  its('content') { should match(%r{bind 0.0.0.0:443 ssl crt /etc/haproxy/ssl/default.pem}) }
  its('content') { should match(/redirect scheme https if !{ ssl_fc }/) }
end

%w(ssl errors).each do |dir|
  describe directory("/etc/haproxy/#{dir}") do
    it { should exist }
  end
end

describe file('/etc/haproxy/ssl/default.pem') do
  its('content') { should match(/-----BEGIN CERTIFICATE-----/) }
end

describe file('/etc/haproxy/errors/503.http') do
  its('content') { should match(/No backend servers are currently available/) }
end

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end
