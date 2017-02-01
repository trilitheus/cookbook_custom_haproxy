#
# Cookbook Name:: custom_haproxy
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_haproxy::haproxy' do
  context 'When all attributes are default on RHEL family' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node, server|
        node.automatic['os'] = 'linux'
        node.automatic['platform_family'] = 'rhel'
        node.automatic['virtualization']['system'] = 'docker'
        node.chef_environment = 'kitchen'
        server.create_environment('kitchen', override_attributes: { haproxy: { frontends: { http: { default_80: { listen: '0.0.0.0', port: '80', acls: ['host-default hdr(host) -i localhost'], use_backend: ['default if host-default'] } }, https: { default_443: { listen: '0.0.0.0', port: '443', certbagitem: 'default_pem', certfile: 'default.pem', acls: ['host-default hdr(host) -i localhost'], use_backend: ['default if host-default'] } } }, backends: { default: { redirect_to_ssl: true, app_server: { default: '127.0.0.1:81' } } } } })
        server.create_data_bag('kitchen_certs',
                               'default_pem' => {
                                 'content' => '-----BEGIN CERTIFICATE-----\nMIIEEjCCAvqgAwIBAgIJANchDsiOwdkFMA0GCSqGSIb3DQEBBQUAMGMxCzAJBgNV\nBAYTAlVLMRAwDgYDVQQIEwdLaXRjaGVuMQ0wCwYDVQQHEwRUZXN0MREwDwYDVQQK\nEwhTbmFrZU9pbDEMMAoGA1UECxMDV2ViMRIwEAYDVQQDEwlsb2NhbGhvc3QwHhcN\nMTYwODE2MTM1NzQyWhcNMjYwODE0MTM1NzQyWjBjMQswCQYDVQQGEwJVSzEQMA4G\nA1UECBMHS2l0Y2hlbjENMAsGA1UEBxMEVGVzdDERMA8GA1UEChMIU25ha2VPaWwx\nDDAKBgNVBAsTA1dlYjESMBAGA1UEAxMJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0B\nAQEFAAOCAQ8AMIIBCgKCAQEAyr688zIy8ST2Rq98hH4oSndIKvZVVZ1vuyQtC+1D\n4moS28UsdrjWQhThY3AnKj7qegP9SmjoZRfoGEF9DOtDdkYZaj2xs4OWAP50Psnc\n8lCLpqXHmeeGBw64LGExn/V0HLU7xvrd+/nk+cBY3eSe2bl+mAYNrVX3LGpI4h7/\nlQ4oQhT64H8FmNKO/7oXI+BwJUwclt2aUkgqWbHD8fJ7OXN2eUTGxCMp8jS6fVcA\nnahi5cE9Ur3SN3f9gur8LV9aE+oAEAxfrPyHIIbuVBYvXNNSZEi1QqQhbC+PkGtU\nwyzFThTQG+LyYxf8VfZqi9dES2BIllIafQN0uGeLw7YLuwIDAQABo4HIMIHFMB0G\nA1UdDgQWBBTvP5D1W0IjRUB8BhcAJRCzQuW9ZTCBlQYDVR0jBIGNMIGKgBTvP5D1\nW0IjRUB8BhcAJRCzQuW9ZaFnpGUwYzELMAkGA1UEBhMCVUsxEDAOBgNVBAgTB0tp\ndGNoZW4xDTALBgNVBAcTBFRlc3QxETAPBgNVBAoTCFNuYWtlT2lsMQwwCgYDVQQL\nEwNXZWIxEjAQBgNVBAMTCWxvY2FsaG9zdIIJANchDsiOwdkFMAwGA1UdEwQFMAMB\nAf8wDQYJKoZIhvcNAQEFBQADggEBAATM3PTT7+YgIn1RlRw26YhAxwDgQGPdFK2d\n0HXpIFUqe0DbwOaTtAay2030iW63rMasDRj2ceipx9oOt5c8VtOK/1p7uYa5ATG/\n0omaaSegbxx95btVH9IRu/pNSWnqz9cA6OHOBm8u9NUHqU/ucSgKBsSlp/XwHI1q\nbevTaVT1gHkcrnqN6qhr1/TFcSB88JFNECXdxtYlLYfey5/wLeruTTf0kBLiFAHn\nInIr8aqCSD9asLDUNSLXeDMDNtujXkGFozLmwmtFMBV7F+lV3lJyLfI5/0zhZNZe\nMxA9annlBvNUWqoNFsm0rZ8WKOf+iJCbZu4P7AlV+zDVzamQ5lA=\n-----END CERTIFICATE-----\n-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAyr688zIy8ST2Rq98hH4oSndIKvZVVZ1vuyQtC+1D4moS28Us\ndrjWQhThY3AnKj7qegP9SmjoZRfoGEF9DOtDdkYZaj2xs4OWAP50Psnc8lCLpqXH\nmeeGBw64LGExn/V0HLU7xvrd+/nk+cBY3eSe2bl+mAYNrVX3LGpI4h7/lQ4oQhT6\n4H8FmNKO/7oXI+BwJUwclt2aUkgqWbHD8fJ7OXN2eUTGxCMp8jS6fVcAnahi5cE9\nUr3SN3f9gur8LV9aE+oAEAxfrPyHIIbuVBYvXNNSZEi1QqQhbC+PkGtUwyzFThTQ\nG+LyYxf8VfZqi9dES2BIllIafQN0uGeLw7YLuwIDAQABAoIBAQC2/twrIkcqszL6\n8BASwo/5Tpq79GVnhle/8VIbbseUCCwHY3vTmNgDAzfAeg1Pq0QWZ51qWTBRdveN\nVSbaz0qv6WutIgxPvFhbg1BHEAq2SA8UlpOHjZrCqf2ASSXyfCiWdNqEqhBNC+wp\npPxRI7ZhTHVAIE6eAna8Bx7LwjDsRiQ24fsEotkJBhmelR1QJm71u9FFzdYGD9+s\nnJsKciGEux6PlGx2v7b4Hr7Fxxf9LtlUyV8RSRYz2UmQ3OQfITJCNaCQDacmokAg\nxLq1Izcm2LQitPWOU6nuc3D5hFXvlFt7T92p8FR/7dNNuhLdrbk+JFca5J0H9Snt\nO03PMAppAoGBAO99t2Kiz00o9uenVwMR/LbZdOvZcT+bzTvehI9Mo11M1UpII6Pn\nBocuet3CFIwZ4VC0nuXjzmU6gsp3P/jveRGgWH/j7ff6SolpvbApCoo8KjDmMSkm\noo/yd62b9T6WFfkJI+YH/83ed5GCaXzIdMKXcfTtFQ2BclJ1VGS2e3G3AoGBANi4\nkTmtPmC6DpALxP6Sn8t43P1T6Xh74f1ag4Y6Zk88QkV4vsq+1YX0kx7e0Sn+bVL2\nd+OVw2SbA589Kr4DzWRzRkodnHaTXE1tTAnnATj3yjiQ/sdExc4bXOO/Lk3vc6rF\nAJgM13o5Unti5bOYSVHGA59lWIYO1m0VO/M97yYdAoGBAMgDiLsaGmPoyHykJ2lr\nBlJ3vsyS56AmMPvFVZSQfweW+bN2GD303mDcEsVOJ/byTlkm4GZDIcctXLpXadgv\nuD9eWUtGQyKNqN6mr0OGo0TcBqicN4aUu8PYztbxn5rLokJAvfiJybxYBihCcHNE\nvy8daJETyDdlWuM/FmKefO51AoGBALY73MInD0C+suglPWzjVkL+SrUqDjQl1432\nwonoKYePIBrSwXwyo9GUKvHWYwNw0fTlE0Ln9/ls78rC4GIPSHKjDAPeimaa2w6w\nTTQ2byy8D+so4VQmXD5HfAB2DjWymAyMw0cX5Uj9UoI2UviFoYGFhB5QVfPEHkJz\njImpFqNxAoGAS2V23B8r1+uvz0loOdsoNpr8MTUcO3f8o70nxtGDKVrPaVABICT4\ngJRGP3FH3blMGEhn9B3KOSLkI480IaYloswQ6RLfTy+b9TPYRW1Uh6ArUhqFxFFD\n6XGF8e+P0IBP9BsvZwbo61UZV52PoSuAPXTl1yYIvVb2PfcWLvIY7Tc=\n-----END RSA PRIVATE KEY-----'
                               })
      end.converge(described_recipe)
    end

    before do
      stub_command("semodule -l | grep haproxy_restart").and_return(false)
    end

    it 'creates the cookbook_file /tmp/haproxy_restart.pp' do
      expect(chef_run).to create_cookbook_file('/tmp/haproxy_restart.pp')
    end

    it 'installs the haproxy_restart semodule' do
      expect(chef_run).to run_bash('install haproxy_restart semodule')
    end

    it 'installs the haproxy package' do
      expect(chef_run).to install_package('haproxy')
    end

    it 'renders haproxy config' do
      expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content { |content|
        expect(content).to match(/user haproxy/)
        expect(content).to match(/group haproxy/)
        expect(content).to match(/log 127.0.0.1 local2/)
        expect(content).to match(%r{bind 0.0.0.0:443 ssl crt /etc/haproxy/ssl/default.pem})
        expect(content).to match(/redirect scheme https if !{ ssl_fc }/)
      }
    end

    %w(ssl errors).each do |dir|
      it "creates the /etc/haproxy/#{dir} directory" do
        expect(chef_run).to create_directory("/etc/haproxy/#{dir}")
      end
    end

    it 'renders the pem file' do
      expect(chef_run).to render_file('/etc/haproxy/ssl/default.pem').with_content(/-----BEGIN CERTIFICATE-----/)
    end

    it 'renders the 503 error file' do
      expect(chef_run).to render_file('/etc/haproxy/errors/503.http').with_content(/No backend servers are currently available/)
    end

    it 'enables the haproxy service' do
      expect(chef_run).to enable_service('haproxy')
    end

    it 'starts the haproxy service' do
      expect(chef_run).to start_service('haproxy')
    end
  end
end
