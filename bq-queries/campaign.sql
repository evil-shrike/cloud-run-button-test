CREATE OR REPLACE VIEW `{dst_dataset}.campaign` AS
SELECT
  C.*
FROM `{ads_dataset}.campaign_settings` AS C
