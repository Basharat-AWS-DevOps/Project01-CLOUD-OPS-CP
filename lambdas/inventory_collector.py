import boto3
import json
import os
from datetime import datetime

ec2 = boto3.client("ec2")
iam = boto3.client("iam")
s3 = boto3.client("s3")

BUCKET = os.environ["INVENTORY_BUCKET"]

def lambda_handler(event, context):
    timestamp = datetime.utcnow().isoformat()

    instances = ec2.describe_instances()
    volumes = ec2.describe_volumes()
    snapshots = ec2.describe_snapshots(OwnerIds=["self"])
    users = iam.list_users()

    instance_count = sum(
        len(reservation["Instances"])
        for reservation in instances["Reservations"]
    )

    summary = {
        "timestamp": timestamp,
        "ec2_instances": instance_count,
        "ebs_volumes": len(volumes["Volumes"]),
        "snapshots": len(snapshots["Snapshots"]),
        "iam_users": len(users["Users"]),
    }

    key = f"inventory/{timestamp}.json"

    s3.put_object(
        Bucket=BUCKET,
        Key=key,
        Body=json.dumps(summary, indent=2),
        ContentType="application/json"
    )

    print("Inventory written to S3:", key)

    return {
        "status": "success",
        "s3_key": key,
        "summary": summary
    }

