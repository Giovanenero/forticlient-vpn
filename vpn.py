import pexpect
import sys
from dotenv import load_dotenv
import os

load_dotenv()
name = sys.argv[1]
name = name.upper()

SERVER = os.getenv("SERVER_{}".format(name))
USER = os.getenv("USER_{}".format(name))
PASSWORD = os.getenv("PASSWORD_{}".format(name))

print("Starting {} VPN".format(name))
process = pexpect.spawn(f"/opt/forticlient-sslvpn/64bit/forticlientsslvpn_cli --server {SERVER} --vpnuser {USER} --keepalive")
process.expect("Password for VPN")
process.sendline(PASSWORD)
process.expect("Would you like to connect to this server")
process.sendline("y")
process.wait()

