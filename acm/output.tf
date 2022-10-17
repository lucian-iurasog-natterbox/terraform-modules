output "cert_arn" {
  description = "Certificate ARN."
  value       = aws_acm_certificate.this_cert.arn
}
output "cert_fqdn" {
  description = "Certificate FQDN."
  value       = aws_acm_certificate.this_cert.domain_name
}
output "cert_status" {
  description = "Certificate Status."
  value       = aws_acm_certificate.this_cert.status
}
output "cert_fqdn_zone_name" {
  description = "Domain Route 53 Zone Name."
  value       = data.aws_route53_zone.this_getzoneid_if_exists.name
}
output "cert_fqdn_zone_id" {
  description = "Domain Route 53 Zone ID."
  value       = data.aws_route53_zone.this_getzoneid_if_exists.id
}
