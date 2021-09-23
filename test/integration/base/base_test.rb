
apps = %w(qemu-guest-agent htop vim net-tools)

apps.each do |app|
  describe package(app) do
    it { should be_installed }
  end
end
