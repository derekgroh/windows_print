# InSpec test for recipe windows_print::distributed_scan_server

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.release < '10.0.17763'
  describe windows_feature('Print-Scan-Server') do
    it { should be_installed }
  end
end
