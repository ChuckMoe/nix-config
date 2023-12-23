{ outputs, lib, config, ... }:
{
  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;
}
