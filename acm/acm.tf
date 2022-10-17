################################################################################
# THE CERT TO VALIDATE
################################################################################
resource "aws_acm_certificate" "this_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
################################################################################
# THE CERT TO VALIDATE
################################################################################
################################################################################
# ROUTE 53 QUERY
################################################################################
data "aws_route53_zone" "this_getzoneid_if_exists" {
  name = format("%s.%s.", split(".", var.domain_name)[length(split(".", var.domain_name)) - 2], split(".", var.domain_name)[length(split(".", var.domain_name)) - 1])
}
################################################################################
# ROUTE 53 QUERY END
################################################################################
################################################################################
# ADD ROUTE 53 ACM RECORDS NECESARY FOR CERT VALIDATION
################################################################################
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for cv in aws_acm_certificate.this_cert.domain_validation_options : cv.domain_name => {
      name   = cv.resource_record_name
      record = cv.resource_record_value
      type   = cv.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this_getzoneid_if_exists.id
  records         = [each.value.record]
  ttl             = 60
}
################################################################################
# ADD ROUTE 53 ACM RECORDS NECESARY FOR CERT VALIDATION END
################################################################################
################################################################################
# BIND ROUTE 53 ACM RECORDS NECESARY FOR CERT VALIDATION  WITH THE CERT TO VALIDATE
################################################################################
resource "aws_acm_certificate_validation" "this_acm_cert_validation" {
  for_each = {
    for cv in aws_acm_certificate.this_cert.domain_validation_options : cv.domain_name => {}
  }
  certificate_arn         = aws_acm_certificate.this_cert.arn
  validation_record_fqdns = ["${aws_route53_record.cert_validation[each.key].fqdn}"]
}
################################################################################
# BIND ROUTE 53 ACM RECORDS NECESARY FOR CERT VALIDATION  WITH THE CERT TO VALIDATE END
################################################################################
