output "guardduty_id" {
  value = "${aws_guardduty_detector.guardduty.id}"
}
output "guardduty_account_id" {
  value = "${aws_guardduty_detector.guardduty.account_id}"
}
output "bucket_arn" {
  value = "${aws_s3_bucket.security.arn}"
}
