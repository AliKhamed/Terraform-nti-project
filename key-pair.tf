# secret manager 
resource "aws_secretsmanager_secret" "mysecret" {
  name                    = "mysecret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "mysecret-version" {
  secret_id = aws_secretsmanager_secret.mysecret.id
  # link your private key to your secret manager
  secret_string = tls_private_key.myprivatekey.private_key_pem
}

# tls generate key pair
# RSA key of size 4096 bits
resource "tls_private_key" "myprivatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "generated_key" {
  # key name represent the name of private key and publci key 
  key_name   = "aws-key"
  public_key = tls_private_key.myprivatekey.public_key_openssh
}