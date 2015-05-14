echo "please input smtp|pop3 host:"
read host
echo "please input sender email:"
read email
echo "please input username:"
read user
echo "please input password:"
read password

echo "defaults" > /etc/msmtprc
echo "tls on" >> /etc/msmtprc
echo "tls_starttls on" >> /etc/msmtprc
echo "tls_certcheck off" >> /etc/msmtprc
echo "syslog LOG_MAIL" >> /etc/msmtprc
echo "" >> /etc/msmtprc
echo "host $host" >> /etc/msmtprc
echo "from $email" >> /etc/msmtprc
echo "auth plain" >> /etc/msmtprc
echo "user $user" >> /etc/msmtprc
echo "password $password" >> /etc/msmtprc
