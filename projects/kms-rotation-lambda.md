# KMS Key Rotation Lambda

## Overview
Built a Lambda function to automate 90-day key rotation for KMS keys without immediate deletion of old keys.

## Features
- SSM logging of new key metadata (KeyId, timestamp)
- CloudWatch monitoring with failure alerts
- Tagging for traceability
- Slack/Mattermost alerting integrated
